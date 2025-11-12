import { Logger } from '@krislorem/toolkit_core';
import { photoAccessHelper } from '@kit.MediaLibraryKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { image } from '@kit.ImageKit';
import fs from '@ohos.file.fs';
import { cloudCommon, cloudStorage } from '@kit.CloudFoundationKit';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
import { CommonConstants, FileMediaType } from './Constants';
import { IPackingOption } from './Models';

/**
 * 云存储实例
 */
export class StorageBucket {
  // 桶名
  private bucketName: string | undefined = undefined;
  // 云开发初始化选项
  private cloudOptions?: cloudCommon.CloudOptions;
  // 云存储实例
  private bucket: cloudStorage.StorageBucket | null = null;

  constructor(name?: string, cloudOptions?: cloudCommon.CloudOptions) {
    Logger.info(`set cloudStorage bucket name: ${name}`);
    this.bucketName = name;
    this.cloudOptions = cloudOptions;

    if (!this.cloudOptions) {
      Logger.info('cloudOptions is undefined, cancel to cloudCommon.init');
      return;
    }

    const canUse = canIUse('SystemCapability.DeviceCloudGateway.CloudFoundation');
    if (!canUse) {
      Logger.warn('this device cannot use SystemCapability.DeviceCloudGateway.CloudFoundation');
      return;
    }

    try {
      cloudCommon.init(this.cloudOptions);
      Logger.info('cloudCommon.init success. options: ' + JSON.stringify(this.cloudOptions));
    } catch (e) {
      Logger.error('cloudCommon.init failed, error: ' + JSON.stringify(e));
    }
  }

  // 断网 =》联网切换时，需要重新获取实例
  reQueryBucket() {
    this.clearBucket();
    this.queryBucket();
  }

  // 断网时清空实例
  clearBucket() {
    this.bucket = null;
  }

  getBucket() {
    return this.bucket;
  }

  // 获取实例
  queryBucket() {
    try {
      const flag = canIUse('SystemCapability.DeviceCloudGateway.CloudFoundation');
      if (flag) {
        this.bucket = cloudStorage.bucket(this.bucketName);
        Logger.info(`success to query bucket by name ${this.bucketName}: ${JSON.stringify(this.bucket)}`);
      } else {
        Logger.warn('this device cannot use SystemCapability.DeviceCloudGateway.CloudFoundation');
      }
      return this.bucket;
    } catch (e) {
      Logger.error('query cloudStorage bucket fail, error: ' + JSON.stringify(e));
      return this.bucket;
    }
  }
}

/**
 * 生成5-15位随机数
 */
export const getRandomId = () => {
  const rand = cryptoFramework.createRandom();
  const len = 5;
  const list: number[] = [];
  while (list.length < len) {
    list.push(Math.round(Math.random() * 10));
  }
  try {
    let randData = rand.generateRandomSync(len);
    if (randData != null) {

      Logger.info('[Sync]: rand result: ' + randData.data);
      return randData.data.join('');
    } else {
      Logger.error('[Sync]: get rand result fail! finally use rand value: ' + list.join(''));
      return list.join('');
    }
  } catch (error) {
    let e: BusinessError = error as BusinessError;
    Logger.error(`do rand failed, ${e.code}, ${e.message}` + 'finally use rand value:' + list.join(''));
    return list.join('');
  }
};

/**
 * 使用系统picker，拉起相册或者相机
 */
