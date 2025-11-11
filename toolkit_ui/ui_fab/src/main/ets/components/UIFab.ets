import { AnimationConstants, Const, TypeClick, TypeFab } from '../common/Constant';
import { PopMenuContent } from '../common/Model';

@ComponentV2
export struct UIFab {
  // 自定义fab按钮的位置
  @Param fabPosition: Position | Edges | LocalizedEdges =
    { bottom: AnimationConstants.FAB_PADDING, left: AnimationConstants.FAB_PADDING };
  @Param enableDrag: boolean = false;
  // 自定义fab按钮颜色
  @Param fabColor: ResourceColor = $r('sys.color.ohos_id_color_emphasize');
  // 自定义图标颜色为深色还是浅色
  @Param darkIcon: boolean = false;
  // 自定义fab按钮中的图标
  @Param iconImage: ResourceStr = $r('app.media.ic_public_menu');
  // 自定义fab按钮展开后的图标
  @Param showIconImage: ResourceStr = $r('app.media.ic_public_expand');
  // 当展开菜单横向时,自定义最大宽度,默认值为280
  @Param maxWidth: number = AnimationConstants.MAX_MENU;
  // 当展开菜单纵向时,自定义最大高度,默认值为280
  @Param maxHeight: number = AnimationConstants.MAX_MENU;
  // 自定义展开菜单选项点击后的效果,默认无效果
  @Param clickChange: TypeClick = TypeClick.NONE;
  // 自定义展开的菜单是横向还是纵向,默认false
  @Param isVertical: boolean = false;
  // 自定义展开菜单的展开方向
  @Param popMenuStyle: TypeFab = TypeFab.RIGHT_UP;
  // 自定义展开菜单的内容
  @Param content: PopMenuContent[] = [];
  // 内部变量
  @Local fabX: string = AnimationConstants.FAB_POSITION_LEFT;
  @Local fabY: string = AnimationConstants.FAB_POSITION_TOP;
  // 展开菜单的宽高
  @Local listWidth: number = AnimationConstants.FAB_SIZE_ZERO;
  @Local listHeight: number = AnimationConstants.FAB_SIZE_ZERO;
  // 子菜单展开
  @Local isPopMenu: boolean = false;
  // 渐变起始和终止颜色
  @Local linearGradientBeginColor: ResourceStr = $r('app.color.start_color');
  @Local linearGradientEndColor: ResourceStr = $r('app.color.end_color');
  // 偏移量
  @Local fabTranslate: TranslateOptions = { x: 0, y: 0 };
  fabTranslateTemp: TranslateOptions = { x: 0, y: 0 };
  // 滚动控制
  scroller: Scroller = new Scroller();

  aboutToAppear(): void {
    this.checkFabPosition();
  }

  @Monitor('fabPosition')
  fabPositionChange() {
    this.fabTranslate = { x: 0, y: 0 };
  }

  /**
   * 水平浮层组件。
   */
  @Builder
  fadingOverlayX() {
    Text()
      .width(this.listWidth - AnimationConstants.LIST_SIZE)
      .height(AnimationConstants.FAB_SIZE)
      .linearGradient({
        angle: Const.OVERLAY_X,
        colors: [
          [this.linearGradientBeginColor, Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[0]],
          [$r('app.color.start_color'), Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[1]],
          [$r('app.color.start_color'), Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[2]],
          [this.linearGradientEndColor, Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[3]],
        ],
      })
      .animation({
        curve: Curve.Ease,
        duration: Const.DURATION,
      })
      .visibility(
        this.listWidth + AnimationConstants.LIST_FILL_SIZE < this.maxWidth ? Visibility.None : Visibility.Visible,
      )
      .hitTestBehavior(HitTestMode.Transparent)
  };

