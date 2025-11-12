import { ContentGroup, Status, IconPosition } from './IndexType'

@ComponentV2
export struct LoadMore {
  // 所有状态数据
  @Param contentGroup: ContentGroup = {}
  // loading 的状态
  @Param status: Status = Status.MORE
  // 指定图标位置
  @Param iconPosition: IconPosition = IconPosition.LEFT
  // 是否显示 loading 图标
  private showIcon: boolean = true
  // 文字大小
  private fontSize: ResourceColor = $r('sys.float.ohos_id_text_size_body2')
  // 是否显示文本
  private showText: boolean = true
  // 文字颜色
  private fontColor: ResourceStr = $r('sys.color.ohos_id_color_text_secondary')
  // 图标颜色
  private iconColor: ResourceStr = $r('sys.color.ohos_id_color_secondary')
  // 图标大小
  @Local iconSize: number = 16
  // 滚动的角度
  @Local rotateAngle: number = 0
  private ANGLE: number = 360
  private defaultContentGroup: ContentGroup = {
    more: {
      text: $r('app.string.more_text'),
      fontColor: this.fontColor,
      fontSize: this.fontSize,
      showText: this.showText,

      icon: '',
      iconColor: this.iconColor,
      showIcon: this.showIcon

    },
    loading: {
      text: $r('app.string.loading_text'),
      fontColor: this.fontColor,
      fontSize: this.fontSize,
      showText: this.showText,

      icon: $r('app.media.loading'),
      iconColor: this.iconColor,
      showIcon: this.showIcon
    },
    noMore: {
      text: $r('app.string.noMore_text'),
      fontColor: this.fontColor,
      fontSize: this.fontSize,
      showText: this.showText,

      icon: '',
      iconColor: this.iconColor,
      showIcon: this.showIcon
    }
  }
  private context: Context = getContext(this) as Context

  aboutToAppear(): void {
    this.combine(this.defaultContentGroup, this.contentGroup)
  }

  combine(target: ContentGroup, source: ContentGroup) {
    const arr = Object.keys(source)
    if (arr.length <= 0) {
      return
    }
    arr.forEach(item => {
      let contentArr = Object.keys(Reflect.get(source, item))
      contentArr.forEach(child => {
        if (child === 'fontSize') {
          this.iconSize = (this.iconSize /
          px2vp(this.context.resourceManager.getNumberByName('ohos_id_text_size_body2'))) *
          Reflect.get(Reflect.get(source, item), child)
        }
        Reflect.set(Reflect.get(target, item), child, Reflect.get(Reflect.get(source, item), child))
      })
    })
  }

  getContent(type: string): string | Resource {
    const content = Reflect.get(this.defaultContentGroup, this.status)
    let res = ''
    if (content) {
      res = Reflect.get(content, type)
    } else {
      return ''
    }
    if (res) {
      return res
    }
    return ''
  }

  @Builder
  showImage() {
    Image(this.getContent('icon'))
      .margin(this.iconPosition === IconPosition.LEFT ? { right: 6 } : { bottom: 8 })
      .width(this.iconSize)
      .height(this.iconSize)
      .fillColor(this.getContent('iconColor'))
      .rotate({
        angle: this.rotateAngle
      })
      .animation({
        duration: 800,
        curve: Curve.Linear,
        iterations: -1,
      })
      .onAppear(() => {
        if (this.status === Status.LOADING) {
          this.rotateAngle = this.ANGLE
        }
      })
  }

  build() {
    Row() {
      if (this.getContent('icon') !== '' && this.getContent('showIcon') && this.iconPosition === IconPosition.LEFT) {
        this.showImage()
      }
      Column() {
        if (this.getContent('icon') !== '' && this.getContent('showIcon') && this.iconPosition === IconPosition.TOP) {
          this.showImage()
        }
        Row() {
          Text(this.getContent('text'))
            .fontSize(this.getContent('fontSize'))
            .fontColor(this.getContent('fontColor'))
            .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
            .visibility(this.getContent('showText') ? Visibility.Visible : Visibility.None)
          if (this.status === Status.LOADING) {
            Text('...')
              .fontSize(this.getContent('fontSize'))
              .fontColor(this.getContent('fontColor'))
              .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
              .visibility(this.getContent('showText') ? Visibility.Visible : Visibility.None)
          }
        }
      }
      .height(this.iconPosition === 'left' ? 39 : 63)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(this.iconPosition === 'left' ? 39 : 63)
    .padding({ top: 10, bottom: 10 })
    .justifyContent(FlexAlign.Center)
    .alignItems(VerticalAlign.Center)
  }
}