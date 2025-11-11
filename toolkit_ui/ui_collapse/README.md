# 折叠面板组件 ui-collapse

## 目录

- [简介](#简介)
- [约束与限制](#约束与限制)
- [使用](#使用)
- [API参考](#API参考)
- [示例代码](#示例代码)

## 简介

ui-collapse 是一款折叠面板组件，支持显示过长文本，支持修改图标、手风琴效果等功能。

## 约束与限制

### 环境

* DevEco Studio版本：DevEco Studio 5.0.0 Release及以上
* HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上
* 设备类型：华为手机（包括双折叠和阔折叠）、平板
* 系统版本：HarmonyOS 5.0.0(12)及以上

## 使用

1. 安装组件。

   ```
   ohpm install @krislorem/ui-collapse;
   ```

2. 引入组件。

   ```
   import { UICollapse, UICollapseItem, TitleBorder } from '@krislorem/ui-collapse';
   ```

3. 调用组件，详细参数配置说明参见[API参考](#API参考)。

   ``` 
   @Builder
   CollapseItemBuilder() {
      UICollapseItem({
         name: '0',
         value: this.value,
         headerBuilderParam: () => {
            this.headerBuilder('example')
        },
        contentBuilderParam: () => {
            this.contextBuilder('context')
        },
        onchange: (val) => {
            this.changedValue = val;
        }
      })
   }
   
   @Builder
   headerBuilder(title){
      Text(title)
   }
   
   @Builder
   contextBuilder(context){
      Text(context)
   }
   
   UICollapse({
      collapseItemBuilderParam: () => {
         this.CollapseItemBuilder()
      },
   })
   ```

## API参考

### 子组件

UICollapseItem(options: [UICollapseItemOptions](#UICollapseItemOptions对象说明))

折叠面板单元组件。

### 接口

UICollapse(options: [UICollapseOptions](#UICollapseOptions对象说明))

折叠面板组件。

### UICollapseOptions对象说明

| 名称                       | 类型      | 是否必填 | 说明       |
|:-------------------------|:--------|:-----|:---------|
| collapseItemBuilderParam | 自定义构建函数 | 是    | 放置折叠面板内容 |

### UICollapseItemOptions对象说明

| 名称                  | 类型                                 | 是否必填 | 说明                                                                         |
|---------------------|------------------------------------|------|----------------------------------------------------------------------------|
| value               | string \| string[]                 | 是    | 当前激活面板改变时触发(如果是手风琴模式，参数类型为string，否则为Array)，同一个折叠面板的value值须得一致。需要通过!!双向绑定   |
| name                | string                             | 是    | 每个面板的唯一标识                                                                  |
| contentBuilderParam | 自定义构建函数                            | 是    | 面板内容，通过自定义构建函数形式搭建面板内容                                                     |
| headerBuilderParam  | 自定义构建函数                            | 是    | 面板标题，通过自定义构建函数形式搭建面板内容                                                     |
| disabled            | boolean                            | 否    | 是否禁用，默认：false                                                              |
| showAnimations      | boolean                            | 否    | 开启动画，默认：false                                                              |
| titleBorder         | [TitleBorder](#TitleBorder对象说明)    | 否    | 折叠面板标题分隔线                                                                  |
| showArrow           | boolean                            | 否    | 是否显示右侧箭头                                                                   |
| accordion           | boolean                            | 否    | 是否开启手风琴效果，默认：false。同组折叠面板单元组件的value需要保持一致。开启手风琴效果时，accordion属性需要同时设置为true。 |
| onchange            | (value:string \| string[]) => void | 否    | 切换面板时触发，如果是手风琴模式，返回类型为string，否则为string[]                                   |

### TitleBorder对象说明

| 名称   | 说明      |
|:-----|:--------|
| AUTO | 分隔线自动显示 |
| SHOW | 一直显示分隔线 |
| NONE | 不显示分隔线  |

## 示例代码

### 示例1

```
import { UICollapse, UICollapseItem } from '@krislorem/ui-collapse';

@Entry
@ComponentV2
export struct CollapseCommon {
  @Local value: string | string[] = ['0'];
  @Local changedValue: string | string[] = '';

  @Builder
  CollapseItemBuilder() {
    Column() {
      UICollapseItem({
        name: '0',
        value: this.value!!,// 通过!!实现双向绑定。具体语法参见：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-binding
        headerBuilderParam: () => {
          this.headerBuilder('默认开启')
        },
        contentBuilderParam: () => {
          this.contextBuilder('折叠面板默认显示内容由value控制，如果是手风琴模式，参数类型为string，否则为Array,同一个折叠面板的value值须得一致')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '1',
        value: this.value!!,
        disabled: true,
        headerBuilderParam: () => {
          this.headerBuilder('禁用', '')
        },
        contentBuilderParam: () => {
          this.contextBuilder('disabled属性控制面板禁用状态')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '2',
        showAnimation: true,
        value: this.value!!,
        headerBuilderParam: () => {
          this.headerBuilder('使用动画')
        },
        contentBuilderParam: () => {
          this.contextBuilder('通过showAnimation属性可以控制面板是否使用动画，但因机制问题需要将内容设置固定宽度')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '3',
        value: this.value!!,
        headerBuilderParam: () => {
          this.headerBuilder('缩略图', $r('app.media.highlight'))
        },
        contentBuilderParam: () => {
          this.contextBuilder('通过headerBuilderParam函数设置头部样式')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

      UICollapseItem({
        name: '4',
        value: this.value!!,
        showArrow: false,
        headerBuilderParam: () => {
          this.headerBuilder('无箭头图标')
        },
        contentBuilderParam: () => {
          this.contextBuilder('无箭头图标由showArrow字段控制')
        },
        onchange: (val) => {
          this.changedValue = val;
        },
      })

    }
  }

  @Builder
  headerBuilder(title: string, thumb: ResourceStr = '') {
    Row() {
      if (thumb) {
        Image(thumb).width(24).height(24)
      }
      Text(title)
        .fontSize(16)
        .lineHeight(24)
        .fontWeight(500)
        .margin({ left: thumb ? 12 : 0 })
    }
  }

  @Builder
  contextBuilder(context: string) {
    Text(context)
      .fontSize(16)
      .lineHeight(24)
      .padding({ top: 16, bottom: 16 })
      .fontWeight(400)
      .width('100%')
  }

  build() {
    Column() {
      Text('基础用法').fontSize(20).margin({ bottom: 10, top: 10 })
      UICollapse({
        collapseItemBuilderParam: () => {
          this.CollapseItemBuilder()
        },
      }).margin({ left: 16, right: 16 })
    }
  }
}
```

### 示例2

```
import { UICollapse, UICollapseItem, TitleBorder } from '@krislorem/ui-collapse';

@ObservedV2
class contextInfo {
  @Trace context: string = '';
  titleBorder: string = '';
  header: string = '';

  constructor(titleBorder: string, context: string, header: string) {
    this.context = context;
    this.titleBorder = titleBorder;
    this.header = header;
  }
}

@Entry
@ComponentV2
export struct CollapseAccordion {
  @Local value: string | string[] = '';
  @Local accordion: boolean = true
  @Local changedValue: string | string[] = '';
  contextInfos: contextInfo[] = [
    new contextInfo(TitleBorder.NONE, '折叠面板标题分隔线：none', '折叠面板标题分隔线：none'),
    new contextInfo(TitleBorder.SHOW, '折叠面板标题分隔线：show', '折叠面板标题分隔线：show'),
    new contextInfo(TitleBorder.AUTO, '折叠面板标题分隔线：auto', '折叠面板标题分隔线：auto'),
  ];

  @Builder
  CollapseItemBuilder() {
    Column() {
      ForEach(this.contextInfos, (item: contextInfo, index: number) => {
        UICollapseItem({
          name: index.toString(),
          value: this.value!!,// 通过!!实现双向绑定。具体语法参见：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-binding
          accordion: this.accordion,
          titleBorder: item.titleBorder,
          headerBuilderParam: () => {
            this.headerBuilder(item.header)
          },
          contentBuilderParam: () => {
            this.contextBuilder(item)
          },
          onchange: (val) => {
            this.changedValue = val;
          },
        })
      })
    }
  }

  @Builder
  headerBuilder(title: string, thumb: ResourceStr = '') {
    Row() {
      if (thumb) {
        Image(thumb).width(24).height(24)
      }
      Text(title)
        .fontSize(16)
        .lineHeight(24)
        .fontWeight(500)
        .margin({ left: thumb ? 12 : 0 })
    }
  }

  @Builder
  contextBuilder($$: contextInfo) {
    Text($$.context)
      .fontSize(16)
      .lineHeight(24)
      .padding({ top: 16, bottom: 16 })
      .fontWeight(400)
      .width('100%')
  }

  build() {
    Column() {
      Text('手风琴效果').fontSize(20).margin({ bottom: 10, top: 10 })
      UICollapse({
        collapseItemBuilderParam: () => {
          this.CollapseItemBuilder()
        },
      })
        .padding({ top: 16, bottom: 16 })
      Button('动态修改内容').onClick(() => {
        this.contextInfos[0].context =
          this.contextInfos[0].context.length <= 14 ? '折叠面板已经动态修改为新数据,再次点击按钮恢复之前的内容' :
            '折叠面板标题分隔线：none'
      }).margin({ top: 40 })
    }.margin({ left: 16, right: 16 })
  }
}
```