  /**
   * 垂直浮层组件。
   */
  @Builder
  fadingOverlayY() {
    Text()
      .width(AnimationConstants.FAB_SIZE)
      .height(this.listHeight - AnimationConstants.LIST_SIZE)
      .linearGradient({
        angle: Const.OVERLAY_Y,
        colors: [
          [this.linearGradientBeginColor, Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[0]],
          [$r('app.color.start_color'), Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[1]],
          [$r('app.color.start_color'), Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[2]],
          [this.linearGradientEndColor, Const.OVERLAY_LINEAR_GRADIENT_COLOR_POS[3]],
        ],
      })
      .animation({
        curve: Curve.Ease,
        duration: Const.DURATION,
      })
      .visibility(
        this.listHeight + AnimationConstants.LIST_FILL_SIZE < this.maxHeight ? Visibility.None : Visibility.Visible,
      )
      .hitTestBehavior(HitTestMode.Transparent)
  };

  /**
   * popMenu菜单展示方式
   */
  private showMethod(): AlignRuleOption {
    if (this.popMenuStyle === TypeFab.RIGHT_UNDER) {
      return {
        left: { anchor: 'button', align: HorizontalAlign.End },
        top: { anchor: 'button', align: VerticalAlign.Top },
      };
    } else if (this.popMenuStyle === TypeFab.RIGHT_UP) {
      return {
        left: { anchor: 'button', align: HorizontalAlign.End },
        bottom: { anchor: 'button', align: VerticalAlign.Bottom },
      };
    } else if (this.popMenuStyle === TypeFab.LEFT_UNDER) {
      return {
        right: { anchor: 'button', align: HorizontalAlign.End },
        top: { anchor: 'button', align: VerticalAlign.Top },
      };
    } else if (this.popMenuStyle === TypeFab.LEFT_UP) {
      return {
        right: { anchor: 'button', align: HorizontalAlign.End },
        bottom: { anchor: 'button', align: VerticalAlign.Bottom },
      };
    } else {
      console.error('输入类型错误!')
    }
    return {};
  };

  /**
   * 判断fab按钮所在的位置
   */
  @Monitor('popMenuStyle')
  private checkFabPosition() {
    if (this.popMenuStyle === TypeFab.RIGHT_UNDER) {
      this.fabX = AnimationConstants.FAB_POSITION_LEFT;
      this.fabY = AnimationConstants.FAB_POSITION_TOP;
    } else if (this.popMenuStyle === TypeFab.RIGHT_UP) {
      this.fabX = AnimationConstants.FAB_POSITION_LEFT;
      this.fabY = AnimationConstants.FAB_POSITION_BOTTOM;
    } else if (this.popMenuStyle === TypeFab.LEFT_UNDER) {
      this.fabX = AnimationConstants.FAB_POSITION_RIGHT;
      this.fabY = AnimationConstants.FAB_POSITION_TOP;
    } else if (this.popMenuStyle === TypeFab.LEFT_UP) {
      this.fabX = AnimationConstants.FAB_POSITION_RIGHT;
      this.fabY = AnimationConstants.FAB_POSITION_BOTTOM;
    }
  };

  /**
   * popMenu菜单动画播放效果
   */
  private fabAnimation: AnimateParam = {
    duration: AnimationConstants.ANIMATION_TIME,
    curve: Curve.Ease,
    iterations: AnimationConstants.ANIMATION_CONSTANT,
    playMode: PlayMode.Alternate,
    expectedFrameRateRange: {
      min: AnimationConstants.FRAME_RATE_RANGE[0],
      max: AnimationConstants.FRAME_RATE_RANGE[1],
      expected: AnimationConstants.FRAME_RATE_RANGE[2],
    },
  };

