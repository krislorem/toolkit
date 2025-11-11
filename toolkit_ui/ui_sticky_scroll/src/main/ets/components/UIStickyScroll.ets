import { DEFAULT_LARGE_HEIGHT, DEFAULT_SMALL_HEIGHT } from './Constant'
import { Logger } from '@krislorem/toolkit_core'
import { AvoidAreaInfo } from '@krislorem/ui-base'

@ComponentV2
export struct UIStickyScroll {
  // 头部高度
  @Param @Once headerHeight: number = DEFAULT_SMALL_HEIGHT
  // 主体高度
  @Param @Once mainHeight: number = DEFAULT_LARGE_HEIGHT
  // 头部标题
  @Param headerTitle: ResourceStr = ''
  // 控制头部标题栏显隐
  @Local headerVisible: boolean = false
  // 上滑的比率
  @Local ratio: number = 0
  // 状态栏高度
  @Local statusBarHeight: number = 0
  // 顶部背景
  @BuilderParam headerBackgroundBuilderParam: () => void = this.headerBackgroundBuilder;
  // 顶部内容
  @BuilderParam headerContentBuilderParam: () => void = this.headerContentBuilder;
  // 主体内容
  @BuilderParam mainContentBuilderParam: () => void = this.mainContentBuilder;
  // 滚动器
  scroller: Scroller = new Scroller()

  @Builder
  headerBackgroundBuilder() {
  };

  @Builder
  headerContentBuilder() {
  };

  @Builder
  mainContentBuilder() {
  };

  // 滚动到顶
  @Event onReachTop: () => void = () => {
  }
  // 滚动过程触发，ratio为y轴的偏移程度，取为0-1，0为未偏移，1为滚动到顶部
  @Event onProcess: (ratio: number) => void = () => {

  }

  aboutToAppear(): void {
    //  传入宽高异常处理
    if (this.headerHeight <= 0) {
      this.headerHeight = DEFAULT_SMALL_HEIGHT
      Logger.error('headerHeight must be greater than 0')
    }
    if (this.mainHeight <= 0) {
      this.mainHeight = DEFAULT_LARGE_HEIGHT
      Logger.error('mainHeight must be greater than 0')
    }

    // 获取状态栏高度
    try {
      const avoidArea = AvoidAreaInfo.getAvoidAreaOnce(true)
      Logger.info(`UIStickyScroll avoidArea: ${JSON.stringify(avoidArea)}`)
      if (avoidArea && avoidArea.top > 0) {
        this.statusBarHeight = avoidArea.top
      } else {
        // 如果获取失败，使用默认值
        this.statusBarHeight = AvoidAreaInfo.getStatusH()
        if (this.statusBarHeight === 0) {
          this.statusBarHeight = 24 // 备用默认值
        }
      }
      Logger.info(`UIStickyScroll statusBarHeight: ${this.statusBarHeight}`)
    } catch (error) {
      Logger.error('UIStickyScroll 获取状态栏高度失败:', error)
      this.statusBarHeight = 24 // 备用默认值
    }
  }

  build() {
    Stack() {
      Column() {
        // 头部区域
        Flex({ alignItems: ItemAlign.Center }) {
          Text(this.headerTitle)
            .flexGrow(1)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)
            .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
            .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
            .fontColor('white')
            .translate({ y: this.headerVisible ? 0 : -10 })
            .opacity(this.headerVisible ? 1 : 0)
            .animation({
              duration: 1000,
              curve: Curve.Ease,
              playMode: PlayMode.Normal
            })
        }.height('100%')
      }
      .width('100%')
      .height(this.headerHeight)
      .backgroundColor('transparent')
      .zIndex(2)
      .padding({
        left: 16,
        right: 16,
        top: this.statusBarHeight,
        bottom: 16
      })

      Scroll(this.scroller) {
        Column() {
          // 顶部信息区域
          Stack() {
            RelativeContainer() {
              // 顶部背景
              this.headerBackgroundBuilderParam()
            }.width('100%').height('100%')

            RelativeContainer() {
              this.mainContentBuilderParam()
            }
            .padding({
              left: 24,
              right: 24,
              top: 12,
              bottom: 16
            })
            .margin({ top: this.headerHeight })
            .opacity(1 - this.ratio)
            .blur(this.ratio * 30)
            .animation({
              duration: 1000,
              curve: Curve.Ease,
              playMode: PlayMode.Normal
            })
          }.width('100%')
          .height(this.mainHeight + this.headerHeight)

          // 顶部内容区
          RelativeContainer() {
            this.headerContentBuilderParam()
          }
          .padding({ left: 16, right: 16, top: 8 })
          .borderRadius({ topLeft: 4, topRight: 4 })
          .width('100%')
          .height(`calc(100% - ${this.headerHeight}vp)`)
        }.width('100%')
      }
      .edgeEffect(EdgeEffect.None)
      .friction(0.6)
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
      .onScrollEdge((side: Edge) => {
        // 滚动到顶部
        if (side === Edge.Bottom) {
          this.headerVisible = true
          this.onReachTop()
        }
      })
      .onScrollFrameBegin((offset: number) => {
        // 滚动过程触发，ratio为y轴的偏移程度，取为0-1，0为未偏移，1为滚动到顶部
        const yOffset = this.scroller.currentOffset().yOffset
        this.ratio = yOffset / this.mainHeight
        if (this.ratio !== 1) {
          this.headerVisible = false // 控制标题内容显隐
        }
        this.onProcess(this.ratio)
        return { offsetRemain: offset }
      })
    }.alignContent(Alignment.Top)
  }
}