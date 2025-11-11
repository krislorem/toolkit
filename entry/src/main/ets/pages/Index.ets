@Entry
@Component
struct Index {
  @State message: string = '@krislorem/toolkit_core';

  build() {
    Scroll() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 20 })

        Text('鸿蒙开发工具集')
          .fontSize(18)
          .fontColor('#8E8E93')
          .margin({ bottom: 40 })

        Button('查看使用示例')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/ToolkitExamplePage' });
          })

        Text('v1.0.1')
          .fontSize(14)
          .fontColor('#C7C7CC')
          .margin({ bottom: 20 })
          .margin({ top: 30 })

        Button('浅色模式')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/LightThemePage' });
          })

        Button('深色模式')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/DarkThemePage' });
          })

        Button('多级轮播图组件')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/SwiperDemoPage' });
          })

        Button('标签组件')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/TagDemoPage' });
          })
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F2F2F7')
    }
  }
}