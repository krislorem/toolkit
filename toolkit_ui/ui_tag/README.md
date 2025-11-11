# 标签组件 ui-tag

## 目录

- [简介](#简介)
- [约束与限制](#约束与限制)
- [使用](#使用)
- [API参考](#API参考)
- [示例代码](#示例代码)

## 简介

ui-tag 是一款标签组件，用于展示不同类型的标签，点击可切换选中与否的不同状态。

## 约束与限制

### 环境

* DevEco Studio版本：DevEco Studio5.0.0 Release及以上
* HarmonyOS SDK版本：HarmonyOS5.0.0 Release SDK及以上
* 设备类型：华为手机（包括双折叠和阔折叠）、平板
* 系统版本：HarmonyOS 5.0.0(12)及以上

## 使用

1. 安装组件。

    ```
    ohpm install @krislorem/ui-tag;
    ```

2. 引入组件。

    ```
    import { UITag } from '@krislorem/ui-tag';
    ```

3. 调用组件，详细参数配置说明参见[API参考](#API 参考)。

    ```
    UITag({
      customText: '标签',
      tagSize: TagSize.DEFAULT,
      options: [this.options],
      customBackgroundColor: 'emphasize',
      onClickEvent: () => {
        this.newClick()
      },
    })
    ```

## API 参考

### 子组件

无

### 接口

UITag(options: UITagOptions)

标签组件。

| 参数名     | 类型                                | 是否必填 | 说明         |
|---------|-----------------------------------|------|------------|
| options | [UITagOptions](#UITagOptions对象说明) | 否    | 配置标签组件的参数。 |

### UITagOptions对象说明

| 参数名                   | 类型                                                                                                              | 是否必填 | 说明                                                                                                                  |
|:----------------------|:----------------------------------------------------------------------------------------------------------------|:-----|:--------------------------------------------------------------------------------------------------------------------|
| customText            | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)           | 否    | 标签内容，无默认值                                                                                                           |
| tagSize               | [TagSize](#TagSize枚举说明)                                                                                         | 否    | 标签尺寸，默认值TagSize.DEFAULT                                                                                             |
| customBackgroundColor | string                                                                                                          | 否    | 自定义背景色，默认值 $r('sys.color.ohos_id_color_emphasize') <br/>推荐颜色参考[customBackgroundColor推荐值](#customBackgroundColor推荐值) |
| enable                | boolean                                                                                                         | 否    | 是否启用标签，默认值true                                                                                                      |
| type                  | [TagType](#TagType枚举说明)                                                                                         | 否    | 标签类型，默认值TagType.NORMAL                                                                                              |
| isCapsule             | boolean                                                                                                         | 否    | 是否为胶囊，默认值false                                                                                                      |
| customBorderColor     | string                                                                                                          | 否    | 自定义边框颜色，默认值$r('sys.color.ohos_id_color_emphasize')<br/>推荐颜色参考[customBorderColor推荐值](#customBorderColor推荐值)          |
| customMargin          | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) \| number | 否    | 自定义外边距，无默认值                                                                                                         |
| customMaxWidth        | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) \| number | 否    | 自定义最大宽度，无默认值                                                                                                        |
| onClick               | (callback: () => void )                                                                                         | 否    | 点击标签触发该事件                                                                                                           |

### TagSize 枚举说明

| 名称      | 描述   |
|:--------|:-----|
| LARGE   | 大尺寸  |
| DEFAULT | 正常尺寸 |
| SMALL   | 小尺寸  |

### TagType 枚举说明

| 名称     | 描述   |
|:-------|:-----|
| NORMAL | 常规标签 |
| COLOR  | 彩色标签 |
| BORDER | 边框标签 |

### customBorderColor 推荐值

| 推荐颜色                                    |
|:----------------------------------------|
| $r('sys.color.ohos_id_color_emphasize') |
| $r('sys.color.ohos_id_color_palette1')  |
| $r('sys.color.ohos_id_color_palette2')  |
| $r('sys.color.ohos_id_color_palette3')  |
| $r('sys.color.ohos_id_color_palette4')  |
| $r('sys.color.ohos_id_color_palette5')  |
| $r('sys.color.ohos_id_color_palette6')  |
| $r('sys.color.ohos_id_color_palette7')  |
| $r('sys.color.ohos_id_color_palette8')  |
| $r('sys.color.ohos_id_color_palette9')  |
| $r('sys.color.ohos_id_color_palette10') |

### customBackgroundColor 推荐值

| 推荐颜色                                       |
|:-------------------------------------------|
| $r('sys.color.ohos_id_color_emphasize')    |
| $r('sys.color.ohos_id_color_palette1')     |
| $r('sys.color.ohos_id_color_palette2')     |
| $r('sys.color.ohos_id_color_palette3')     |
| $r('sys.color.ohos_id_color_palette4')     |
| $r('sys.color.ohos_id_color_palette5')     |
| $r('sys.color.ohos_id_color_palette6')     |
| $r('sys.color.ohos_id_color_palette7')     |
| $r('sys.color.ohos_id_color_palette8')     |
| $r('sys.color.ohos_id_color_palette9')     |
| $r('sys.color.ohos_id_color_palette_aux1)  |
| $r('sys.color.ohos_id_color_palette_aux2') |
| $r('sys.color.ohos_id_color_palette_aux4') |
| $r('sys.color.ohos_id_color_palette_aux6') |
| $r('sys.color.ohos_id_color_palette_aux7') |
| $r('sys.color.ohos_id_color_palette_aux8') |
| $r('sys.color.ohos_id_color_palette_aux9') |

## 示例代码

```
import { UITag, TagSize, TagType } from '@krislorem/ui-tag'

@Entry
@ComponentV2
struct TagSample {
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
          customMaxWidth:'50'
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
            customBorderColor:Color.Brown
          })
          UITag({
            customText: '标签',
            type: TagType.COLOR,
            customBackgroundColor:Color.Gray
          })
        }
      }
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .width('100%')
  }
}
```