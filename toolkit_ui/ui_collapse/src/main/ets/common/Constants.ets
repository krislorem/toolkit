export class Constants {
  static readonly NO_VALUE: number = -1
  static readonly SPLICE_LENGTH: number = 1
  // 头部图标尺寸
  static readonly IMAGE_SIZE: number = 24
  // 头部文字尺寸
  static readonly HEADER_TEXT_SIZE: number = 24
  static readonly HEADER_MARGIN: number = 10
  // 折叠面板外部padding
  static readonly COLLPASE_PADDING: number = 6
  static readonly BORDER_WIDTH: number = 1
  // 动画时长
  static readonly ANIMATION_DUARTION: number = 200
  // 高度自适应
  static readonly NO_HEIGHT_LIMIT: number = -1
  static readonly ZERO_SIZE: number = 0
  // 禁用时颜色
  static readonly UNENABLE_OPACITY: number = 0.6
  static readonly COMMON_PADDING: number = 16
  static readonly CONTEXT_PADDING: number = 12
  static readonly FULL_PERCENT: string = '100%'
  static readonly ENABLE_OPACITY: number = 1
}

export enum TitleBorder {
  AUTO = 'auto',
  SHOW = 'show',
  NONE = 'none'
}