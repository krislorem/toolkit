import { LayoutFull } from '@krislorem/ui-base';

@Entry
@Component
struct DarkThemePage {
  @Builder
  buildPageContent() {
    Column() {
      Text('深色主题页面')
        .fontSize(24)
        .fontColor(Color.White)
        .margin({ bottom: 16 })

      Text('系统栏文字会自动变为白色')
        .fontSize(16)
        .fontColor('#CCCCCC')
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Column() {
      LayoutFull({
        customBgColor: '#ff3b79a2',
        buildContent: this.buildPageContent
      })
    }
    .width('100%')
    .height('100%')
  }
}