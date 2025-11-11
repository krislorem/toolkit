# 悬浮按钮组件 ui-fab

## 目录

- [简介](#简介)
- [约束与限制](#约束与限制)
- [使用](#使用)
- [API参考](#API参考)
- [示例代码](#示例代码)

## 简介

ui-fab 是一款悬浮按钮组件，点击可展开一个或多个按钮菜单。支持跟手拖动。

## 约束与限制

### 环境

* DevEco Studio版本：DevEco Studio 5.0.0 Release及以上
* HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上
* 设备类型：华为手机（包括双折叠和阔折叠）、平板
* 系统版本：HarmonyOS 5.0.0(12)及以上

## 使用

1. 安装组件。

   ```
   ohpm install @krislorem/ui-fab;
   ```


2. 引入组件。

   ```
   import { PopMenuContent, TypeFab, TypeClick, UIFab } from '@krislorem/ui-fab';
   ```

3. 调用组件，详细参数配置说明参见[API参考](#API参考)。

   ```
    UIFab({
        fabPosition: { x: 16, y: 16 },
        fabColor: Color.Blue,
        darkIcon: false,
        clickChange: TypeClick.NONE,
        content: [
          {
            id: '1',
            iconPath: $r('app.media.app_icon'),
            iconSelectedPath: $r('app.media.ic_add'),
            text: 'text1',
            popClick: () => {
              console.info('text1: success')
            }
          }
        ],
      })
    ```

## API参考

### 子组件

无

### 接口

UIFab(options: UIFabOptions)

悬浮按钮组件。

| 名称      | 类型                                | 是否必填 | 说明           |
|:--------|:----------------------------------|:-----|:-------------|
| options | [UIFabOptions](#UIFabOptions对象说明) | 否    | 配置悬浮按钮组件的参数。 |

### UIFabOptions对象说明

| 名称            | 类型                                                                                                                                                                                                                                                                                                              | 是否必填< | 说明                                   |
|:--------------|:----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:------|:-------------------------------------|
| fabPosition   | [Position](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#position) \| [Edges](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#edges12) \| [LocalizedEdges](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#localizededges12) | 否     | fab按钮的位置，默认值{left:16,bottom:16}，在左下角 |
| enableDrag    | boolean                                                                                                                                                                                                                                                                                                         | 否     | 是否支持跟手拖动，默认false                     |
| fabColor      | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                                                                                                                                                                           | 否     | fab按钮颜色                              |
| darkIcon      | boolean                                                                                                                                                                                                                                                                                                         | 否     | 图标颜色为深色还是浅色，默值false，为浅色              |
| iconImage     | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                                                                                                                                                                           | 否     | fab按钮中的图标                            |
| showIconImage | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                                                                                                                                                                           | 否     | fab按钮展开后的图标                          |
| clickChange   | [TypeClick](#TypeClick枚举说明)                                                                                                                                                                                                                                                                                     | 否     | 展开菜单选项点击后的效果，默认无效果，TypeClick.NONE    |
| isVertical    | boolean                                                                                                                                                                                                                                                                                                         | 否     | 展开的菜单是横向还是纵向，默认为false，横向             |
| maxWidth      | number                                                                                                                                                                                                                                                                                                          | 否     | 当展开菜单横向时，最大宽度，默认值为280vp              |
| maxHeight     | number                                                                                                                                                                                                                                                                                                          | 否     | 当展开菜单纵向时，最大高度，默认值为280vp              |
| popMenuStyle  | [TypeFab](#TypeFab枚举说明)                                                                                                                                                                                                                                                                                         | 否     | 展开菜单的展开方向，默认向上和向右展开，TypeFab.RIGHT_UP |
| content       | [popMenuContent](#popMenuContent对象说明)[]                                                                                                                                                                                                                                                                         | 否     | 展开菜单的内容                              |

### TypeClick枚举说明

| 名称                | 说明            |
|:------------------|:--------------|
| NONE              | 禁用图标点击发生改变的效果 |
| ICON_CHANGE       | 点击后图标发生变化     |
| BACKGROUND_CHANGE | 点击后背景发生变化     |
| ALL               | 点击后图标和背景都发生变化 |

### TypeFab枚举说明

| 名称          | 说明          |
|:------------|:------------|
| RIGHT_UNDER | 展开菜单向右和向下展开 |
| RIGHT_UP    | 展开菜单向右和向上展开 |
| LEFT_UNDER  | 展开菜单向左和向下展开 |
| LEFT_UP     | 展开菜单向左和向上展开 |

### PopMenuContent对象说明

| 名称               | 类型                                                                                                    | <div style="width:80px" align="left" >是否必填</div> | <div style="width:200px" align="left" >说明</div>                                                |
|:-----------------|:------------------------------------------------------------------------------------------------------|--------------------------------------------------|------------------------------------------------------------------------------------------------|
| id               | string                                                                                                | 是                                                | 分类id，唯一索引，不能重复                                                                                 |
| iconPath         | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) | 是                                                | 菜单图标点击前的路径                                                                                     |
| iconSelectedPath | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) | 是                                                | 菜单图标点击后的路径                                                                                     |
| text             | string                                                                                                | 是                                                | 菜单文本内容。菜单纵向展开时，text文本内的中文最大字数为3，英文最大字数为6，超出则不显示。 菜单横向展开时，text文本内的中文最大字数为10，英文最大字数为20，超出以省略号显示。 |
| popClick         | () => void                                                                                            | 是                                                | 菜单图标点击事件                                                                                       |

## 示例代码

### 示例1

```
import { PopMenuContent, TypeFab, UIFab } from '@krislorem/ui-fab';

@Entry
@ComponentV2
struct FabChangePosition {
  @Local fabColor: ResourceColor = Color.Blue;
  @Local isVertical: boolean = false;
  @Local enableDrag: boolean = false;
  @Local popMenuStyle: TypeFab = TypeFab.RIGHT_UNDER;
  @Local iconColor: boolean = false;
  @Local positionFab: Position | Edges | LocalizedEdges = { left: 16, top: 16 };
  @Local center: Edges = { left: 0, top: 0 };

  build() {
    Column() {
      Column({ space: 4 }) {
        Button(this.isVertical ? '纵向菜单' : '横向菜单')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.isVertical = !this.isVertical;
          })

        Button(this.enableDrag ? '支持拖动' : '不支持拖动')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.enableDrag = !this.enableDrag;
          })

        Button('fab放在左上角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { left: 16, top: 16 };
            this.popMenuStyle = TypeFab.RIGHT_UNDER;
          })
        Button('fab放在右上角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { right: 16, top: 16 };
            this.popMenuStyle = TypeFab.LEFT_UNDER;
          })
        Button('fab放在左下角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { left: 16, bottom: 16 };
            this.popMenuStyle = TypeFab.RIGHT_UP;
          })
        Button('fab放在右下角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { right: 16, bottom: 16 };
            this.popMenuStyle = TypeFab.LEFT_UP;
          })
        Button('fab放在中间')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { top: this.center.top, left: this.center.left };
          })
        Button('菜单展开方向为右和下')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.RIGHT_UNDER;
          })
        Button('菜单展开方向为左和下')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.LEFT_UNDER;
          })
        Button('菜单展开方向为右和上')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.RIGHT_UP;
          })
        Button('菜单展开方向为左和上')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.LEFT_UP;
          })
        Button('更改图标颜色')
          .type(ButtonType.Capsule)
          .onClick(() => {
            if (this.fabColor == Color.Red) {
              this.fabColor = Color.Blue;
            } else if (this.fabColor == Color.Blue) {
              this.fabColor = Color.Red;
            }
          })
        Button('更改icon深浅色')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.iconColor = !this.iconColor;
          })
      }
      .backgroundColor(Color.Gray)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')

      UIFab({
        fabColor: this.fabColor,
        popMenuStyle: this.popMenuStyle,
        fabPosition: this.positionFab,
        enableDrag: this.enableDrag,
        darkIcon: this.iconColor,
        isVertical: this.isVertical,
        content: [
          new PopMenuContent(
            '1',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            '文字文字文字文字文字文字',
            () => {
              console.info('text1: success');
            }),
          new PopMenuContent(
            '2',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text12345',
            () => {
              console.info('text2: success');
            }),
          new PopMenuContent(
            '3',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text3',
            () => {
              console.info('text3: success');
            }),
          new PopMenuContent(
            '4',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text4',
            () => {
              console.info('text4: success');
            }),
          new PopMenuContent(
            '5',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text5',
            () => {
              console.info('text5: success');
            }),
          new PopMenuContent(
            '6',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text6',
            () => {
              console.info('text6: success');
            }),
        ],
      })
    }
    .height('100%')
    .width('100%')
    .onSizeChange((_, n) => {
      this.center.left = (n.width as number) / 2 - 20;
      this.center.top = (n.height as number) / 2;
    })
  }
}
```

### 示例2

```
import { PopMenuContent, TypeClick, UIFab } from '@krislorem/ui-fab';

@Entry
@ComponentV2
struct FabChangeMenu {
  @Local isVertical: boolean = false;
  @Local iconImage: ResourceStr = $r('app.media.ic_public_menu')
  @Local showIconImage: ResourceStr = $r('app.media.ic_public_expand')
  @Local clickChange: TypeClick = TypeClick.NONE

  build() {
    Column() {
      Column({ space: 4 }) {
        Button(this.isVertical ? '纵向菜单' : '横向菜单')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.isVertical = !this.isVertical;
          })
        Button('更换fab按钮的图标')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.iconImage = $r('app.media.ic_public_add');
            this.showIconImage = $r('app.media.ic_public_favor_filled');
          })
        Button('展开菜单的点击样式: 无样式')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.clickChange = TypeClick.NONE;
          })
        Button('展开菜单的点击样式: 更换图标')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.clickChange = TypeClick.ICON_CHANGE;
          })
        Button('展开菜单的点击样式: 点击后背板颜色变深')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.clickChange = TypeClick.BACKGROUND_CHANGE;
          })
        Button('展开菜单的点击样式: 全部样式')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.clickChange = TypeClick.ALL;
          })
      }
      .backgroundColor(Color.Gray)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')

      UIFab({
        iconImage: this.iconImage,
        showIconImage: this.showIconImage,
        clickChange: this.clickChange,
        isVertical: this.isVertical,
        content: [
          new PopMenuContent(
            '1',
            $r('app.media.icon_image'),
            $r('app.media.ic_public_favor_filled'),
            '文字文字文字文字文字',
            () => {
              console.info('text1: success');
            }),
          new PopMenuContent(
            '2',
            $r('app.media.icon_image'),
            $r('app.media.ic_public_favor_filled'),
            'text2345',
            () => {
              console.info('text2: success');
            }),
          new PopMenuContent(
            '3',
            $r('app.media.icon_image'),
            $r('app.media.ic_public_favor_filled'),
            'text3',
            () => {
              console.info('text3: success');
            }),
          new PopMenuContent(
            '4',
            $r('app.media.icon_image'),
            $r('app.media.ic_public_favor_filled'),
            'text4',
            () => {
              console.info('text4: success');
            }),
          new PopMenuContent(
            '5',
            $r('app.media.icon_image'),
            $r('app.media.ic_public_favor_filled'),
            'text5',
            () => {
              console.info('text5: success');
            }),
          new PopMenuContent(
            '6',
            $r('app.media.icon_image'),
            $r('app.media.ic_public_favor_filled'),
            'text6',
            () => {
              console.info('text6: success');
            }),
        ],
      })
    }
    .height('100%')
    .width('100%')
  }
}

```