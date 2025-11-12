export enum FileLayoutMode {
  LIST = 'list',
  GRID = 'grid',
}

export enum FileMediaType {
  IMAGE = 'image',
  VIDEO = 'video',
  IMAGE_VIDEO = 'image_video',
  AUDIO = 'audio',
  ALL = 'all',
}

/**
 * 文件大小，原图/重新打包
 */
export enum FileSizeType {
  ORIGINAL = 'original',
  PACKING = 'packing',
}

/**
 * 按钮样式，简单按钮/复杂按钮
 */
export enum SelectBtnType {
  SIMPLE = 'simple',
  RICH = 'rich',
}

export class CommonConstants {
  static readonly FULL_PERCENT: string = '100%';
  // 最大文件数量默认值
  static readonly MAX_FILE_NUM_LIMIT_DEFAULT = 9;
  // 打包图片后的格式默认值
  static readonly COMPRESSED_IMAGE_FORMAT_DEFAULT = 'image/jpeg';
  // 打包图片质量默认值
  static readonly COMPRESSED_IMAGE_QUALITY_DEFAULT = 50;
  // 列表模式下，滚轮区域高度
  static readonly LIST_MODE_SCROLLER_HEIGHT = 270;
  // 列表模式下，文件类型图标大小
  static readonly FILE_ICON_W = 36;
  // 通用按钮图标，正常号
  static readonly COMMON_ICON_NORMAL_W = 24;
  // 通用按钮图标，小号
  static readonly COMMON_ICON_SMALL_W = 16;
}