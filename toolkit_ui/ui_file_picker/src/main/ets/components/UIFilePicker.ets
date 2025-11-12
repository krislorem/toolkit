import { AvoidAreaCallback, AvoidAreaInfo, UIBase } from '@krislorem/ui-base';
import { Logger } from '@krislorem/toolkit_core';
import { fileIo as fs, picker } from '@kit.CoreFileKit';
import { common } from '@kit.AbilityKit';
import { BusinessError, request } from '@kit.BasicServicesKit';
import { connection } from '@kit.NetworkKit';
import { CommonConstants, FileLayoutMode, FileMediaType, FileSizeType, SelectBtnType, } from '../common/Constants';
import { FileModel, IBtnOption, ICloudStorageOption, IFileModel, IListOption, IPackingOption } from '../common/Models';
import {
  getFileBufferByUri,
  getPixelByBuf,
  getProcessedStr,
  getSizeStr,
  selectMedia,
  StorageBucket,
} from '../common/Utils';

@ComponentV2
export struct UIFilePicker {
  /**
   * 初始传入的文件数据
   */
  @Once @Param initFiles: IFileModel[] = [];
  /**
   * 组件只读，不显示选择，不显示进度，不显示删除，不显示文件大小
   */
  @Param readonly: boolean = false;
  /**
   * 禁止预览
   */
  @Param disablePreview: boolean = false;
  /**
   * 展示删除按钮
   */
  @Param showDelIcon: boolean = true;
  /**
   * 云存储选项
   */
  @Once @Param cloudStorageOption: ICloudStorageOption = {
    autoUpload: false,
  };
  /**
   * 文件数量限制
   */
  @Param fileNumLimit: number = CommonConstants.MAX_FILE_NUM_LIMIT_DEFAULT;
  /**
   * 显示模式，列表/栅格
   */
  @Once @Param mode: FileLayoutMode = FileLayoutMode.GRID;
  /**
   * 文件媒体类型，图片/视频
   */
  @Param fileMediaType: FileMediaType = FileMediaType.IMAGE;
  /**
   * 图片打包选项
   */
  @Param packingOption: IPackingOption = {
    type: FileSizeType.ORIGINAL,
    format: CommonConstants.COMPRESSED_IMAGE_FORMAT_DEFAULT,
    quality: CommonConstants.COMPRESSED_IMAGE_QUALITY_DEFAULT,
  };
  /**
   * 按钮选项
   */
  @Param btnOption: IBtnOption = {
    type: SelectBtnType.SIMPLE,
    label: $r('app.string.select_btn_text'),
    subLabel: $r('app.string.select_btn_sub_text'),
  };
  /**
   * 列表选项
   */
  @Param listOption: IListOption = {
    processBarColor: $r('sys.color.ohos_id_color_emphasize'),
    showFileIcon: true,
    listHeight: CommonConstants.LIST_MODE_SCROLLER_HEIGHT,
  };
  /**
   * 是否显示当前选择的数量和上限值
   */
  @Param showLimit: boolean = true;
  /**
   * 自定义提示语
   */
  @Once @Param customSelectTip: ResourceStr = '';
  @Local fileList: FileModel[] = [];
  @Local isPreview: boolean = false;
  @Local isShowStatusBar: boolean = true;
  @Local curClickIndex: number = 0;
  @Local statusH: number = 0;
  private window = UIBase.getWindow();
  private storageInstance = new StorageBucket(this.cloudStorageOption.bucketName, this.cloudStorageOption.cloudOptions);
  // 创建NetConnection对象
  private netCon: connection.NetConnection = connection.createNetConnection();

  @Computed
  get isReachLimit() {
    return this.fileList.length >= this.fileNumLimit;
  }

  @Computed
  get maxMediaNum() {
    return this.fileNumLimit - this.fileList.length;
  }

  @Computed
  get isCompress() {
    return this.packingOption.type === FileSizeType.PACKING && this.fileMediaType === FileMediaType.IMAGE;
  }

  @Computed
  get isShowDelIcon() {
    if (this.readonly) {
      return false;
    }
    if (!this.showDelIcon) {
      return false;
    }
    return true;
  }

