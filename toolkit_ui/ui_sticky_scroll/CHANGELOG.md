# 滚动吸顶组件 ui-sticky-scroll

## 简介

i-sticky-scroll 是一款滚动吸顶组件，支持滚动吸顶、自定义多种样式风格等功能。

## 快速开始

### 安装

```bash
ohpm install @krislorem/ui-base
ohpm install @krislorem/ui-sticky-scroll
```

### 使用

```typescript
// 引入组件
import { UIStickyScroll, TabItem } from '@krislorem/ui-sticky-scroll'

```

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。

2. HarmonyOS系统：HarmonyOS 5.0.0 Release及以上。

3. DevEco Studio版本：DevEco Studio 5.0.0 Release及以上。

4. HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上。

## 子组件

无

## 接口

### UIStickyScroll(options: UIStickyScrollOptions)

**UIStickyScrollOptions对象说明**

| 参数名                    | 类型            | 是否必填 | 说明                        |
|:-----------------------|:--------------|:-----|:--------------------------|
| headerHeight           | number        | 否    | 单位vp, 默认值为48，头部导航栏高度      |
| mainHeight             | number        | 否    | 单位vp, 默认值为154，主要信息区高度     |
| headerTitle            | ResourceStr   | 否    | 头部导航栏标题                   |
| isToggleByPan          | boolean       | 否    | 默认值为true,是否根据滑动手势切换tab    |
| contentBuilderParam    | CustomBuilder | 是    | 内容区自定义内容                  |
| mainBuilderParam       | CustomBuilder | 是    | 主要信息区自定义内容                |
| backgroundBuilderParam | CustomBuilder | 是    | 版头背景自定义内容                 |
| tabStyle               | TabStyle      | 否    | tab栏样式                    |

## 使用限制

无

## 事件

| 名称                                         | 功能描述                                             |
|:-------------------------------------------|:-------------------------------------------------|
| onReachTop(() => void）                     | 主要信息区滚动到顶时触发                                     |
| onProcess((ratio: number) => void）         | 主要信息区滚动过程中触发，ratio为y轴的偏移程度，取为0-1，0为未向上滚动，1为滚动到顶部 |


## 示例

```
import { UIStickyScroll } from '@krislorem/ui-sticky-scroll'

@Entry
@ComponentV2
export struct UIStickyScrollDemo {
  @Local arr: number[] = [1, 2, 3, 4, 5, 6, 7, 8]
  @Local headerHeight: number = 48
  @Local statusBarHeight: number = 48 // 将在 aboutToAppear 中动态获取
  @Local mainHeight: number = 154
  @Local headerTitle: ResourceStr = '标题--ui-sticky-scroll'
  @Local title: string = '云南洱海'
  scroller: Scroller = new Scroller()

  //设置头部背景
  @Builder
  backgroundBuilder() {
    Image($r('app.media.banner')).width('100%').height('100%')
  }

  //头部主要信息区
  @Builder
  mainBuilder() {
    Column() {
      Row() {
        Text('标题--ui-sticky-scroll')
          .fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
          .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
          .fontColor('white')
      }
      .width('100%').height(24).margin({ bottom: 12 })

      Flex() {
        Column() {
          Image($r('app.media.fengjing')).width(90).height(90).borderRadius(6)
        }
        .width(90).margin({ left: 8 })

        Column() {
          Text(this.title).margin({ left: 16, top: 6 }).fontSize($r('sys.float.ohos_id_text_size_sub_title1'))
            .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
            .fontColor('white')
          Text('阳光轻吻山巅绿翠，天空, 如梦似幻, 云朵悠然, 像极了你温柔的眼眸')
            .fontSize($r('sys.float.ohos_id_text_size_body2'))
            .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
            .fontColor('white')
            .opacity($r('sys.float.ohos_id_alpha_content_primary'))
            .margin({ top: 10, left: 16, right: 16 })
        }
        .alignItems(HorizontalAlign.Start)
      }
    }
  }

  // 中间主要内容
  @Builder
  contentBuilder() {
    List
    ({ space: 12 }) {
      ForEach(this.arr, (item: number, index: number) => {
        ListItem() {
          Flex() {
            Image($r('app.media.icon_avatar')).width(48).height(48).borderRadius(24).flexShrink(0)
            Column() {
              Text('陶然然')
                .fontSize(16)
                .fontColor('#E6000000')
                .margin({ bottom: 8 })
                .lineHeight(20)
                .fontWeight(500)
                .fontFamily('HarmonyHeiTi')
              Text('喜欢旅游的中国人，一生一定要体验一次的骑行洱海，太美了。阳光，蓝天，白云，碧波，优质空气，一切都太美好，不能忘怀。')
                .fontSize(12)
                .fontColor('#99000000')
                .lineHeight(16)
                .fontWeight(500)
                .fontFamily('HarmonyHeiTi')
              Row() {
                Image($r('app.media.icon_like'))
                  .width(14)
                  .margin({ right: 9 })
                  .fillColor('#ffcb1515')
                Image($r('app.media.icon_share')).width(14).fillColor('#191919')
              }
              .width('100%').margin({ top: 9 }).justifyContent(FlexAlign.End)
            }
            .alignItems(HorizontalAlign.Start)
            .margin({ left: 16 })
          }
        }
        .margin({ top: index === 0 ? 19 : 0 }).height(100)
      }, (item: string) => item)
    }
    .backgroundColor('#FFFFFF')
    .padding({ left: 8, right: 8 })
    .edgeEffect(EdgeEffect.Spring)
    .scrollBar(BarState.Off)
    .nestedScroll({
      scrollForward: NestedScrollMode.PARENT_FIRST,
      scrollBackward: NestedScrollMode.SELF_FIRST
    })
  }

  build() {
    Column() {
      UIStickyScroll({
        mainHeight: this.mainHeight,
        headerHeight: this.headerHeight,
        headerTitle: this.headerTitle,
        headerBackgroundBuilderParam: (): void => {
          this.backgroundBuilder()
        },
        headerContentBuilderParam: (): void => {
          this.contentBuilder()
        },
        mainContentBuilderParam: (): void => {
          this.mainBuilder()
        },
        // 滚动过程触发，ratio为y轴的偏移程度，取为0-1，0为未向上滚动，1为滚动到顶部
        onProcess: (ratio: number) => {
          console.log('滚动比率', ratio)
        },
        //滚动到达顶部
        onReachTop: () => {
          console.log('滚动到达顶部了')
        },
      })
    }.width('100%')
    .height('100%')
  }
}
```