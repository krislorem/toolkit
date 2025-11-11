/**
 * 定义了一个宽度枚举和断点属性名常量
 * Width 枚举包含了四个预设宽度值（ZERO、SM、MD、LG），用于响应式布局设计。
 * BREAKPOINT_PROP_NAME 常量定义了断点属性的名称，便于在UI组件中统一引用和管理不同屏幕尺寸的断点配置。
 */
export enum Width {
  ZERO = '0vp',
  SM = '600vp',
  MD = '840vp',
  LG = '1440vp'
}

export const BREAKPOINT_PROP_NAME = 'UI.breakpoint';