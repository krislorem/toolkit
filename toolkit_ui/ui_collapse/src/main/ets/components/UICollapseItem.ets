import { Constants, TitleBorder } from '../common/Constants'

@ComponentV2
export struct UICollapseItem {
  @Builder
  contentBuilder() {
  };

  @Builder
  headerBuilder() {
  };

  // 面板内容
  @BuilderParam contentBuilderParam: () => void = this.contentBuilder;
  // 面板头部（不包括右侧箭头）
  @BuilderParam headerBuilderParam: () => void = this.headerBuilder;
  // 是否禁用
  @Param disabled: boolean = false
  // 是否开启动画
  @Param showAnimation: boolean = false
  // 折叠面板内容分隔线
  @Param hasBorder: boolean = false
  // 折叠面板标题分隔线
  // auto：分隔线自动显示，none：不显示分隔线，show：一直显示分隔线
  @Param titleBorder: string = TitleBorder.AUTO
  // 每个面板的唯一标识
  @Param name: string = ''
  // 当前激活面板改变时触发(如果是手风琴模式，参数类型为string，否则为array),同一折叠面板的value得设置 一致
  @Param value: string | string[] = '';
  // 是否开启手风琴效果，同一折叠面板的value得设置 一致
  @Param accordion: boolean = false
  // 是否展示右侧箭头
  @Param showArrow: boolean = true
  // change事件 切换面板时触发 切换面板时触发，如果是手风琴模式，返回类型为string，否则为array
  @Event onchange: (index: string[] | string) => void = () => {
  };
  // 双向同步,折叠面板value
  @Event $value: (val: string | string[]) => void = (val: string | string[]) => {
  };
  @Local isShow: boolean = false
  @Local contentHeight: Length = Constants.ZERO_SIZE

  aboutToAppear() {
    let newValue: string | string[] = this.value;
    if (this.accordion && Array.isArray(this.value)) {
      newValue = this.value.length ? this.value[0] : '';
    } else if (!this.accordion && !Array.isArray(this.value)) {
      newValue = [this.value]
    }
    this.$value(newValue);
    this.judgeIsShow()
  }

  @Monitor('value','value.length')
  onCollapseChange() {
    this.judgeIsShow()
  }

  // 判断是否展示内容
  judgeIsShow(): void {
    if (Array.isArray(this.value)) {
      this.isShow = this.value.includes(this.name)
    } else {
      this.isShow = this.value === this.name
    }
    this.contentHeight = this.isShow ? Constants.NO_HEIGHT_LIMIT : Constants.ZERO_SIZE
  }

  // 获取value
  queryValue(val: string) {
    let newValue = this.value;
    if (this.accordion) {
      newValue = (newValue === val || newValue?.includes(val)) ? '' : val
    } else {
      if (Array.isArray(newValue)) {
        let index = newValue?.findIndex((el: string) => el === val) as number;
        if (index > Constants.NO_VALUE) {
          // 已存在就说明是已经打开状态，再点击就使面板关闭
          newValue.splice(index, Constants.SPLICE_LENGTH)
        } else {
          // 不存在就需要添加
          newValue.push(val)
        }
      } else {
        if (newValue === val) {
          newValue = []
        } else {
          newValue = newValue.split(',') as string[];
          newValue.push(val)
        }
      }
    }
    this.$value(newValue);
  }

  build() {
    Column() {
      // 头部
      Column() {
        Flex({ justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }) {
          Column() {
            this.headerBuilderParam()
          }

          if (this.showArrow) {
            Image(this.isShow ? $r('app.media.ic_public_arrow_up_0') : $r('app.media.ic_public_arrow_down_0'))
              .width(Constants.IMAGE_SIZE)
              .fillColor($r('sys.color.ohos_id_color_primary'))
          }
        }.width(Constants.FULL_PERCENT)
        .border({
          width: { bottom: this.titleBorder === TitleBorder.SHOW ? Constants.BORDER_WIDTH : Constants.ZERO_SIZE },
          color: $r('sys.color.ohos_id_color_text_field_sub_bg'),
        })
        .padding(Constants.COMMON_PADDING)
      }
      .onClick(() => {
        if (!this.disabled) {
          this.queryValue(this.name)
          this.onchange(this.value)
        }
      })

      // 内容
      Column() {
        this.contentBuilderParam()
      }
      .clip(true)
      .width(Constants.FULL_PERCENT)
      .height(this.contentHeight)
      .animation(this.showAnimation ? {
        duration: Constants.ANIMATION_DUARTION,
        curve: Curve.LinearOutSlowIn,
      } : undefined)
      .padding({ left: Constants.COMMON_PADDING + Constants.CONTEXT_PADDING })
    }
    .border({
      width: { bottom: this.titleBorder !== TitleBorder.NONE ? Constants.BORDER_WIDTH : Constants.ZERO_SIZE },
      color: $r('sys.color.ohos_id_color_text_field_sub_bg'),
    })
    .opacity(this.disabled ? Constants.UNENABLE_OPACITY : Constants.ENABLE_OPACITY)
  }
}