import {
  AvoidAreaCallback, AvoidAreaInfo, CommonGridSetting, PaddingType, UIBase,
} from '@krislorem/ui-base';
import { MonthModel, UICalendarPickerOptions } from '../common/Model';
import {
  DAY_WIDTH, DialogType, SwiperDirection, TypePicker,
} from '../common/Constant';
import { DateUtils } from '../common/Util';
import { UICalendarVM } from '../viewmodel/UICalendarVM';
import { MonthView } from './MonthView';
import { inspector } from '@kit.ArkUI';
import { ConfigUtil } from '../common/ConfigUtil';

@Extend(Image)
function arrowStyle(customColor: ResourceColor, disabled: boolean = false, w: number = 12, h: number = 20) {
  .width(w)
  .height(h)
  .fillColor(customColor)
  .interpolation(ImageInterpolation.High)
  .draggable(false)
  .opacity(disabled ? $r('sys.float.ohos_id_alpha_content_tertiary') : 1)
  .responseRegion({
    x: '-20%',
    y: '-20%',
    width: '130%',
    height: '130%',
  })
}

@Extend(Button)
function btnStyle(fontSize: Length) {
  .type(ButtonType.Normal)
  .buttonStyle(ButtonStyleMode.TEXTUAL)
  .borderRadius(8)
  .fontSize(fontSize)
  .fontColor($r('sys.color.ohos_id_color_text_secondary'))
  .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
  .padding({
    top: 0,
    bottom: 0,
    left: 16,
    right: 16,
  })
}

@Extend(Text)
function textStyle(fontSize: Length) {
  .fontSize(fontSize)
  .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
  .fontColor($r('sys.color.ohos_id_color_text_primary'))
}

@Extend(Button)
function iconContainerStyle() {
  .type(ButtonType.Circle)
  .width(40)
  .height(40)
  .backgroundColor($r('sys.color.ohos_id_color_button_normal'))
}

@Builder
export function buildUICalendarDialog(options?: UICalendarPickerOptions) {
  UICalendarDialog({
    options,
  })
}

@ComponentV2
export struct UICalendarDialog {
  @Param
  options: UICalendarPickerOptions | undefined = undefined
  @Consumer('openByDialog')
  openByDialog: boolean = false;
  // 年月滚轮视图
  @Local monthPickerVisible: boolean = false;
  // 时间滚轮
  @Local timePickerVisible: boolean = false;
  @Local paddingTop: number = 0;
  @Local paddingBottom: number = 0;
  @Local showNearMonth: boolean = false;
  calendarVM: UICalendarVM = new UICalendarVM();
  private swiperController: SwiperController = new SwiperController();
  // 监听Swiper中间元素layout，左右两边元素做分帧处理
  private _middleMonthId: string = 'MiddleMonthID'
  private listener: inspector.ComponentObserver = inspector.createComponentObserver(this._middleMonthId);

  build() {
    if (this.openByDialog || !this.calendarVM.embedded) {
      if (this.calendarVM.dialogType === DialogType.DIALOG) {
        this.buildDialog()
      } else if (this.calendarVM.swiperDirection === SwiperDirection.HORIZONTAL) {
        this.buildSheet()
      } else {
        this.buildListSheetView()
      }
    } else {
      if (this.calendarVM.swiperDirection === SwiperDirection.HORIZONTAL) {
        this.buildDialog()
      } else {
        this.buildListView()
      }
    }
  }

  aboutToAppear(): void {
    this.handleScreenChange();
    this.listener.on('layout', this.middleMonthLayoutCB);
    this.calendarVM.init(this.options)
  }

  aboutToDisappear(): void {
    UIBase.offAvoidAreaChange(this.avoidAreaChangeWatch);
    this.listener.off('layout', this.middleMonthLayoutCB);
  }

  handleScreenChange() {
    const data: PaddingType | undefined = AvoidAreaInfo.getAvoidAreaOnce();
    this.handlePadding(data);
    UIBase.onAvoidAreaChange(this.avoidAreaChangeWatch);
  }

  avoidAreaChangeWatch = (data: AvoidAreaCallback) => {
    const resp: PaddingType = AvoidAreaInfo.handle(data);
    this.handlePadding(resp);
  };
  middleMonthLayoutCB = () => {
    this.showNearMonth = true;
  };

  handlePadding(data: PaddingType | undefined) {
    this.paddingTop = data?.top || 0;
    if (UIBase.isWindowLayoutFullScreen()) {
      this.paddingBottom = data?.bottom || 0;
    }
  }

