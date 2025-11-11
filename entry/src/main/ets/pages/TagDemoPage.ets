import { TagSize, TagType, UITag } from '@krislorem/ui-tag';

@Entry
@ComponentV2
struct TagDemoPage {
  @Local type: number = TagType.NORMAL;

  newClick() {
    let typeArr = [TagType.NORMAL, TagType.COLOR, TagType.BORDER];
    let currentIndex = typeArr.indexOf(this.type);
    if (currentIndex !== -1) {
      this.type = typeArr[(currentIndex + 1) % typeArr.length];
    }
  }

  build() {
    Column() {
      // 占位导航栏（后面可以封装为组件
      Row() {
        Text('标签组件')
          .fontSize(24)
      }
      .padding({ top: 50 })
      .width('100%')
      .backgroundColor('#7EBFEA')
      .justifyContent(FlexAlign.Center)


      Column() {
        Text('圆角样式')
        Row() {
          UITag({
            customText: '标签',
            tagSize: TagSize.SMALL,
          })
          UITag({
            customText: '标签',
          })
          UITag({
            customText: '标签',
            tagSize: TagSize.LARGE,
          })
        }

        Text('胶囊样式')
        Row() {
          UITag({
            isCapsule: true,
            customText: '标签',
            tagSize: TagSize.SMALL,
          })
          UITag({
            isCapsule: true,
            customText: '标签',
          })
          UITag({
            isCapsule: true,
            customText: '标签',
            tagSize: TagSize.LARGE,
          })
        }

        Text('自定义margin：')
        Row() {
          UITag({
            customText: '标签',
            customMargin: '20',
          })
          UITag({
            customText: '标签',
            customMargin: '20',
          })
        }
      }

      Column() {
        Row() {
          Column() {
            Text('常规标签')
            UITag({
              customText: '常规标签',
              type: TagType.NORMAL,
              tagSize: TagSize.SMALL,
            })
            UITag({
              customText: '常规标签',
              type: TagType.NORMAL,
            })
            UITag({
              customText: '常规标签',
              type: TagType.NORMAL,
              tagSize: TagSize.LARGE,
            })
          }

          Column() {
            Text('彩色标签')
            UITag({
              customText: '彩色标签',
              type: TagType.COLOR,
              tagSize: TagSize.SMALL,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.COLOR,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.COLOR,
              tagSize: TagSize.LARGE,
            })
          }

          Column() {
            Text('边框标签')
            UITag({
              customText: '彩色标签',
              type: TagType.BORDER,
              tagSize: TagSize.SMALL,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.BORDER,
            })
            UITag({
              customText: '彩色标签',
              type: TagType.BORDER,
              tagSize: TagSize.LARGE,
            })
          }
        }
      }

      Column() {
        Text('点击事件')
        Row() {
          UITag({
            type: this.type,
            customText: '被点击',
            onClickEvent: () => {
              this.newClick()
            }
          })
        }
      }

      Text('标签文字过长展示：')
      Row() {
        UITag({
          customText: '默认最大宽度值测试默认啊',
        })
        UITag({
          customText: '自定义宽度',
          customMaxWidth: '50'
        })
      }

      Column() {
        Text('不可用状态')
        Row() {
          UITag({
            customText: '标签',
            enable: false,
          })
          UITag({
            customText: '标签',
            enable: false,
            type: TagType.COLOR,
          })
          UITag({
            customText: '标签',
            enable: false,
            type: TagType.BORDER,
          })
        }
      }

      Column() {
        Text('传入自定义边框颜色、自定义背景色')
        Row() {
          UITag({
            customText: '标签',
            type: TagType.BORDER,
            customBorderColor: Color.Brown
          })
          UITag({
            customText: '标签',
            type: TagType.COLOR,
            customBackgroundColor: Color.Gray
          })
        }
      }
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }
}