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
      // 状态栏占位
      Row().padding({ top: 50 }).width('100%').height(100).background(Color.Blue)

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