  /**
   * 每次选择后的回调
   */
  @Event onSelect: (files: IFileModel[]) => void = () => {
  };

  /**
   * 删除文件后的回调
   */
  @Event onDelete: (file: IFileModel) => void = () => {
  };

  /**
   * 当前已选文件列表发生变化的回调
   */
  @Event onChange: (files: IFileModel[]) => void = () => {
  };

  /**
   * 上传过程中
   */
  @Event onProcess: (file: IFileModel, progress: request.agent.Progress) => void = () => {
  };

  /**
   * 上传成功
   */
  @Event onSuccess: (file: IFileModel, progress: request.agent.Progress) => void = () => {
  };

  /**
   * 上传失败
   */
  @Event onFail: (file: IFileModel, progress: request.agent.Progress) => void = () => {
  };

  @Monitor('readonly','disablePreview','showDelIcon')
  onStrChange(monitor: IMonitor) {
    monitor.dirty.forEach((path: string) => {
      console.log(`${path} changed from ${monitor.value(path)?.before} to ${monitor.value(path)?.now}`);
      if ((this.readonly || !this.showDelIcon) && this.disablePreview) {
        this.fileList.forEach((file) => {
          file.setShowMask(false);
        })
      }
    })
  }

  aboutToAppear(): void {
    // 处理用户输入
    this.handleCustomSetting();
    // 获取顶部状态栏高度
    this.statusH = this.getStatusH();
    // 监听状态栏高度
    UIBase.onAvoidAreaChange(this.avoidAreaChangeWatch);
    if (this.cloudStorageOption.autoUpload) {
      // 预先获得云存储实例
      this.storageInstance.queryBucket();
      // 监听网络断连
      this.OnNetChange();
    }
  }

  aboutToDisappear(): void {
    if (this.cloudStorageOption.autoUpload) {
      // 使用unregister接口取消订阅
      this.netCon.unregister((error: BusinessError) => {
        Logger.error('netCon unregister error:' + JSON.stringify(error));
      });
    }
    UIBase.offAvoidAreaChange(this.avoidAreaChangeWatch);
  }

  avoidAreaChangeWatch = (data: AvoidAreaCallback) => {
    const resp = AvoidAreaInfo.handle(data);
    this.statusH = resp?.top || 0;
  };

  OnNetChange() {
    // 先使用register接口注册订阅事件
    this.netCon.register((error: BusinessError) => {
      Logger.error('netCon register error:' + JSON.stringify(error));
    });

    // 订阅网络可用事件
    this.netCon.on('netAvailable', (data: connection.NetHandle) => {
      Logger.info('on netAvailable, Succeeded to get data: ' + JSON.stringify(data));
      this.storageInstance.reQueryBucket();
    });

    // 订阅网络丢失事件
    this.netCon.on('netLost', (data: connection.NetHandle) => {
      Logger.info('on netLost, Succeeded to get data: ' + JSON.stringify(data));
      this.storageInstance.clearBucket();
    });
  }

  handleCustomSetting() {
    // 初始化已有文件数据
    this.fileList = this.initFiles.map(v => {
      const file = new FileModel(v);
      file.setInitFlag(true);
      return file;
    });
    // 仅图片支持栅格显示、重新打包
    if (this.fileMediaType !== FileMediaType.IMAGE) {
      this.mode = FileLayoutMode.LIST;
    }
    if (!this.customSelectTip) {
      getContext()
        .resourceManager
        .getPluralStringByName('select_files_limit_tip', this.fileNumLimit)
        .then((value: string) => {
          this.customSelectTip = value;
        })
    }
  }

  getStatusH() {
    const data = AvoidAreaInfo.getAvoidAreaOnce();
    if (data?.top) {
      return data?.top;
    }
    return 0;
  }

  handleUploadError(file: FileModel) {
    const progress: request.agent.Progress = {
      index: 0,
      processed: 0,
      sizes: [file.sizes],
      state: request.agent.State.FAILED,
    };
    file.setProcessed(progress);
    this.onFail(file, progress);
  }

