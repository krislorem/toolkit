import { UIBase } from '../common/UIBase';
import { AvoidAreaInfo } from '../common/AvoidAreaInfo';
import { AvoidAreaCallback, PaddingType } from '../common/Model';

/**
 * LayoutFull 组件，用于处理全屏布局时的安全区域避让。主要功能包括：
 * 根据是否全屏或需要计算内边距来决定是否监听避让区域变化；
 * 在组件加载时主动获取一次避让区域数据并处理；
 * 监听系统避让区域变化，并更新顶部和底部的内边距；
 * 使用 .expandSafeArea() 扩展安全区域，确保内容不被状态栏、导航栏等遮挡；
 * 支持自定义背景色与内容构建器（BuilderParam）。
 * 整体实现了适配全面屏设备的安全区域显示逻辑。
 *
 * 使用方式：
 * 1. 在 EntryAbility 中调用 UIBase.init(windowStage, { immersive: true })
 * 2. 在页面中使用 LayoutFull 组件，传入 customBgColor 和 buildContent 即可
 * 3. 组件会自动检测窗口是否为沉浸式，并处理避让区域
 */
@Component
export struct LayoutFull {
  // 当前窗口是否为沉浸式（自动检测，也可手动指定）
  @Prop isLayoutFullScreen: boolean = true;
  // 需要计算避让区域的情况
  @Prop needCalcPadding: boolean = false;
  // 自定义窗口背景颜色
  @Prop customBgColor: ResourceColor = $r('sys.color.ohos_id_color_background');
  @State paddingTop: number = 0;
  @State paddingBottom: number = 0;
  @BuilderParam buildContent: () => void;

  needOnAvoidAreaChange() {
    return this.isLayoutFullScreen || this.needCalcPadding;
  }

  avoidAreaChangeWatch = (data: AvoidAreaCallback) => {
    const resp = AvoidAreaInfo.handle(data);
    this.handlePadding(resp);
  };

  handlePadding(data: PaddingType | undefined) {
    if (!data) {
      return;
    }
    // 窗口设置全屏，需要额外避让状态栏、底部导航条等
    if (this.isLayoutFullScreen) {
      this.paddingTop = data.top;
      this.paddingBottom = data.bottom;
    } else {
      // 窗口未设置全屏，不需要额外避让状态栏等
      this.paddingTop = 0;
      this.paddingBottom = 0;
    }
  }

  aboutToAppear(): void {
    if (this.needOnAvoidAreaChange()) {
      // 首次进来不会执行on('avoidAreaChange', callback)监听，需要主动获取避让区域
      const data = AvoidAreaInfo.getAvoidAreaOnce();
      this.handlePadding(data);
      UIBase.onAvoidAreaChange(this.avoidAreaChangeWatch);
    }

    // 根据背景色自动设置状态栏内容颜色
    if (this.isLayoutFullScreen && this.customBgColor) {
      UIBase.setSystemBarColor(this.customBgColor);
    }
  }

  aboutToDisappear(): void {
    if (this.needOnAvoidAreaChange()) {
      UIBase.offAvoidAreaChange(this.avoidAreaChangeWatch);
    }
  }

  build() {
    Column() {
      if (this.buildContent) {
        this.buildContent()
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.customBgColor)
    .padding({
      top: this.paddingTop,
      bottom: this.paddingBottom,
    })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}