export class AnimationConstants {
  // fab图标左侧位置
  public static readonly FAB_POSITION_LEFT: string = '0%';
  // fab图标右侧位置
  public static readonly FAB_POSITION_RIGHT: string = '100%';
  // fab图标顶部位置
  public static readonly FAB_POSITION_TOP: string = '0%';
  // fab图标底部位置
  public static readonly FAB_POSITION_BOTTOM: string = '100%';
  // fab传入图标的大小
  public static readonly ICON_SIZE: number = 24;
  // fab图标大小
  public static readonly FAB_SIZE: number = 40;
  public static readonly FAB_FILL_SIZE: number = 39;
  public static readonly LIST_FILL_SIZE: number = 1;
  public static readonly FAB_SIZE_ZERO: number = 0;
  public static readonly FILL_SIZE: number = 48;
  // 菜单中icon图标宽高
  public static readonly MENU_ICON_SIZE: number = 20;
  // 内部List列表宽度
  public static readonly LIST_SIZE: number = 55;
  // text文本高度
  public static readonly TEXT_HEIGHT: number = 16;
  // 内部点击按钮高度
  public static readonly POP_HEIGHT: number = 4;
  // fab图标和边界的距离
  public static readonly FAB_PADDING: number = 16;
  // 展开菜单的最大宽高
  public static readonly MAX_MENU: number = 280;
  // 菜单中列表的最大宽高
  public static readonly MAX_LIST: number = 240;
  // 输入文本的最大宽度
  public static readonly MAX_TEXT: number = 120;
  // 子菜单文本的高度
  public static readonly MENU_HEIGHT: number = 14;
  // 子菜单纵向时的最大宽度
  public static readonly MENU_WIDTH: number = 30;
  // 悬浮层占满展开菜单
  public static readonly FADING_OVERLAY: string = '100%';
  // 动画播放时长
  public static readonly ANIMATION_TIME: number = 240;
  // 动画播放次数
  public static readonly ANIMATION_CONSTANT: number = 1;
  // 可变帧率
  public static readonly FRAME_RATE_RANGE: number[] = [20, 120, 90];
  // list中listItem间隔
  public static readonly LIST_SPACE: number = 4;
  // margin的各方向大小
  public static readonly MARGIN_SIZE: number[] = [0, 4, 8, 10];
  // zIndex
  public static readonly Z_INDEX: number[] = [10, 11];
}

export enum TypeFab {
  // 展开菜单向右和向下展开
  RIGHT_UNDER,
  // 展开菜单向右和向上展开
  RIGHT_UP,
  // 展开菜单向左和向下展开
  LEFT_UNDER,
  // 展开菜单向左和向上展开
  LEFT_UP,
}

export enum TypeClick {
  // 禁用图标点击发生改变的效果
  NONE,
  // 点击后图标发生变化
  ICON_CHANGE,
  // 点击后背景发生变化
  BACKGROUND_CHANGE,
  // 点击后图标和背景都发生变化
  ALL,
}

export class Const {
  // 动画时长
  public static readonly DURATION: number = 220;
  // 渐变角度
  public static readonly OVERLAY_X: number = 90;
  public static readonly OVERLAY_Y: number = 180;
  // 渐变颜色位置
  public static readonly OVERLAY_LINEAR_GRADIENT_COLOR_POS: number[] = [0.0, 0.15, 0.85, 1.0];
}