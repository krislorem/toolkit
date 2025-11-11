import { UICollapse, UICollapseItem } from '@krislorem/ui-collapse';

@Entry
@ComponentV2
export struct CollapseCommonPage {
  @Local value: string | string[] = ['0'];
  @Local changedValue: string | string[] = '';

  @Builder
  CollapseItemBuilder() {
    Column() {
      UICollapseItem({
        name: '0',
        value: this.value!!, // 通过!!实现双向绑定。具体语法参见：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/arkts-new-binding
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
          this.headerBuilder('缩略图', $r('app.media.startIcon'))
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
      Text('基础用法').fontSize(20).margin({ bottom: 10, top: 50 })
      UICollapse({
        collapseItemBuilderParam: () => {
          this.CollapseItemBuilder()
        },
      }).margin({ left: 16, right: 16 })
    }
  }
}