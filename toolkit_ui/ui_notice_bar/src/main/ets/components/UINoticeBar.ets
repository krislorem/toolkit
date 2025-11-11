import { Constants } from '../common/Constants';

@ComponentV2
export struct UINoticeBar {
  // 文字滚动速度,默认6vp
  @Param speed: number = Constants.DEFAULT_SPEED
  // 显示文字
  @Param text: ResourceStr = ''
  // 背景颜色
  @Param barBackgroundColor: ResourceColor = $r('app.color.default_bg_color')
  // 文字、左侧图标以及右侧关闭按钮颜色，只支持修改svg图标颜色
  @Param color: ResourceColor = $r('sys.color.ohos_id_color_text_primary_activated')
  // 查看更多文字颜色
  @Param moreColor: ResourceColor = $r('sys.color.ohos_id_color_text_primary_activated')
  // 设置“查看更多”的文本
  @Param moreText: string = ''
  // 是否单行
  @Param single: boolean = false
  // 是否滚动，为true时，NoticeBar为单行
  @Param scrollable: boolean = false
  // 是否显示左侧图标
  @Param showIcon: boolean = false
  // 左侧通知图标
  @Param noticeIcon: ResourceStr = $r('app.media.ic_public_sound')
  // 是否显示右侧关闭按钮
  @Param showClose: boolean = false
  // 右侧关闭按钮图标
  @Param closeIcon: ResourceStr = $r('app.media.ic_public_cancel')
  // 是否显示右侧查看更多图标，为true时，NoticeBar为单行
  @Param showGetMore: boolean = false
  // 文字大小(包括text和moreText字体大小)，单位为vp
  @Param fontSize: number = Constants.DEFAULT_FOUNT_SIZE
  // 点击 NoticeBar 触发事件
  @Event click: () => void = () => {
  }
  // 关闭 NoticeBar 触发事件
  @Event close: () => void = () => {
  }
  // 点击”查看更多“时触发事件
  @Event getMore: () => void = () => {
  }
  // 是否显示
  @Local showBar: boolean = true;
  // 文字
  @Local barText: string = ''

  aboutToAppear(): void {
    if (typeof this.text === 'string') {
      this.barText = this.text
    } else {
      this.barText = getContext(this).resourceManager.getStringSync(this.text.id)
    }
  }

  build() {
    if (this.showBar) {
      Flex({ alignItems: this.showClose ? ItemAlign.Center : ItemAlign.Start, justifyContent: FlexAlign.Center }) {
        // 左侧喇叭图标
        if (this.showIcon) {
          Column() {
            Image(this.noticeIcon)
              .width(this.fontSize * 1.3)
              .fillColor(this.color)
          }
          .width(this.fontSize * 1.3)
          .height(this.fontSize * 1.3)
          .justifyContent(FlexAlign.Center)
          .flexShrink(Constants.FLEX_SHRINK_ZERO)
          .margin({ right: Constants.ICON_SPACE })
        }
        // 文字
        if (this.scrollable) {
          Marquee({
            start: true,
            src: this.barText,
            step: this.speed
          })
            .fontColor(this.color)
            .fontSize(this.fontSize)
            .height(this.fontSize * 1.3)
            .padding({ top: Constants.MARQUEE_PADDING })
            .layoutWeight(Constants.LAYOUT_WEIGHT_ONE)
        } else {
          Text(this.barText)
            .fontColor(this.color)
            .fontSize(this.fontSize)
            .maxLines((this.scrollable || this.single || this.showGetMore) ? Constants.ONE_LINE : null)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .lineHeight(this.fontSize * 1.3)
            .layoutWeight(Constants.LAYOUT_WEIGHT_ONE)
        }
        // 右侧查看更多
        if (this.showGetMore) {
          Column() {
            if (this.moreText) {
              Text(this.moreText).fontSize(this.fontSize).fontColor(this.moreColor)
                .lineHeight(this.fontSize * 1.3)
            } else {
              Column() {
                Image($r('app.media.ic_public_arrow_right')).height(this.fontSize * 1.1).fillColor(this.moreColor)
              }
              .width(this.fontSize * 1.3)
              .height(this.fontSize * 1.3)
              .justifyContent(FlexAlign.Center)
            }
          }.margin({ left: Constants.ICON_SPACE }).onClick(() => {
            this.getMore()
          })
          .flexShrink(Constants.FLEX_SHRINK_ZERO)
        }
        if (this.showClose && this.showGetMore) {
          Divider()
            .height(this.fontSize)
            .vertical(true)
            .strokeWidth(1)
            .color($r('sys.color.ohos_id_color_hover'))
            .margin({ left: Constants.DIVIDER_MARGIN, right: Constants.DIVIDER_MARGIN })
        }
        // 右侧关闭
        if (this.showClose) {
          Column() {
            Image(this.closeIcon)
              .width(this.fontSize * 0.9)
              .fillColor(this.color)
              .onClick(() => {
                this.showBar = false
                this.close()
              })
          }
          .margin({ left: !this.showGetMore ? Constants.ICON_SPACE : Constants.NO_SPACE })
          .width(this.fontSize * 1.3)
          .height(this.fontSize * 1.3)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        }
      }.padding({
        top: Constants.BAR_PADDING_VERTICAL,
        right: Constants.BAR_PADDING_HORIZONTAL,
        bottom: Constants.BAR_PADDING_VERTICAL,
        left: Constants.BAR_PADDING_HORIZONTAL
      })
      .backgroundColor(this.barBackgroundColor)
      .onClick(() => {
        this.click()
      })
    }
  }
}