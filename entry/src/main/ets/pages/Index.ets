
@Entry
@Component
struct Index {
  @State message: string = '@ssy/toolkit_core';

  build() {
    Column() {
      Text(this.message)
        .fontSize(32)
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

      Text('v0.1.0')
        .fontSize(14)
        .fontColor('#C7C7CC')
        .margin({ top: 30 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .backgroundColor('#F2F2F7')
  }
}