  @Builder
  buildMonthPicker() {
    Column() {
      Row() {
        TextPicker({
          range: [this.calendarVM.yearLabels, this.calendarVM.monthLabels],
          selected: [this.calendarVM.currShowDate.getFullYear() - this.calendarVM.startYear,
            this.calendarVM.currShowDate.getMonth()],
        })
          .width('100%')
          .constraintSize({ minHeight: 160, maxHeight: 280 })
          .selectedTextStyle({
            color: this.calendarVM.customColor,
            font: {
              size: $r('sys.float.ohos_id_text_size_headline7'),
              family: $r('sys.string.ohos_id_text_font_family_medium'),
            },
          })
          .textStyle({
            color: $r('sys.color.ohos_id_color_text_secondary'),
            font: {
              size: $r('sys.float.ohos_id_text_size_sub_title1'),
              family: $r('sys.string.ohos_id_text_font_family_regular'),
            },
          })
          .disappearTextStyle({
            color: $r('sys.color.ohos_id_color_text_tertiary'),
            font: {
              size: $r('sys.float.ohos_id_text_size_sub_title3'),
              family: $r('sys.string.ohos_id_text_font_family_regular'),
            },
          })
          .onChange((value, index) => {
            this.calendarVM.yearMonthTuple = index as number[];
          })
      }
      .width('100%')
      .margin({ top: 30, bottom: 20 })

      Row({ space: 14 }) {
        Button($r('app.string.cancel'))
          .btnStyle(ConfigUtil.uiConfig.fontSize.btn)
          .onClick(() => {
            this.monthPickerVisible = false;
            this.calendarVM.yearMonthTuple = [this.calendarVM.currShowDate.getFullYear() - this.calendarVM.startYear,
              this.calendarVM.currShowDate.getMonth()];
          })
        Button($r('app.string.confirm'))
          .btnStyle(ConfigUtil.uiConfig.fontSize.btn)
          .onClick(() => {
            this.monthPickerVisible = false;
            this.calendarVM.changeYearMonth();
          })
      }.alignSelf(ItemAlign.End)
    }
    .width('100%')
  }

  @Builder
  buildTimePicker() {
    Column() {
      TimePicker({
        selected: (this.calendarVM.inSelectedDate || this.calendarVM.currShowDate),
        format: TimePickerFormat.HOUR_MINUTE_SECOND,
      })
        .width('100%')
        .constraintSize({ minHeight: 160, maxHeight: 280 })
        .useMilitaryTime(this.calendarVM.isMilitaryTime)
        .onChange((value: TimePickerResult) => {
          if (value.hour >= 0) {
            this.calendarVM.selectedTime = value;
          }
        })
        .selectedTextStyle({
          color: this.calendarVM.customColor,
          font: {
            size: $r('sys.float.ohos_id_text_size_headline7'),
            family: $r('sys.string.ohos_id_text_font_family_medium'),
          },
        })
        .textStyle({
          color: $r('sys.color.ohos_id_color_text_secondary'),
          font: {
            size: $r('sys.float.ohos_id_text_size_sub_title1'),
            family: $r('sys.string.ohos_id_text_font_family_regular'),
          },
        })
        .disappearTextStyle({
          color: $r('sys.color.ohos_id_color_text_tertiary'),
          font: {
            size: $r('sys.float.ohos_id_text_size_sub_title3'),
            family: $r('sys.string.ohos_id_text_font_family_regular'),
          },
        })

      Row({ space: 14 }) {
        Button($r('app.string.cancel'))
          .btnStyle(ConfigUtil.uiConfig.fontSize.btn)
          .onClick(() => {
            this.timePickerVisible = false;
            this.calendarVM.selectedTime = {
              hour: this.calendarVM.inSelectedDate?.getHours() || 0,
              minute: this.calendarVM.inSelectedDate?.getMinutes() || 0,
              second: this.calendarVM.inSelectedDate?.getSeconds() || 0,
            };
          })
        Button($r('app.string.confirm'))
          .btnStyle(ConfigUtil.uiConfig.fontSize.btn)
          .onClick(() => {
            this.calendarVM.showNowLabel = false;
            this.timePickerVisible = false;
            this.calendarVM.inSelectedDate?.setHours(this.calendarVM.selectedTime.hour,
              this.calendarVM.selectedTime.minute, this.calendarVM.selectedTime.second);
          })
      }.alignSelf(ItemAlign.End)
    }

  }

