import { buildUICalendarDialog, UICalendarDialog } from './UICalendarDialog';
import { DialogType, END_YEAR, MAX_GAP_DEFAULT, START_YEAR, SwiperDirection, TypePicker } from '../common/Constant';
import { DateUtils } from '../common/Util';
import { UICalendarPickerOptions } from '../common/Model';
import { CalendarPickerUtil } from '../common/CalendarPickerUtil';


@Extend(Text)
function textStyle() {
  .fontSize($r('sys.float.ohos_id_text_size_body1'))
  .lineHeight(19)
}

@ComponentV2
export struct UICalendarPicker {
  @BuilderParam customBuildPanel: () => void
  /**
   * 日期选择器的类型
   */
  @Param type: TypePicker = TypePicker.SINGLE;
  /**
   * 弹窗类型
   */
  @Param dialogType: DialogType = DialogType.SHEET;
  /**
   * 滑动方向
   */
  @Param swiperDirection: SwiperDirection = SwiperDirection.HORIZONTAL;
  /**
   * 定制主题色
   */
  @Param customColor: ResourceColor = $r('sys.color.ohos_id_color_text_primary_activated');
  /**
   * 定制文字颜色
   */
  @Param customFontColor: ResourceColor = $r('sys.color.ohos_id_color_text_primary');
  /**
   * 一周起始天，默认是星期天，取值范围 0 - 6
   */
  @Param startDayOfWeek: number = 0;
  /**
   * 切换年月的起始年份
   */
  @Param startYear: number = START_YEAR;
  /**
   * 切换年月的结束年份
   */
  @Param endYear: number = END_YEAR;
  /**
   * 单日期，支持传入默认值
   */
  @Param @Once selected: Date | null = null;
  /**
   * 多日期，支持传入默认值
   */
  @Param @Once selectDates: Date[] = [];
  /**
   * y方向上的偏移
   */
  @Param yOffset: number = 0;
  /**
   * 设置可选范围
   */
  @Param rangeLimit: Date[] = [];
  /**
   * 设置禁选日期，仅针对单日期、多日期生效
   */
  @Param disabledDates: Date[] = [];
  /**
   * 禁止使用日期的自定义文字
   */
  @Param disableDayLabel: ResourceStr = $r('app.string.disable_day_label');
  /**
   * 针对时间段类型，设置起止日期的跨度
   */
  @Param maxGap: number = MAX_GAP_DEFAULT;
  /**
   * 支持选择时间
   */
  @Param enableSelectTime: boolean = false;
  /**
   * 针对时间选择，展示时间是否为24小时制
   */
  @Param isMilitaryTime: boolean = false;
  /**
   * 半模态弹窗标题文字
   */
  @Param sheetTitle: ResourceStr = '';
  /**
   * 半模态弹窗高度，水平滑动
   */
  @Param sheetH: SheetSize | Length = 500;
  /**
   * 半模态弹窗高度档位，垂直滑动
   */
  @Param detents: [
    (SheetSize | Length),
    (SheetSize | Length)?,
    (SheetSize | Length)?
  ] = [SheetSize.LARGE, SheetSize.MEDIUM];
  /**
   * 是否直接嵌入页面
   */
  @Param embedded: boolean = false
  /**
   * 确认选择后的回调
   */
  @Event
  onSelected: (date: Date | Date[]) => void = () => {
  };
  /**
   * 点击日期的回调
   */
  @Event
  onClickDate: (date: Date) => void = () => {
  };
  /**
   * 取消选择的回调
   */
  @Event
  cancel: () => void = () => {
  };
  @Provider('openByDialog') openByDialog: boolean = true
  @Local calendarOptions: UICalendarPickerOptions | undefined = undefined

  @Computed
  get singleDateLabel() {
    if (!this.selected) {
      return $r('app.string.select_placeholder');
    }
    return DateUtils.formatDate(this.selected);
  }

  @Computed
  get singleDateTimeLabel() {
    if (!this.selected) {
      return $r('app.string.select_placeholder');
    }
    return DateUtils.formatDateTime(this.selected);
  }

  @Computed
  get multiDateLabel() {
    if (!this.selectDates.length) {
      return $r('app.string.select_placeholder');
    }
    const listCut = [...this.selectDates];
    listCut.splice(2);
    let label = listCut.map((item) => {
      return DateUtils.formatDate(item);
    }).join('; ')
    if (this.selectDates.length > 2) {
      label += '...'
    }
    return label;
  }

  @Computed
  get dateRangeLabel() {
    if (this.selectDates.length <= 0) {
      return $r('app.string.select_placeholder');
    }
    if (this.selectDates.length === 1) {
      return `${DateUtils.formatDate(this.selectDates[0])}-`;
    }
    return `${DateUtils.formatDate(this.selectDates[0])}-${DateUtils.formatDate(this.selectDates[1])}`;
  }

  aboutToAppear(): void {
    this.openByDialog = !this.embedded
    this.calendarOptions = {
      type: this.type,
      dialogType: this.dialogType,
      swiperDirection: this.swiperDirection,
      customColor: this.customColor,
      customFontColor: this.customFontColor,
      startDayOfWeek: this.startDayOfWeek,
      startYear: this.startYear,
      endYear: this.endYear,
      selected: this.selected,
      selectDates: this.selectDates,
      yOffset: this.yOffset,
      rangeLimit: this.rangeLimit,
      disabledDates: this.disabledDates,
      disableDayLabel: this.disableDayLabel,
      maxGap: this.maxGap,
      enableSelectTime: this.enableSelectTime,
      isMilitaryTime: this.isMilitaryTime,
      sheetTitle: this.sheetTitle,
      embedded: this.embedded,
      sheetH: this.sheetH,
      detents: this.detents,
      onSelected: (date: Date | Date[]) => {
        if (date instanceof Date) {
          this.selected = date;
          this.calendarOptions!.selected = date;
        } else {
          this.selectDates = date;
          this.calendarOptions!.selectDates = date;
        }
        this.onSelected(date);
      },
      cancel: () => {
        this.cancel();
      },
      onClickDate: (date: Date) => {
        this.onClickDate(date);
      },
    }
  }

  @Builder
  buildPanel() {
    Row({ space: 4 }) {
      if (this.type === TypePicker.SINGLE) {
        if (this.enableSelectTime) {
          Text(this.singleDateTimeLabel).textStyle()
        } else {
          Text(this.singleDateLabel).textStyle()
        }
      } else if (this.type === TypePicker.MULTIPLE) {
        Text(this.multiDateLabel).textStyle()
      } else {
        Text(this.dateRangeLabel).textStyle()
      }
      Image($r('app.media.ic_public_arrow_right'))
        .width(12)
        .height(20)
        .fillColor($r('sys.color.ohos_id_color_primary'))
        .objectFit(ImageFit.Contain)
        .interpolation(ImageInterpolation.High)
    }
  }

  build() {
    Column() {
      if (this.embedded) {
        buildUICalendarDialog(this.calendarOptions)
      } else {
        Column() {
          if (this.customBuildPanel) {
            this.customBuildPanel()
          } else {
            this.buildPanel()
          }
        }
        .onClick(() => {
          this.openByDialog = true
          CalendarPickerUtil.show(this.calendarOptions)
        })
      }
    }
  }
}