  /**
   * fab按钮
   */
  @Builder
  fabButton() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image(this.isPopMenu ? this.showIconImage : this.iconImage)
        .width(AnimationConstants.ICON_SIZE)
        .height(AnimationConstants.ICON_SIZE)
        .fillColor(this.darkIcon ? $r('sys.color.ohos_id_color_primary') :
          $r('sys.color.ohos_id_color_primary_contrary'))
        .draggable(false)
    }
    .width(AnimationConstants.FAB_SIZE)
    .height(AnimationConstants.FAB_SIZE)
    .backgroundColor(this.fabColor)
    .onClick(() => {
      this.isPopMenu = !this.isPopMenu;
    })
  };

  /**
   * 弹出菜单
   */
  @Builder
  showPopMenu() {
    if (this.isVertical) {
      Column() {
        this.popMenuList()
      }
      .width(this.isPopMenu ? 'auto' : AnimationConstants.FAB_SIZE)
      .height(this.isPopMenu ? 'auto' : AnimationConstants.FAB_SIZE)
      .animation(this.fabAnimation)
      .onSizeChange((oldValue: SizeOptions, newValue: SizeOptions) => {
        this.listWidth = Number(JSON.stringify(newValue.width));
        this.listHeight = Number(JSON.stringify(newValue.height));
      })
      .constraintSize({
        maxHeight: this.maxHeight > AnimationConstants.FAB_SIZE ? this.maxHeight : AnimationConstants.FAB_SIZE,
      })
      .borderRadius($r('sys.float.ohos_id_corner_radius_menu'))
      .backgroundColor($r('sys.color.ohos_id_color_background'))
      .shadow(ShadowStyle.OUTER_DEFAULT_MD)

    } else {
      Row() {
        this.popMenuList()
      }
      .width(this.isPopMenu ? 'auto' : AnimationConstants.FAB_SIZE)
      .height(this.isPopMenu ? 'auto' : AnimationConstants.FAB_SIZE)
      .animation(this.fabAnimation)
      .onSizeChange((oldValue: SizeOptions, newValue: SizeOptions) => {
        this.listWidth = Number(JSON.stringify(newValue.width));
        this.listHeight = Number(JSON.stringify(newValue.height));
      })
      .constraintSize({
        maxWidth: this.maxWidth > AnimationConstants.FAB_SIZE ? this.maxWidth : AnimationConstants.FAB_SIZE,
      })
      .borderRadius($r('sys.float.ohos_id_corner_radius_menu'))
      .backgroundColor($r('sys.color.ohos_id_color_background'))
      .shadow(ShadowStyle.OUTER_DEFAULT_MD)
    }
  };

  /**
   * 展开popMenu菜单布局
   */
  @Builder
  popMenuList() {
    if ((this.fabX === '0%' && this.fabY === '0%') || (this.fabX === '100%' && this.fabY === '0%' && this.isVertical) ||
      (this.fabX === '0%' && this.fabY === '100%' && !this.isVertical)) {
      Button({ type: ButtonType.Circle })
        .width(AnimationConstants.FAB_FILL_SIZE)
        .backgroundColor($r('app.color.start_color'));
    }

    List({ space: AnimationConstants.LIST_SPACE, scroller: this.scroller }) {
      ForEach(this.content, (item: PopMenuContent) => {
        ListItem() {
          popMenu({
            content: item,
            isVertical: this.isVertical,
            clickChange: this.clickChange,
          });
        };
      }, (item: PopMenuContent) => item.id);
    }
    .width(this.isPopMenu ? 'auto' :
      (this.isVertical ? AnimationConstants.FAB_SIZE : AnimationConstants.FAB_SIZE_ZERO))
    .height(this.isPopMenu ? 'auto' :
      (this.isVertical ? AnimationConstants.FAB_SIZE_ZERO : AnimationConstants.FAB_SIZE))
    .animation(this.fabAnimation)
    .overlay(this.isVertical ? this.fadingOverlayY() : this.fadingOverlayX())
    .scrollBar(BarState.Off)
    .onReachStart(() => {
      this.linearGradientBeginColor = $r('app.color.start_color');
      this.linearGradientEndColor = $r('app.color.end_color');
    })
    .onReachEnd(() => {
      this.linearGradientBeginColor = $r('app.color.end_color');
      this.linearGradientEndColor = $r('app.color.start_color');
    })
    .onDidScroll((scrollOffset: number, scrollState: ScrollState) => {
      // 列表滑动到于中间位置时，两侧都有边缘渐变效果
      if ((this.isVertical ? this.scroller.currentOffset().yOffset !== 0 :
        this.scroller.currentOffset().xOffset !== 0) && !this.scroller.isAtEnd()) {
        this.linearGradientBeginColor = $r('app.color.end_color');
        this.linearGradientEndColor = $r('app.color.end_color');
      }
    })
    .constraintSize({
      maxWidth: this.maxWidth > AnimationConstants.FAB_SIZE ?
        this.maxWidth - AnimationConstants.LIST_SIZE : AnimationConstants.FAB_SIZE,
      maxHeight: this.maxHeight > AnimationConstants.FAB_SIZE ?
        this.maxHeight - AnimationConstants.LIST_SIZE : AnimationConstants.FAB_SIZE,
    })
    .margin(this.isPopMenu ? {
      top: this.isVertical ? AnimationConstants.MARGIN_SIZE[2] : AnimationConstants.MARGIN_SIZE[0],
      bottom: this.isVertical ? AnimationConstants.MARGIN_SIZE[2] : AnimationConstants.MARGIN_SIZE[0],
      left: this.isVertical ? AnimationConstants.MARGIN_SIZE[0] : AnimationConstants.MARGIN_SIZE[2],
      right: this.isVertical ? AnimationConstants.MARGIN_SIZE[0] : AnimationConstants.MARGIN_SIZE[2],
    } : {})
    .edgeEffect(EdgeEffect.None)
    .borderRadius($r('sys.float.ohos_id_corner_radius_default_l'))
    .listDirection(this.isVertical ? Axis.Vertical : Axis.Horizontal)

    if ((this.fabX === '100%' && this.fabY === '0%' && !this.isVertical) ||
      (this.fabX === '0%' && this.fabY === '100%' && this.isVertical) ||
      (this.fabX === '100%' && this.fabY === '100%')) {
      Button({ type: ButtonType.Circle })
        .width(AnimationConstants.FAB_FILL_SIZE)
        .backgroundColor($r('app.color.start_color'))
    }
  }

  build() {
    RelativeContainer() {
      Row() {
        this.fabButton();
      }
      .width(AnimationConstants.FAB_SIZE)
      .height(AnimationConstants.FAB_SIZE)
      .justifyContent(FlexAlign.Center)
      .id('button')
      .zIndex(AnimationConstants.Z_INDEX[1])

      Row() {
        this.showPopMenu();
      }
      .height(this.isVertical ? 'auto' : AnimationConstants.FAB_SIZE)
      .width(this.isVertical ? AnimationConstants.FAB_SIZE : 'auto')
      .zIndex(AnimationConstants.Z_INDEX[0])
      .justifyContent(FlexAlign.Center)
      .alignRules(this.showMethod())
      .id('popMenu')
      .margin({ left: -AnimationConstants.FAB_SIZE })
      .visibility(this.content.length < 1 ? Visibility.None : Visibility.Visible)

    }
    .position(this.fabPosition)
    .translate(this.fabTranslate)
    .width('auto')
    .height('auto')
    .borderRadius($r('sys.float.ohos_id_corner_radius_menu'))
    .gesture(
      PanGesture()
        .onActionStart(() => {
          this.fabTranslateTemp.x = this.fabTranslate.x;
          this.fabTranslateTemp.y = this.fabTranslate.y;
        })
        .onActionUpdate((event: GestureEvent) => {
          if (!this.enableDrag) {
            return;
          }
          this.fabTranslate = {
            x: event.offsetX + (this.fabTranslateTemp.x as number),
            y: event.offsetY + (this.fabTranslateTemp.y as number),
          };
        }),
    )
  }
}