  @Builder
  buildHeader() {
    Row() {
      Row() {
        Text(DateUtils.formatYear(this.calendarVM.currShowDate.getFullYear().toString()))
          .textStyle(ConfigUtil.uiConfig.fontSize.year)
        Text(this.calendarVM.monthLabels[this.calendarVM.currShowDate.getMonth()])
          .textStyle(ConfigUtil.uiConfig.fontSize.year)
          .margin({ left: 4 })
        Image($r('app.media.ic_public_arrow_right'))
          .arrowStyle(this.calendarVM.customColor)
          .margin({ left: ConfigUtil.uiConfig.margin.yearToArrow })
      }
      .onClick(() => {
        this.monthPickerVisible = true;
      })

      if (this.calendarVM.showTime) {
        Row() {
          Text(this.calendarVM.getTimeLabel())
            .textStyle(ConfigUtil.uiConfig.fontSize.year)
          Image($r('app.media.ic_public_arrow_right'))
            .arrowStyle(this.calendarVM.customColor)
            .margin({ left: ConfigUtil.uiConfig.margin.yearToArrow })
        }
        .opacity(Boolean(this.calendarVM.inSelectedDate) ? 1 : $r('sys.float.ohos_id_alpha_content_tertiary'))
        .enabled(Boolean(this.calendarVM.inSelectedDate))
        .onClick(() => {
          this.timePickerVisible = true;
        })
      } else {
        Row() {
          Image($r('app.media.ic_public_arrow_left'))
            .arrowStyle(this.calendarVM.customColor, this.calendarVM.isReachStart())
            .enabled(!this.calendarVM.isReachStart())
            .onClick(() => {
              this.swiperController.showPrevious();
            })

          Image($r('app.media.ic_public_arrow_right'))
            .arrowStyle(this.calendarVM.customColor, this.calendarVM.isReachEnd())
            .margin({ left: ConfigUtil.uiConfig.margin.arrowToArrow })
            .enabled(!this.calendarVM.isReachEnd())
            .onClick(() => {
              this.swiperController.showNext();
            })
        }
      }

    }
    .width('100%')
    .padding({
      left: 8,
      right: 8,
      top: 8,
      bottom: 8,
    })
    .margin({ bottom: ConfigUtil.uiConfig.margin.yearToWeek })
    .justifyContent(FlexAlign.SpaceBetween)
  }

  @Builder
  buildWeekLabels() {
    Row() {
      ForEach(this.calendarVM.weekLabels, (item: string) => {
        Text(item)
          .fontSize(ConfigUtil.uiConfig.fontSize.week)
          .fontColor($r('sys.color.ohos_id_color_text_tertiary'))
          .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
          .lineHeight(18)
          .textAlign(TextAlign.Center)
          .width(DAY_WIDTH)
      })
    }.margin({ bottom: ConfigUtil.uiConfig.margin.weekToDay }).width('100%')
  }

  @Builder
  buildFooter() {
    if (this.calendarVM.dialogType === DialogType.DIALOG &&
      (this.calendarVM.type !== TypePicker.SINGLE || this.calendarVM.showTime)) {
      Row({ space: 14 }) {
        Button($r('app.string.cancel'))
          .btnStyle(ConfigUtil.uiConfig.fontSize.btn)
          .onClick(() => {
            this.calendarVM.cancelSelect();
          })

        Button($r('app.string.confirm'))
          .btnStyle(ConfigUtil.uiConfig.fontSize.btn)
          .enabled(this.calendarVM.isSelectedValid)
          .onClick(() => {
            this.calendarVM.confirmSelect();
          })
      }
      .justifyContent(FlexAlign.End)
      .margin({ top: 4 })
      .width('100%')
    }
  }

  @Builder
  buildScrollerInside() {
    Stack() {
      Column() {
        this.buildHeader()
        this.buildWeekLabels()
        Swiper(this.swiperController) {
          MonthView({ month: this.calendarVM.preMonth, calendarVM: this.calendarVM })
            .visibility(this.showNearMonth ? Visibility.Visible : Visibility.Hidden)

          MonthView({ month: this.calendarVM.currentMonth, calendarVM: this.calendarVM }).id(this._middleMonthId)

          MonthView({ month: this.calendarVM.nextMonth, calendarVM: this.calendarVM })
            .visibility(this.showNearMonth ? Visibility.Visible : Visibility.Hidden)
        }
        .width('100%')
        .aspectRatio(7 / 6)
        .index($$this.calendarVM.curMonthIndex)
        .indicator(false)
        .loop(true)
        .onAnimationStart((index: number, targetIndex: number) => {
          this.calendarVM.onAnimationStart(index, targetIndex);
        })
        .onGestureRecognizerJudgeBegin((event: BaseGestureEvent, current: GestureRecognizer) => {
          return this.calendarVM.onGestureRecognizerJudgeBegin(event, current);
        })

        this.buildFooter()
      }
      .width('100%')
      .visibility(this.monthPickerVisible || this.timePickerVisible ? Visibility.Hidden : Visibility.Visible)

      if (this.monthPickerVisible) {
        this.buildMonthPicker()
      } else if (this.timePickerVisible) {
        this.buildTimePicker()
      }
    }
    .alignContent(Alignment.Center)
    .borderRadius($r('sys.float.ohos_id_corner_radius_default_l'))
    .backgroundColor($r('sys.color.ohos_id_color_dialog_bg'))
    .padding({
      left: ConfigUtil.uiConfig.margin.outerLeft,
      right: ConfigUtil.uiConfig.margin.outerLeft,
      top: ConfigUtil.uiConfig.margin.outerTop,
      bottom: ConfigUtil.uiConfig.margin.outerTop,
    })
  }