export const selectMedia = (maxSelectNumber: number, mediaType: FileMediaType) => {
  const photoSelectOptions = new photoAccessHelper.PhotoSelectOptions();

  let type = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
  if (mediaType === FileMediaType.VIDEO) {
    type = photoAccessHelper.PhotoViewMIMETypes.VIDEO_TYPE;
  } else if (mediaType === FileMediaType.IMAGE_VIDEO) {
    type = photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
  }
  photoSelectOptions.MIMEType = type; // 过滤选择媒体文件类型为IMAGE
  photoSelectOptions.maxSelectNumber = maxSelectNumber; // 选择媒体文件的最大数目

  let uris: Array<string> = [];
  const photoViewPicker = new photoAccessHelper.PhotoViewPicker();
  return photoViewPicker.select(photoSelectOptions).then((photoSelectResult: photoAccessHelper.PhotoSelectResult) => {
    uris = photoSelectResult.photoUris;
    Logger.info('photoViewPicker.select to file succeed and uris are:' + uris);
    return uris;
  }).catch((err: BusinessError) => {
    Logger.error(`Invoke photoViewPicker.select failed, code is ${err.code}, message is ${err.message}`);
    return [];
  })
};

/**
 * 通过uri读取文件数据
 */
export const getFileBuffer = (uri: string) => {
  let file: fs.File | null = null;
  try {
    file = fs.openSync(uri, fs.OpenMode.READ_ONLY);
    let size = fs.statSync(file.fd).size;
    let buf = new ArrayBuffer(size);
    fs.readSync(file.fd, buf);
    Logger.info('getFileBufferByUri success, uri: ' + uri + ', buffer size:' + buf.byteLength);
    return buf;
  } catch (e) {
    Logger.error('getFileBufferByUri fail, uri: ' + uri + ', error:' + JSON.stringify(e));
    return undefined;
  } finally {
    fs.closeSync(file);
  }

}

/**
 * 通过uri读取图片buffer,可重新打包
 */
export const getFileBufferByUri = async (uri: string, compressed: boolean, packingOption: IPackingOption) => {
  const buf = getFileBuffer(uri);
  // 仅图片支持重新打包
  if (compressed && buf) {
    const imgSource = image.createImageSource(buf);
    const imagePackerApi: image.ImagePacker = image.createImagePacker();
    return imagePackerApi.packing(imgSource,
      {
        format: packingOption.format || CommonConstants.COMPRESSED_IMAGE_FORMAT_DEFAULT,
        quality: packingOption.quality || CommonConstants.COMPRESSED_IMAGE_QUALITY_DEFAULT,
      })
      .then((resp) => {
        Logger.info('imagePackerApi.packing success, uri: ' + uri + ', buffer size:' + resp.byteLength);
        return resp;
      })
      .catch((e: BusinessError) => {
        Logger.error('imagePackerApi.packing fail, uri: ' + uri + ', error: ' + JSON.stringify(e));
        return buf;
      });
  }
  return buf;
}

/**
 * 通过buffer获取图片pixel
 */
export const getPixelByBuf = async (buf: ArrayBuffer) => {
  return await image.createImageSource(buf).createPixelMap();
}

/**
 * 通过后缀判断文件类型
 */
export const getType = (fileName?: string) => {
  if (!fileName) {
    return FileMediaType.ALL;
  }
  if (fileName.endsWith('.mp4')) {
    return FileMediaType.VIDEO;
  }
  if (fileName.endsWith('.mp3')) {
    return FileMediaType.AUDIO;
  }
  if (fileName.toLowerCase().endsWith('.png') || fileName.toLowerCase().endsWith('.jpg')) {
    return FileMediaType.IMAGE;
  }
  return FileMediaType.ALL;
};

/**
 * 获取文件大小KB/MB描述
 */
export const getSizeStr = (size: number) => {
  let kb = size / 1024;
  if (kb < 1024) {
    return $r('app.string.size_kb', kb.toFixed(2));
  }
  return $r('app.string.size_mb', (kb / 1024).toFixed(2));
};

/**
 * 获取文件上传进度KB/MB描述
 */
export const getProcessedStr = (processed: number, size: number) => {
  if (size / 1024 < 1024) {
    return $r('app.string.size_kb', (processed / 1024).toFixed(2));
  }
  return $r('app.string.size_mb', (processed / 1024 / 1024).toFixed(2));
};