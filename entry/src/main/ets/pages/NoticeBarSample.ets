import { LayoutFull } from '@krislorem/ui-base'
import { UINoticeBar } from '@krislorem/ui-notice-bar'

/**
 * ！！！这段代码定义了一个名为 textStyle 的扩展函数，用于为 Text 组件添加样式。主要功能包括：
 * 设置字体大小为 20
 * 设置字体粗细为 500
 * 设置宽度为 100%
 * 根据 isOne 参数值设置不同的上内边距（true 时为 10，false 时为 30），下内边距固定为 10，左内边距固定为 12
 */
@Extend(Text)
function textStyle(isOne: boolean = false) {
  .fontSize(20)
  .fontWeight(500)
  .width('100%')
  .padding({ top: isOne ? 10 : 30, bottom: 10, left: 12 })
}

@Entry
@ComponentV2
struct NoticeBarSample {
  @Local
  scrollable: boolean = false

  build() {
    Column() {
      LayoutFull({
        customBgColor: '#f5f5f5',
        buildContent: this.buildPageContent
      })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildPageContent() {
    Scroll() {
      Column() {
        Text('NoticeBar')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .width('100%')
          .padding({ left: 16, top: 16 })

        Text('多行显示').textStyle(true)
        UINoticeBar({
          text: '通告栏组件多用于系统通知，广告通知等场景，可自定义图标，颜色，展现方式等。'
        })

        Text('单行显示').textStyle() // 使用扩展函数 textStyle() 设置样式
        UINoticeBar({
          text: '使用 single 属性单行显示通知。通告栏组件多用于系统通知，广告通知等场景，可自定义图标，颜色，展现方式等。',
          single: true
        })

        Text('滚动显示+图标').textStyle() // 使用扩展函数 textStyle() 设置样式
        UINoticeBar({
          text: '使用 scrollable 属性使通告滚动,此时 single 属性将失效,始终单行显示',
          scrollable: true,
          showIcon: true,
        })

        Text(`查看更多-图标按钮`).textStyle() // 一处定义到处使用
        UINoticeBar({
          text: '使用 showGetMore 显示更多,此时 single 属性将失效,始终单行显示,如不配置 moreText 属性 ,将显示箭头图标',
          noticeIcon: $r('app.media.ic_gallery_create'),
          showIcon: true,
          showGetMore: true,
          scrollable: this.scrollable,
          getMore: () => {
            this.scrollable = !this.scrollable;
          }
        }).margin({ bottom: 10 })

        Text(`查看更多-文本按钮`).textStyle()
        UINoticeBar({
          text: '使用 showGetMore 显示更多,此时single属性将失效,始终单行显示,如不配置 moreText 属性 ,将显示箭头图标',
          showIcon: true,
          showGetMore: true,
          scrollable: this.scrollable,
          moreText: '查看更多',
          getMore: () => {
            this.scrollable = !this.scrollable;
          }
        })

        Text('修改颜色和尺寸').textStyle()
        UINoticeBar({
          text: '使用 color 修改文字和图标的颜色，使用barBackgroundColor修改背景色',
          showIcon: true,
          color: $r('sys.color.ohos_id_color_palette10'),
          barBackgroundColor: '#33E08C3A',
          fontSize: 16,
        })

        Text("滚动显示+图标+关闭").textStyle()
        UINoticeBar({
          text: '使用 showClose 属性,可关闭通知,如果不设置单行，会显示所有的内容且折行显示',
          showClose: true,
          showGetMore: true,
          scrollable: true,
          showIcon: true,
          close: () => {
            console.log("关闭按钮")
          }
        }).margin({ bottom: 10 })

        Text("更改关闭按钮").textStyle()
        UINoticeBar({
          text: '使用 closeIcon 属性,更改关闭图标',
          showClose: true,
          closeIcon: $r('app.media.ic_public_close'),
          close: () => {
            console.log("更改关闭按钮")
          }
        })
      }
    }
    .padding(16)
    .height('100%')
    .edgeEffect(EdgeEffect.Spring)
    .align(Alignment.TopStart)
  }
}