  @Builder
  buildDialog() {
    GridRow(CommonGridSetting.getCommonGridOption(GridRowDirection.RowReverse)) {
      GridCol({
        span: 4,
        offset: {
          sm: 0,
          md: 2,
          lg: 4,
          xl: 4,
        },
      }) {
        Column() {
          Scroll() {
            this.buildScrollerInside()
          }
          .translate({ y: this.calendarVM.yOffset })
          .width('100%')
          .onClick(() => {
          })
        }
        .width('100%')
        .height('auto')
        .justifyContent(FlexAlign.Center)
        .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
        .padding({ top: this.paddingTop, bottom: this.paddingBottom })
      }
    }
    .onClick(() => {
      this.calendarVM.close();
    })
    .margin({
      left: ConfigUtil.gridMargin,
      right: ConfigUtil.gridMargin,
    })
    .onBreakpointChange((breakpoint) => {
      ConfigUtil.updateBreakPoint(breakpoint)
    })
  }

  @Builder
  sheetTitleBuilder() {
    Row({ space: 4 }) {
      Button() {
        Image($r('app.media.ic_public_close_sheet'))
          .width(20)
          .height(20)
          .fillColor($r('sys.color.ohos_id_color_primary'))
          .draggable(false)
      }
      .iconContainerStyle()
      .onClick(() => {
        this.calendarVM.cancelSelect();
      })

      Text(this.calendarVM.sheetTitle)
        .fontSize($r('sys.float.ohos_id_text_size_headline8'))
        .fontColor($r('sys.color.ohos_id_color_text_primary'))
        .fontWeight(FontWeight.Bold)
        .fontFamily($r('sys.string.ohos_id_text_font_family_medium'))
        .margin({ left: 8, right: 8 })
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .layoutWeight(1)
        .textAlign(TextAlign.Start)

      Blank()

      Button() {
        Image($r('app.media.ic_public_confirm_sheet'))
          .width(20)
          .height(20)
          .fillColor($r('sys.color.ohos_id_color_primary'))
          .draggable(false)
      }
      .iconContainerStyle()
      .enabled(this.calendarVM.isSelectedValid)
      .onClick(() => {
        this.calendarVM.confirmSelect();
      })

    }.width('100%')
  }

  @Builder
  buildSheet() {
    Column({ space: 16 }) {
      this.sheetTitleBuilder()
      Scroll() {
        this.buildScrollerInside()
      }
      .layoutWeight(1)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
    .padding({
      left: 16,
      right: 16,
      top: 16,
      bottom: 30,
    })
  }

  @Builder
  groupHeader(v: MonthModel) {
    Row({ space: 4 }) {
      Text(DateUtils.formatYear(v.year.toString()))
        .textStyle(ConfigUtil.uiConfig.fontSize.year)
      Text(this.calendarVM.monthLabels[v.month - 1])
        .textStyle(ConfigUtil.uiConfig.fontSize.year)
    }
    .width('100%')
    .padding(10)
    .margin({ bottom: 4 })
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }

  @Builder
  buildListSheetView() {
    Column() {
      Row() {
        this.sheetTitleBuilder()
      }
      .width('100%')
      .padding({
        top: 10,
        bottom: 10,
      })

      this.buildWeekLabels()
      this.buildListView()
    }
    .padding({
      left: 16,
      right: 16,
    })
  }

  @Builder
  buildListView() {
    List({ initialIndex: this.calendarVM.curMonthIndex, scroller: this.calendarVM.listScroller }) {
      LazyForEach(this.calendarVM.monthDataSource, (v: MonthModel) => {
        ListItemGroup({ header: this.groupHeader(v) }) {
          ListItem() {
            MonthView({ month: v, calendarVM: this.calendarVM })
          }
        }
      }, (v: MonthModel) => `${v.year}-${v.month}`)
    }
    .width('100%')
    .layoutWeight(1)
    .sticky(StickyStyle.Header)
    .scrollBar(BarState.Off)
    .cachedCount(2)
    .onScrollIndex((start: number, end: number, center: number) => {
      this.calendarVM.onScrollIndex(start, end, center);
    })
  }
}