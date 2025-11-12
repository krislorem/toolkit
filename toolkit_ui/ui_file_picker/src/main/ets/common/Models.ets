import { FileMediaType, FileSizeType, SelectBtnType } from './Constants';
import { getRandomId, getType } from './Utils';
import { request } from '@kit.BasicServicesKit';
import { cloudCommon } from '@kit.CloudFoundationKit';

/**
 * 图片打包选项
 */
export interface IPackingOption {
  // 图片打包类型
  type: FileSizeType
  // 打包格式
  format?: string;

  // 打包质量
  quality?: number;
}

/**
 * 按钮选项
 */
export interface IBtnOption {
  // 按钮类型
  type: SelectBtnType;

  // 按钮主文字
  label?: ResourceStr;

  // 按钮辅助文字
  subLabel?: ResourceStr;
}

/**
 * 云存储选项
 */
export interface ICloudStorageOption {
  // 是否启动上传到云存储
  autoUpload: boolean;

  // 云存储实例名称
  bucketName?: string;

  // 目录名称
  dirName?: string;

  // 云开发初始化选项
  cloudOptions?: cloudCommon.CloudOptions;
}

/**
 * 列表模式选项
 */
export interface IListOption {
  // 进度条颜色
  processBarColor?: ResourceColor;

  // 是否展示文件类型图标
  showFileIcon?: boolean;

  // 列表高度
  listHeight?: Length
}

/**
 * 文件模型
 */
export interface IFileModel {
  // 文件id，唯一索引，自动生成
  id?: string;

  // picker获取的uri
  uri?: string;

  // 文件名
  name: string;

  // 文件buffer
  buffer: ArrayBuffer | undefined;

  // 图片的pixelMap
  pixelMap?: PixelMap | undefined;

  // 文件类型
  type?: FileMediaType;

  // 上传进度
  processed?: number;

  // 上传状态
  uploadStatus?: request.agent.State;

  // 上传文件总大小
  sizes?: number;

  // 云端的地址
  url?: string;
}

@ObservedV2
export class FileModel implements IFileModel {
  // 文件id，唯一索引，自动生成
  id: string = '';
  // picker获取的uri
  uri: string = '';
  // 文件名
  name: string = '';
  // 文件buffer
  buffer: ArrayBuffer | undefined = undefined;
  // 图片的pixelMap
  @Trace pixelMap: PixelMap | undefined = undefined;
  // 文件类型
  @Trace type: FileMediaType = FileMediaType.ALL;
  // 上传进度
  @Trace processed: number = 0;
  // 上传状态
  @Trace uploadStatus: request.agent.State = request.agent.State.INITIALIZED;
  // 上传文件总大小
  @Trace sizes: number = 1;
  // 云端的地址
  @Trace url: string = '';
  // 二次编辑时，是否初始化数据
  @Trace initFlag: boolean = false;
  // 是否点击小图，显示蒙层
  @Trace showMask: boolean = false;
  // 上传任务
  @Trace task: request.agent.Task | undefined = undefined;

  constructor(file?: IFileModel) {
    this.uri = file?.uri || '';
    this.name = file?.name || '';
    this.buffer = file?.buffer;
    this.pixelMap = file?.pixelMap;
    this.id = getRandomId();
    this.type = getType(file?.name);
    this.sizes = file?.buffer?.byteLength || 1;
    this.url = file?.url || '';
    this.processed = file?.processed || 0;
    this.uploadStatus = file?.uploadStatus || request.agent.State.INITIALIZED;
  }

  // 设置初始化标志
  setInitFlag(flag: boolean) {
    this.initFlag = flag;
  }

  // 设置上传进度
  setProcessed(processed: request.agent.Progress) {
    this.processed = processed.processed;
    this.uploadStatus = processed.state;
  }

  // 设置云端下载链接
  setUrl(url: string) {
    this.url = url;
  }

  setShowMask(flag: boolean) {
    this.showMask = flag;
  }

  setTask(task: request.agent.Task | undefined) {
    this.task = task;
  }
}