@ComponentV2
struct popMenu {
  @Require @Param content: PopMenuContent;
  @Require @Param isVertical: boolean;
  @Require @Param clickChange: TypeClick;
  @Local isClick: boolean = false;
  @Local backColor: ResourceColor = $r('sys.float.ohos_id_alpha_separator_line');
  @Local iconImage: ResourceStr = $r('app.media.icon_image');

  build() {
    Flex({ direction: this.isVertical ? FlexDirection.Column : FlexDirection.Row, alignItems: ItemAlign.Center }) {
      Image(this.iconImage)
        .height(AnimationConstants.MENU_ICON_SIZE)
        .width(AnimationConstants.MENU_ICON_SIZE)
        .fillColor($r('sys.color.ohos_id_color_primary'))
        .objectFit(ImageFit.Contain)
        .margin({
          top: this.isVertical ? AnimationConstants.MARGIN_SIZE[2] : AnimationConstants.MARGIN_SIZE[3],
          bottom: this.isVertical ? AnimationConstants.MARGIN_SIZE[0] : AnimationConstants.MARGIN_SIZE[3],
          left: this.isVertical ? AnimationConstants.MARGIN_SIZE[3] : AnimationConstants.MARGIN_SIZE[2],
          right: this.isVertical ? AnimationConstants.MARGIN_SIZE[3] : AnimationConstants.MARGIN_SIZE[0],
        })
      Text(this.content.text)
        .fontWeight(FontWeight.Medium)
        .fontSize(this.isVertical ? $r('sys.float.ohos_id_text_size_caption') :
          $r('sys.float.ohos_id_text_size_button3'))
        .fontColor($r('sys.color.ohos_id_color_text_secondary'))
        .textOverflow(this.isVertical ? { overflow: TextOverflow.Clip } : { overflow: TextOverflow.Ellipsis })
        .constraintSize({ maxWidth: this.isVertical ? AnimationConstants.MENU_WIDTH : AnimationConstants.MAX_TEXT })
        .margin({
          top: this.isVertical ? AnimationConstants.MARGIN_SIZE[1] : AnimationConstants.MARGIN_SIZE[0],
          bottom: this.isVertical ? AnimationConstants.MARGIN_SIZE[2] : AnimationConstants.MARGIN_SIZE[0],
          left: this.isVertical ? AnimationConstants.MARGIN_SIZE[0] : AnimationConstants.MARGIN_SIZE[1],
          right: this.isVertical ? AnimationConstants.MARGIN_SIZE[0] : AnimationConstants.MARGIN_SIZE[2],
        })
        .height(this.isVertical ? AnimationConstants.MENU_HEIGHT : AnimationConstants.TEXT_HEIGHT)
        .maxLines(1)
        .textAlign(TextAlign.Center)
    }
    .margin({
      top: this.isVertical ? AnimationConstants.MARGIN_SIZE[0] : AnimationConstants.MARGIN_SIZE[1],
      bottom: this.isVertical ? AnimationConstants.MARGIN_SIZE[0] : AnimationConstants.MARGIN_SIZE[1],
      left: this.isVertical ? AnimationConstants.MARGIN_SIZE[1] : AnimationConstants.MARGIN_SIZE[0],
      right: this.isVertical ? AnimationConstants.MARGIN_SIZE[1] : AnimationConstants.MARGIN_SIZE[0],
    })
    .borderRadius($r('sys.float.ohos_id_corner_radius_default_l'))
    .backgroundColor(this.backColor)
    .onClick(() => {
      this.isClick = !this.isClick;
      if (this.clickChange === TypeClick.NONE) {
        this.backColor = Color.Transparent;
      } else if (this.clickChange === TypeClick.ALL) {
        this.backColor =
          this.isClick ? $r('sys.color.ohos_id_color_click_effect') : $r('sys.float.ohos_id_alpha_separator_line');
        this.iconImage = this.isClick ? this.content.iconSelectedPath : this.content.iconPath;
      } else if (this.clickChange === TypeClick.ICON_CHANGE) {
        this.iconImage = this.isClick ? this.content.iconSelectedPath : this.content.iconPath;
      } else if (this.clickChange === TypeClick.BACKGROUND_CHANGE) {
        this.backColor =
          this.isClick ? $r('sys.color.ohos_id_color_click_effect') : $r('sys.float.ohos_id_alpha_separator_line');
      }
      this.content.popClick();
    })
  }
}