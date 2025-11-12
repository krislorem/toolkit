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

        Button('折叠面板组件')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/CollapseCommonPage' });
          })

        Button('悬浮按钮组件')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/FabDemoPage' });
          })

        Button('通告栏组件通告栏组件')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/NoticeBarSample' });
          })

        Button('滚动吸顶组件')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/UIStickyScrollDemo' });
          })

        Button('日历选择器UI组件1')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/CalendarPickerSample1' });
          })

        Button('日历选择器UI组件2')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/CalendarPickerSample2' });
          })

        Button('日历选择器UI组件3')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/CalendarPickerSample3' });
          })

        Button('日历选择器UI组件4')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/CalendarPickerSample4' });
          })

        Button('日历选择器UI组件5')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/CalendarPickerSample5' });
          })

        Button('日历选择器UI组件6')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/CalendarPickerSample6' });
          })

        Button('加载组件')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/LoadMoreDemo' });
          })

        Button('文件选择上传组件1')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/FilePickerSample1' });
          })

        Button('文件选择上传组件2')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/FilePickerSample2' });
          })

        Button('文件选择上传组件3')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/FilePickerSample3' });
          })

        Button('组件整合demo')
          .fontSize(17)
          .width(200)
          .height(48)
          .borderRadius(24)
          .margin({ bottom: 20 })
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/UIALLDEMO' });
          })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F2F2F7')
    }
    .edgeEffect(EdgeEffect.Spring)
    .friction(0.6)
    .backgroundColor('#DCDCDC')
    .scrollBar(BarState.Off)
    .width('100%')
  }
}