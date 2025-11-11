import { window } from '@kit.ArkUI';

/**
 * 定义了三个接口：
 * PaddingType 接口定义了包含上、下、左、右四个方向数值的填充类型
 * AvoidAreaCallback 接口定义了包含区域类型和避免区域信息的回调数据结构
 * WindowConfig 接口定义了窗口配置选项，用于设置沉浸式和系统栏样式
 * 主要用于处理窗口布局和安全区域相关的参数定义。
 */
export interface PaddingType {
  top: number;
  bottom: number;
  left: number;
  right: number;
}

export interface AvoidAreaCallback {
  type: window.AvoidAreaType;
  area: window.AvoidArea;
}

export interface WindowConfig {
  immersive?: boolean;
  statusBarColor?: string;
  navigationBarColor?: string;
  statusBarContentColor?: string;
  navigationBarContentColor?: string;
}