  autoUploadFile(file: FileModel) {
    const bucketInstance = this.storageInstance.getBucket();
    Logger.info(`[autoUploadFile] getBucket: ${JSON.stringify(bucketInstance)}`);
    if (!bucketInstance) {
      Logger.warn('storageInstance is empty, cancel auto upload');
      this.handleUploadError(file);
      return;
    }
    if (!file.uri) {
      Logger.warn('file uri is empty, cancel auto upload');
      return;
    }
    let fileName = file.name;
    // 本地文件路径，context.cacheDir目录下的文件
    let cacheFile = `${Date.now()}_${fileName}`;
    let cacheFilePath = getContext().cacheDir + '/' + cacheFile;

    // 将选中文件copy至cache目录下，文件名为cacheFile
    let dstFile: fs.File | null = null;
    try {
      dstFile = fs.openSync(cacheFilePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      fs.writeSync(dstFile.fd, file.buffer);
    } catch (e) {
      Logger.error(`copy file failed ${e.message}`);
      return;
    } finally {
      fs.closeSync(dstFile);
    }

    // 云侧路径
    const cloudPath: string = (this.cloudStorageOption.dirName ?? '') + fileName;
    Logger.info('cloudPath is: ' + cloudPath);

    // 上传至云存储默认实例
    bucketInstance.uploadFile(getContext(this), {
      localPath: cacheFile,
      cloudPath: cloudPath,
    }).then((task: request.agent.Task) => {
      file.setTask(task);
      task.on('progress', (progress) => {
        Logger.info(`on progress ${JSON.stringify(progress)}`);
        // 断网后，还会再执行一遍，防止失败的状态被覆盖
        if (file.uploadStatus !== request.agent.State.FAILED) {
          file.setProcessed(progress);
          this.onProcess(file, progress);
        }
      });
      task.on('completed', (progress) => {
        Logger.info(`on completed ${JSON.stringify(progress)}`);
        file.setProcessed(progress);
        file.setTask(undefined);
        bucketInstance?.getDownloadURL(cloudPath).then((url: string) => {
          Logger.info(`getDownloadURL, url: ${url}`);
          file.setUrl(url);
          this.onSuccess(file, progress);
        }).catch((e: BusinessError) => {
          Logger.error('getDownloadURL fail, error:' + JSON.stringify(e));
          this.onSuccess(file, progress);
        });
      });
      task.on('failed', (progress) => {
        Logger.error(`on failed ${JSON.stringify(progress)}`);
        file.setProcessed(progress);
        this.onFail(file, progress);
      });
      task.on('response', (response) => {
        Logger.info(`on response ${JSON.stringify(response)}`);
      });

      task.start((err: BusinessError) => {
        if (err) {
          Logger.error(`Failed to start the uploadFile task, Code: ${err.code}, message: ${err.message}`);
        } else {
          Logger.info(`Succeeded in starting a uploadFile task.`);
        }
      });
    }).catch((err: BusinessError) => {
      Logger.error(`uploadFile failed, Code: ${err.code}, message: ${err.message}`);
      this.handleUploadError(file);
    });
  }

  autoDeleteFile(file: FileModel) {
    const bucketInstance = this.storageInstance.getBucket();
    if (!bucketInstance) {
      Logger.warn('storageInstance is null, cancel auto delete');
      return;
    }
    // 如果任务存在，表示未上传成功，删除上传任务
    if (file.task) {
      request.agent.remove(file.task.tid).then(() => {
        Logger.info('success remove task, tid=' + file?.task?.tid);
      }).catch((err: BusinessError) => {
        Logger.error(`fail remove task, tid=${file?.task?.tid}, error=${JSON.stringify(err)}`);
      });
      return;
    }

    if (!file.name) {
      Logger.warn('file name is empty, cancel auto delete');
      return;
    }
    const cloudPath: string = (this.cloudStorageOption.dirName ?? '') + file.name;
    // 删除云存储默认实例中screenshot_xxx.jpg文件
    bucketInstance.deleteFile(cloudPath).then(() => {
      Logger.info(`deleteFile ${cloudPath} successfully`);
    }).catch((err: BusinessError) => {
      Logger.error(`deleteFile ${cloudPath} failed, Code: ${err.code}, message: ${err.message}`);
    });
  }

  changeSuffix(fileName: string, format: string) {
    try {
      const list = fileName.split('.');
      list.pop();
      const suffix = format.split('/').pop() as string;
      list.push(suffix);
      return list.join('.');
    } catch (e) {
      return fileName;
    }
  }

  handleUris(uris: string[]) {
    const selectFiles: Promise<FileModel>[] = uris.map(async uri => {
      const buf: ArrayBuffer | undefined =
        await getFileBufferByUri(uri, this.isCompress, this.packingOption);
      let pixel: PixelMap | undefined = undefined;
      if (buf && this.fileMediaType === FileMediaType.IMAGE) {
        pixel = await getPixelByBuf(buf);
      }
      let name = uri.split('/').pop() as string;
      if (this.isCompress) {
        name = this.changeSuffix(name, this.packingOption.format || CommonConstants.COMPRESSED_IMAGE_FORMAT_DEFAULT);
      }
      const fileModel = new FileModel({
        uri,
        name: decodeURIComponent(name),
        buffer: buf,
        pixelMap: pixel,
      });
      this.fileList.push(fileModel);
      if (this.cloudStorageOption.autoUpload) {
        this.autoUploadFile(fileModel);
      }
      return fileModel;
    });

    return Promise.all(selectFiles);
  }

  async select() {
    let uris: string[] = [];
    if (this.fileMediaType === FileMediaType.ALL) {
      uris = await this.selectDoc();
    } else if (this.fileMediaType === FileMediaType.AUDIO) {
      uris = await this.selectAudio();
    } else {
      uris = await selectMedia(this.maxMediaNum, this.fileMediaType);
    }
    const selectFiles = await this.handleUris(uris);
    if (selectFiles.length) {
      this.onSelect(selectFiles);
      this.onChange(this.fileList);
    }
  }

  deleteFile(file: FileModel) {
    if (this.cloudStorageOption.autoUpload) {
      this.autoDeleteFile(file);
    }
    this.onDelete(file);
    const index = this.fileList.findIndex(v => v.id === file.id);
    this.fileList.splice(index, 1);
    this.onChange(this.fileList);
    // 文件全部删除后，需要退出全屏模式
    if (this.isPreview && this.fileList.length === 0) {
      this.quitFullScreen();
    }
  }

  reUpload(file: FileModel) {
    if (!this.storageInstance.getBucket()) {
      Logger.warn('unable to reUpload, storageInstance.getBucket is null.');
      return;
    }
    Logger.info('reUpload start.');
    const progress: request.agent.Progress = {
      index: 0,
      processed: 0,
      sizes: [file.sizes],
      state: request.agent.State.INITIALIZED,
    };
    file.setProcessed(progress);
    this.autoUploadFile(file);
  }

  selectDoc() {
    try {
      const documentSelectOptions = new picker.DocumentSelectOptions();
      // 选择文档的最大数目（可选）
      documentSelectOptions.maxSelectNumber = this.maxMediaNum;
      //选择是否对指定文件或目录授权，true为授权，当为true时，defaultFilePathUri为必选参数，拉起文管授权界面；false为非授权，拉起常规文管界面（可选）
      documentSelectOptions.authMode = false;
      let context = getContext(this) as common.Context; // 请确保 getContext(this) 返回结果为 UIAbilityContext
      // 创建文件选择器实例
      const documentViewPicker = new picker.DocumentViewPicker(context);
      return documentViewPicker.select(documentSelectOptions).then((documentSelectResult: Array<string>) => {
        //文件选择成功后，返回被选中文档的uri结果集。
        const uris: string[] = documentSelectResult;
        Logger.info('documentViewPicker.select to file succeed and uris are:' + uris);
        return uris;
      }).catch((err: BusinessError) => {
        Logger.error(`Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
        return [];
      });
    } catch (err) {
      Logger.error(`Invoke documentViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
      return [];
    }
  }

  selectAudio() {
    const context = getContext(this) as common.Context;
    const audioViewPicker = new picker.AudioViewPicker(context);
    const audioSelectOptions = new picker.AudioSelectOptions();
    audioSelectOptions.maxSelectNumber = this.maxMediaNum;
    return audioViewPicker.select(audioSelectOptions).then((audioSelectResult: Array<string>) => {
      //文件选择成功后，返回被选中音频的uri结果集。
      const uris: string[] = audioSelectResult;
      Logger.info('audioViewPicker.select to file succeed and uri is:' + uris);
      return uris;
    }).catch((err: BusinessError) => {
      Logger.error(`Invoke audioViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
      return [];
    });
  }

  setFullScreen(full: boolean) {
    try {
      this.window?.setWindowLayoutFullScreen(full);
    } catch (e) {
      Logger.error('setWindowLayoutFullScreen error:' + JSON.stringify(e));
    }
  }

  setBarShow() {
    try {
      this.window?.setSpecificSystemBarEnabled('status', true, true);
      this.window?.setSpecificSystemBarEnabled('navigationIndicator', true, true);
      this.isShowStatusBar = true;
    } catch (e) {
      Logger.error('setWindowSystemBarEnable show error:' + JSON.stringify(e));
    }
  }

  setBarHidden() {
    try {
      this.window?.setSpecificSystemBarEnabled('status', false, true);
      this.window?.setSpecificSystemBarEnabled('navigationIndicator', false, true);
      this.isShowStatusBar = false;
    } catch (e) {
      Logger.error('setWindowSystemBarEnable hidden error:' + JSON.stringify(e));
    }
  }

  enterFullScreen(file: FileModel) {
    this.isPreview = true;
    this.curClickIndex = this.fileList.findIndex(v => v.id === file.id);
    this.setBarHidden();
    this.setFullScreen(true);
  }

  quitFullScreen() {
    this.fileList.forEach((v) => {
      v.setShowMask(false);
    })
    this.isPreview = false;
    this.setBarShow();
    this.setFullScreen(false);
  }

  isShowProcess(file: FileModel) {
    if (this.readonly) {
      return false;
    }
    if (!this.cloudStorageOption.autoUpload) {
      return false;
    }
    if (file.initFlag) {
      return false;
    }
    if (file.uploadStatus === request.agent.State.FAILED) {
      return false;
    }
    if (this.mode === FileLayoutMode.GRID && file.processed >= file.sizes) {
      return false;
    }
    return true;
  }

  isShowUploadDetail(file: FileModel) {
    if (this.readonly) {
      return false;
    }
    if (!this.cloudStorageOption.autoUpload) {
      return false;
    }
    if (file.initFlag) {
      return false;
    }
    return true;
  }

  getFileIcon(file: FileModel) {
    if (file.type === FileMediaType.IMAGE) {
      return $r('app.media.ic_public_image');
    }
    if (file.type === FileMediaType.VIDEO) {
      return $r('app.media.ic_public_video');
    }
    if (file.type === FileMediaType.AUDIO) {
      return $r('app.media.ic_public_music_note');
    }
    if (file.name.endsWith('.zip') || file.name.endsWith('.rar')) {
      return $r('app.media.ic_public_file_zip');
    }
    return $r('app.media.ic_public_files');
  }

  @Builder
  AddBox() {
    Column({ space: 4 }) {
      Image($r('app.media.ic_public_image_box'))
        .width(CommonConstants.COMMON_ICON_NORMAL_W)
        .aspectRatio(1)
        .fillColor($r('sys.color.ohos_id_color_primary'))
      Text($r('app.string.select_img'))
        .fontSize($r('sys.float.ohos_id_text_size_button2'))
        .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
        .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
    }
    .width(CommonConstants.FULL_PERCENT)
    .aspectRatio(1)
    .justifyContent(FlexAlign.Center)
    .borderWidth(1)
    .borderColor($r('sys.color.ohos_id_color_switch_outline_off'))
    .borderStyle(BorderStyle.Dashed)
    .borderRadius($r('sys.float.ohos_id_corner_radius_default_m'))
    .backgroundColor($r('sys.color.ohos_id_color_text_field_sub_bg'))
    .onClick(() => {
      this.select();
    })
  }

  @Builder
  SelectTip() {
    Row({ space: 10 }) {
      Text(this.customSelectTip)
        .fontSize($r('sys.float.ohos_id_text_size_body3'))
        .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
        .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
        .layoutWeight(1)

      if (this.showLimit) {
        Text($r('app.string.select_files_num_tip', this.fileList.length.toString(), this.fileNumLimit.toString()))
          .fontSize($r('sys.float.ohos_id_text_size_body2'))
          .fontColor($r('sys.color.ohos_id_color_text_primary'))
          .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
      }
    }
    .width(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  UploadBtn1() {
    Column({ space: 16 }) {
      Row() {
        Button() {
          Row({ space: 8 }) {
            Image($r('app.media.ic_public_plus'))
              .width(CommonConstants.COMMON_ICON_SMALL_W)
              .aspectRatio(1)
              .fillColor($r('sys.color.ohos_id_color_primary'))
            Text(this.btnOption.label || $r('app.string.select_btn_text'))
              .fontSize($r('sys.float.ohos_id_text_size_button2'))
              .fontColor($r('sys.color.ohos_id_color_text_primary'))
              .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
          }
          .clip(true)
        }
        .type(ButtonType.Normal)
        .enabled(!this.isReachLimit)
        .backgroundColor($r('sys.color.ohos_id_color_button_normal'))
        .borderWidth(0)
        .borderColor($r('sys.color.ohos_id_color_button_normal'))
        .borderRadius($r('sys.float.ohos_id_corner_radius_default_s'))
        .padding({
          top: 6,
          bottom: 6,
          left: 12,
          right: 12,
        })
        .onClick(() => {
          this.select();
        })

      }
      .width(CommonConstants.FULL_PERCENT)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  UploadBtn2() {
    Column({ space: 16 }) {
      Column() {
        Image($r('app.media.ic_public_upload'))
          .width(CommonConstants.COMMON_ICON_NORMAL_W)
          .aspectRatio(1)
          .fillColor($r('sys.color.ohos_id_color_primary'))
        Text(this.btnOption.label || $r('app.string.select_btn_text'))
          .fontSize($r('sys.float.ohos_id_text_size_button2'))
          .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
          .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
          .margin({ top: 12, bottom: 12 })
        Text(this.btnOption.subLabel || $r('app.string.select_btn_sub_text'))
          .fontSize($r('sys.float.ohos_id_text_size_button2'))
          .fontColor($r('sys.color.ohos_id_color_primary'))
          .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
      }
      .enabled(!this.isReachLimit)
      .opacity(this.isReachLimit ? 0.5 : 1)
      .backgroundColor($r('sys.color.ohos_id_color_text_field_sub_bg'))
      .borderWidth(1)
      .borderColor($r('sys.color.ohos_id_color_switch_outline_off'))
      .borderStyle(BorderStyle.Dashed)
      .borderRadius($r('sys.float.ohos_id_corner_radius_default_m'))
      .padding(12)
      .width(CommonConstants.FULL_PERCENT)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.select();
      })
    }
    .alignItems(HorizontalAlign.Start)
  }

  // 预览中提示当前选择
  getPreviewLabel(index: number) {
    return `${index + 1} / ${this.fileList.length}`;
  }

  @Builder
  ImageFullScreen() {
    Column() {
      Swiper() {
        ForEach(this.fileList, (item: FileModel, index: number) => {
          Stack() {
            Image(item.pixelMap || item.url)
              .width(CommonConstants.FULL_PERCENT)
              .height(CommonConstants.FULL_PERCENT)
              .objectFit(ImageFit.Contain)

            if (this.isShowStatusBar) {
              Row() {
                Image($r('app.media.ic_public_preview_arrow_left'))
                  .width(CommonConstants.COMMON_ICON_NORMAL_W)
                  .aspectRatio(1)
                  .fillColor($r('sys.color.ohos_id_color_primary'))
                  .onClick(() => {
                    this.quitFullScreen();
                  })
                Text(this.getPreviewLabel(index))
                  .fontSize($r('sys.float.ohos_id_text_size_body1'))
                  .fontColor($r('sys.color.ohos_id_color_text_primary'))
                  .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
                  .textAlign(TextAlign.Center)
                  .maxLines(1)
                  .textOverflow({ overflow: TextOverflow.MARQUEE })
                  .margin({ left: 10, right: 10 })
                  .layoutWeight(1)
                if (this.isShowDelIcon) {
                  Image($r('app.media.ic_public_trash'))
                    .width(CommonConstants.COMMON_ICON_NORMAL_W)
                    .aspectRatio(1)
                    .fillColor($r('sys.color.ohos_id_color_primary'))
                    .onClick(() => {
                      this.deleteFile(item);
                    })
                }
              }
              .onClick(() => {
              })
              .width(CommonConstants.FULL_PERCENT)
              .padding({
                top: 12 + this.statusH,
                bottom: 12,
                left: 24,
                right: 24,
              })
              .backgroundColor($r('sys.color.ohos_id_color_background'))
            }

          }.align(Alignment.Top)

        })
      }
      .index(this.curClickIndex)
      .loop(false)
      .gesture(
        GestureGroup(GestureMode.Exclusive,
          SwipeGesture({ direction: SwipeDirection.Vertical })
            .onAction((event: GestureEvent) => {
              if (event) {
                this.quitFullScreen();
              }
            }),
          TapGesture({ count: 1 })
            .onAction((event: GestureEvent) => {
              if (event) {
                if (this.isShowStatusBar) {
                  this.setBarHidden();
                } else {
                  this.setBarShow();
                }
              }
            }),
        ),
      )
    }
    .width(CommonConstants.FULL_PERCENT)
    .height(CommonConstants.FULL_PERCENT)
    .justifyContent(FlexAlign.Center)
  }

  @Builder
  ImageBox(file: FileModel) {
    Stack() {
      Stack() {
        Stack() {
          Image(file.pixelMap || file.url)
            .width(CommonConstants.FULL_PERCENT)
            .aspectRatio(1)
            .objectFit(ImageFit.Cover)
            .borderRadius(12)

          if (this.isShowProcess(file)) {
            Progress({ value: 0, total: file.sizes, type: ProgressType.Ring })
              .value(file.processed)
              .width(24)
              .height(24)
              .color($r('sys.color.ohos_id_color_bottom_tab_icon_auxcolor01'))
              .style({ strokeWidth: 4 })
          }
        }.align(Alignment.Center)

        Row({ space: 4 }) {
          if (!file.initFlag && file.uploadStatus === request.agent.State.FAILED) {
            Image($r('app.media.ic_public_warning'))
              .width(CommonConstants.COMMON_ICON_SMALL_W)
              .aspectRatio(1)
              .fillColor($r('sys.color.ohos_id_color_palette9'))
          }

        }.margin({ top: 8, right: 8 })

      }
      .align(Alignment.TopEnd)

      if (file.showMask) {
        Stack() {
          Row()
            .width(CommonConstants.FULL_PERCENT)
            .aspectRatio(1)
            .borderRadius(12)
            .backgroundColor($r('sys.color.ohos_id_color_mask_thick'))
            .opacity($r('sys.float.ohos_id_alpha_content_tertiary'))
          Row({ space: 16 }) {
            if (!this.disablePreview) {
              Image($r('app.media.ic_public_eye'))
                .width(CommonConstants.COMMON_ICON_NORMAL_W)
                .aspectRatio(1)
                .fillColor($r('sys.color.ohos_id_color_primary_contrary'))
                .onClick(() => {
                  this.enterFullScreen(file);
                })
            }

            if (this.isShowDelIcon) {
              Image($r('app.media.ic_public_trash'))
                .width(CommonConstants.COMMON_ICON_NORMAL_W)
                .aspectRatio(1)
                .fillColor($r('sys.color.ohos_id_color_primary_contrary'))
                .onClick(() => {
                  this.deleteFile(file);
                })
            }

          }
        }

      }

    }
    .align(Alignment.Center)
    .onClick(() => {
      if (!this.isShowDelIcon && this.disablePreview) {
        return;
      }
      file.setShowMask(!file.showMask);
    })

  }

  @Builder
  FileListItem(file: FileModel) {
    Stack() {
      Row({ space: 12 }) {
        if (this.listOption.showFileIcon ?? true) {
          Image(this.getFileIcon(file))
            .width(CommonConstants.FILE_ICON_W)
            .aspectRatio(1)
            .objectFit(ImageFit.Contain)
            .fillColor($r('sys.color.ohos_id_color_text_primary'))
        }

        Column({ space: 2 }) {
          Text(file.name)
            .fontSize($r('sys.float.ohos_id_text_size_body3'))
            .fontColor($r('sys.color.ohos_id_color_text_primary'))
            .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
            .maxLines(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
          if (this.isShowUploadDetail(file)) {
            if (file.uploadStatus !== request.agent.State.FAILED) {
              Row({ space: 16 }) {
                Text() {
                  Span(getProcessedStr(file.processed, file.sizes))
                  Span('/')
                  Span(getSizeStr(file.sizes))
                }
                .fontSize($r('sys.float.ohos_id_text_size_body3'))
                .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
                .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))

                Text(`${(file.processed / file.sizes * 100).toFixed(0)}%`)
                  .fontSize($r('sys.float.ohos_id_text_size_body3'))
                  .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
                  .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
              }
            } else {
              Text($r('app.string.upload_fail'))
                .fontSize($r('sys.float.ohos_id_text_size_body3'))
                .fontColor($r('sys.color.ohos_id_color_warning'))
                .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
            }
          }
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        // 按钮区域
        Row({ space: 6 }) {
          if (!file.initFlag && file.uploadStatus === request.agent.State.FAILED) {
            Image($r('app.media.ic_public_resetting'))
              .width(CommonConstants.COMMON_ICON_NORMAL_W)
              .aspectRatio(1)
              .onClick(() => {
                this.reUpload(file);
              })
          }
          if (this.isShowDelIcon) {
            Image($r('app.media.ic_public_cancel'))
              .width(CommonConstants.COMMON_ICON_NORMAL_W)
              .aspectRatio(1)
              .fillColor($r('sys.color.ohos_id_color_secondary'))
              .onClick(() => {
                this.deleteFile(file);
              })
          }
        }

      }
      .width(CommonConstants.FULL_PERCENT)
      .borderRadius($r('sys.float.ohos_id_corner_radius_default_s'))
      .backgroundColor($r('sys.color.ohos_id_color_button_normal'))
      .padding(12)

      if (this.isShowProcess(file)) {
        Progress({ value: 0, total: file.sizes, type: ProgressType.Capsule })
          .value(file.processed)
          .color(this.listOption.processBarColor || $r('sys.color.ohos_id_color_emphasize'))
          .backgroundColor($r('sys.color.ohos_id_color_progress'))
          .width(CommonConstants.FULL_PERCENT)
          .height(4)
          .padding({ left: 12, right: 12 })
      }
    }.alignContent(Alignment.Bottom)

  }

  build() {
    Column({ space: 16 }) {
      if (this.mode === FileLayoutMode.GRID) {
        Grid() {
          ForEach(this.fileList, (file: FileModel) => {
            GridItem() {
              this.ImageBox(file)
            }
          }, (item: FileModel) => item.id)

          if (!this.isReachLimit && !this.readonly) {
            GridItem() {
              this.AddBox()
            }
          }
        }
        .columnsTemplate('1fr 1fr 1fr')
        .columnsGap(8)
        .rowsGap(8)
        .maxCount(this.fileNumLimit)
        .width(CommonConstants.FULL_PERCENT)
        .bindContentCover($$this.isPreview, this.ImageFullScreen(), {
          modalTransition: ModalTransition.DEFAULT,
          backgroundColor: Color.Black,
        })

        this.SelectTip()

      } else {
        if (!this.readonly) {
          if (this.btnOption.type === SelectBtnType.SIMPLE) {
            this.UploadBtn1()
          } else {
            this.UploadBtn2()
          }
        }

        this.SelectTip()

        Scroll() {
          Column({ space: 8 }) {
            ForEach(this.fileList, (file: FileModel) => {
              this.FileListItem(file)
            }, (item: FileModel) => item.id)
          }
        }
        .align(Alignment.Top)
        .height(this.listOption.listHeight ?? CommonConstants.LIST_MODE_SCROLLER_HEIGHT)
        .nestedScroll({
          scrollForward: NestedScrollMode.SELF_FIRST,
          scrollBackward: NestedScrollMode.SELF_FIRST,
        })

      }
    }
    .width(CommonConstants.FULL_PERCENT)
  }
}