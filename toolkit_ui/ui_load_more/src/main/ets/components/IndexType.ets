/**
 * 定义了文本和图标的相关属性（文字、颜色、大小、显示控制等）
 */
export interface ContentValue {
  text?: ResourceStr,
  fontColor?: ResourceStr,
  fontSize?: ResourceColor,
  showText?: boolean,
  icon?: ResourceStr,
  iconColor?: ResourceStr,
  showIcon?: boolean,
}

/**
 * 将不同状态（更多、加载中、无更多）的ContentValue组合在一起
 */
export interface ContentGroup {
  more?: ContentValue,
  loading?: ContentValue,
  noMore?: ContentValue
}

/**
 * 组件的三种状态枚举
 */
export enum Status {
  MORE = 'more',
  LOADING = 'loading',
  NOMORE = 'noMore'
}

/**
 * 显示图标的位置枚举
 */
export enum IconPosition {
  TOP = 'top',
  LEFT = 'left'
}