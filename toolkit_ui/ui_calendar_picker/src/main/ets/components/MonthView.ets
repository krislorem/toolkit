import { ConfigUtil } from '../common/ConfigUtil';
import { DAY_WIDTH } from '../common/Constant';
import { DayModel, MonthModel } from '../common/Model'
import { UICalendarVM } from '../viewmodel/UICalendarVM';

@ComponentV2
export struct MonthView {
  @Param calendarVM: UICalendarVM = new UICalendarVM();
  @Param month: MonthModel = new MonthModel(1, 1, []);

  @Computed
  get MonthViewH() {
    return this.calendarVM.isSwiper() ? '100%' : 'auto';
  }

  @Builder
  buildDay(obj: RepeatItem<DayModel>) {
    Row() {
      Column() {
        Text(obj.item.day.toString())
          .fontSize(ConfigUtil.uiConfig.fontSize.day)
          .fontColor(this.calendarVM.getFontColor(obj.item))
          .fontWeight(FontWeight.Medium)
          .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))

        // 减少不必要的render时间
        if (this.calendarVM.isShowDisabledLabel) {
          Text(this.calendarVM.isDisabledDate(obj.item) ? this.calendarVM.disableDayLabel : ' ')
            .fontSize($r('sys.float.ohos_id_text_size_caption'))
            .fontColor(this.calendarVM.isSelected(obj.item) ? $r('sys.color.ohos_id_color_text_primary_contrary') :
              this.calendarVM.customFontColor)
            .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
        } else {
          Text('')
        }
      }
      .width('100%')
      .height('100%')
      .opacity(this.calendarVM.isEnable(obj.item) ? 1 : $r('sys.float.ohos_id_alpha_content_tertiary'))
      .borderRadius(4)
      .backgroundColor(this.calendarVM.isSelected(obj.item) ? this.calendarVM.customColor : '')
      .justifyContent(FlexAlign.Center)
      .stateStyles(
        {
          pressed: {
            .backgroundColor($r('sys.color.ohos_id_color_click_effect'))
          },
        },
      )
    }
    .visibility(this.calendarVM.isDayVisible(obj.item))
    .width(DAY_WIDTH)
    .aspectRatio(1)
    .padding({
      left: ConfigUtil.uiConfig.margin.dayLeft,
      right: ConfigUtil.uiConfig.margin.dayLeft,
      top: ConfigUtil.uiConfig.margin.dayTop,
      bottom: ConfigUtil.uiConfig.margin.dayTop,
    })
    .enabled(this.calendarVM.isEnable(obj.item))
    .onClick(() => {
      this.calendarVM.clickDate(obj.item);
    })
  }

  @Builder
  buildDayBg(obj: RepeatItem<DayModel>) {
    Row() {
      Text('')
        .width('100%')
        .height('100%')
        .backgroundColor(this.calendarVM.isInRange(obj.item) ? this.calendarVM.customColor : '')
        .opacity($r('sys.float.ohos_id_alpha_highlight_bg'))
        .borderRadius({
          topLeft: this.calendarVM.isStartDate(obj.item) ? 4 : 0,
          topRight: this.calendarVM.isEndDate(obj.item) ? 4 : 0,
          bottomLeft: this.calendarVM.isStartDate(obj.item) ? 4 : 0,
          bottomRight: this.calendarVM.isEndDate(obj.item) ? 4 : 0,
        })
        .pixelRound({
          start: PixelRoundCalcPolicy.NO_FORCE_ROUND,
          end: PixelRoundCalcPolicy.NO_FORCE_ROUND,
        })
    }
    .visibility(this.calendarVM.isDayVisible(obj.item))
    .width(DAY_WIDTH)
    .aspectRatio(1)
    .pixelRound({
      start: PixelRoundCalcPolicy.NO_FORCE_ROUND,
      end: PixelRoundCalcPolicy.NO_FORCE_ROUND,
    })
    .padding({
      top: ConfigUtil.uiConfig.margin.dayTop,
      bottom: ConfigUtil.uiConfig.margin.dayTop,
      left: this.calendarVM.isStartDate(obj.item) ? ConfigUtil.uiConfig.margin.dayLeft : 0,
      right: this.calendarVM.isEndDate(obj.item) ? ConfigUtil.uiConfig.margin.dayLeft : 0,
    })
  }

  build() {
    Flex({
      wrap: FlexWrap.Wrap,
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.Center,
      alignItems: ItemAlign.Center,
      alignContent: FlexAlign.SpaceBetween,
    }) {
      Repeat<DayModel>(this.month.data)
        .each((obj: RepeatItem<DayModel>) => {
          if (this.calendarVM.isTypeRange) {
            Stack() {
              this.buildDayBg(obj)
              this.buildDay(obj)
            }
            .pixelRound({
              start: PixelRoundCalcPolicy.NO_FORCE_ROUND,
              end: PixelRoundCalcPolicy.NO_FORCE_ROUND,
            })
          } else {
            this.buildDay(obj)
          }
        })
    }
    .height(this.MonthViewH)
    .width('100%')
  }
}