# 加载更多 ui-loadmore

## 简介

ui-loadmore 是一款加载更多组件。包括加载前、加载中和没有数据三种状态，支持跟随系统语言或特定语言类型。

## 快速开始

### 安装

```bash
ohpm install @krislorem/ui-load-more
```

### 使用

```bash
// 引入组件
import { LoadMore } from '@krislorem/ui-load-more';

```

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。
2. HarmonyOS系统：HarmonyOS 5.0.0 Release及以上。
3. DevEco Studio版本：DevEco Studio 5.0.0 Release及以上。
4. HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上。

## 子组件

无

## 接口

### UILoadMore(options: UILoadMoreOptions)

**UILoadMoreOptions对象说明**

| 参数           | 类型           | 必填 | 说明                            |
|:-------------|:-------------|:---|:------------------------------|
| contentGroup | ContentGroup | 否  | 所有状态的数据对象，可以在不同的状态下分别控制各种属性等。 |
| status       | Status       | 否  | loading 的状态                   |
| iconPosition | IconPosition | 否  | 指定图标位置                        |                                   |

**ContentGroup数据结构说明**

| 参数      | 类型           | 必填 | 说明            |
|:--------|:-------------|:---|:--------------|
| more    | ContentValue | 否  | more状态的属性等    |
| loading | ContentValue | 否  | loading状态的属性等 |
| noMore  | ContentValue | 否  | noMore状态的属性等  |

**ContentValue数据结构说明**

| 参数        | 类型            | 必填 | 说明              |
|:----------|:--------------|:---|:----------------|
| text      | string        | 否  | 文字说明            |
| fontColor | ResourceStr   | 否  | 文字颜色            |
| fontSize  | ResourceColor | 否  | 文字大小            |
| showText  | boolean       | 否  | 是否显示文本          |
| icon      | ResourceStr   | 否  | 自定义图标           |
| iconColor | ResourceStr   | 否  | 图标颜色            |
| showIcon  | boolean       | 否  | 是否显示 loading 图标 |

**Status枚举说明**

| 名称      | 描述            |
|:--------|:--------------|
| MORE    | 设置组件的状态为加载前。  |
| LOADING | 设置组件的状态为加载中。  |
| NOMORE  | 设置组件的状态为没有数据。 |

**IconPosition枚举说明**

| 名称   | 描述             |
|:-----|:---------------|
| TOP  | 设置图标的位置为文字的上方。 |
| LEFT | 设置图标的位置为文字的左侧。 |

## 使用限制

无

## 示例

```
import { ContentGroup, LoadMore, Status } from '@krislorem/ui-load-more'

@Entry
@ComponentV2
struct LoadMoreDemo {
  @Local
  contentGroup: ContentGroup = {
    loading: {
      text: '加载中...',
      fontSize: 16
    }
  }
  @Local
  status: Status = Status.LOADING

  @Builder
  TextTip() {
    Text()
      .width(5)
      .height(14)
      .backgroundColor('#1E90FF')
      .borderRadius(5)
      .margin({ right: 10 })
  }

  build() {
    Column() {
      Column() {
        Tabs
        ({ barPosition: BarPosition.End }) {
          TabContent() {
            Column
            ({ space: 20 }) {
              Column() {
                Row() {
                  this.TextTip()
                  Text('基本用法')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')
                
                LoadMore({
                  status: Status.MORE,
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('修改默认文字')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.MORE,
                  contentGroup: {
                    more: {
                      text: '上拉加载',
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('改变颜色')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.MORE,
                  contentGroup: {
                    more: {
                      fontColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }
            }
          }
          .tabBar('加载前')
          .align(Alignment.Top)
          .margin(20)

          TabContent() {
            Column
            ({ space: 20 }) {
              Column() {
                Row() {
                  this.TextTip()
                  Text('基本用法')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: this.status,
                },)
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('修改默认文字')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: this.status,
                  contentGroup: {
                    loading: {
                      text: '加载中'
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('文本颜色自定义')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.LOADING,
                  contentGroup: {
                    loading: {
                      fontColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('图标颜色自定义')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.LOADING,
                  contentGroup: {
                    loading: {
                      iconColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('自定义图标')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.LOADING,
                })
              }
            }
          }
          .tabBar('加载中')
          .align(Alignment.Top)
          .margin(20)

          TabContent() {
            Column
            ({ space: 20 }) {
              Column() {
                Row() {
                  this.TextTip()
                  Text('基本用法')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.NOMORE,
                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('文本内容自定义')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.NOMORE,
                  contentGroup: {
                    noMore: {
                      text: '我是有底线的'
                    }
                  }

                })
              }

              Column() {
                Row() {
                  this.TextTip()
                  Text('改变颜色')
                    .textAlign(TextAlign.Start)
                }
                .width('100%')

                LoadMore({
                  status: Status.NOMORE,
                  contentGroup: {
                    noMore: {
                      fontColor: $r('sys.color.ohos_id_color_activated')
                    }
                  }
                })
              }
            }
          }
          .tabBar('没有更多')
          .align(Alignment.Top)
          .margin(20)
        }
      }
    }
  }
}
```