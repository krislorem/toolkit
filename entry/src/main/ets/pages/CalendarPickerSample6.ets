import { SwiperDirection, TypePicker, UICalendarPicker } from '@krislorem/ui-calendar-picker';
import { LengthMetrics } from '@kit.ArkUI';

@Entry
@ComponentV2
struct CalendarPickerSample6 {
  @Local
  selected: Date | undefined = undefined
  @Local
  selectDates: Date[] = []
  @Local
  latestClick: Date | undefined = undefined
  @Local
  type: TypePicker = TypePicker.SINGLE
  @Local
  swiperDirection: SwiperDirection = SwiperDirection.HORIZONTAL
  @Local
  disabledDates: Date[] = []
  @Local
  enableSelectTime: boolean = false
  @Local
  refresh: boolean = false

  @Computed
  get selectDateLabel() {
    if (!this.selected) {
      return '--'
    }
    const dateStr = this.selected.toLocaleDateString()
    const timeStr = this.selected.toLocaleTimeString()
    return this.enableSelectTime ? dateStr + ' ' + timeStr : dateStr
  }

  @Computed
  get selectDatesLabel() {
    if (!this.selectDates.length) {
      return '--'
    }
    return this.selectDates.map((item) => item.toLocaleDateString()).join('; ')
  }

  getTypeLabel() {
    if (this.type === TypePicker.SINGLE) {
      return '单选'
    } else if (this.type === TypePicker.MULTIPLE) {
      return '多选'
    } else {
      return '范围'
    }
  }

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          Column({ space: 16 }) {
            Text('最后一次点击的日期：' + (this.latestClick ? this.latestClick.toLocaleDateString() : '--'))
            Text('单选时选中的日期：' + (this.selectDateLabel))
            Text('多日期或范围选中的日期：' + this.selectDatesLabel)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')

          Flex({ wrap: FlexWrap.Wrap, space: { main: LengthMetrics.px(12), cross: LengthMetrics.px(12) } }) {
            Button('切换单选/多选/范围')
              .onClick(() => {
                this.refreshDisplay(() => {
                  this.type = (this.type + 1) % 3 + 1
                  this.toast('当前选择类型：' + this.getTypeLabel())
                })
              })
            Button('切换横向翻页/纵向滚动展示')
              .onClick(() => {
                this.refreshDisplay(() => {
                  this.swiperDirection =
                    this.swiperDirection === SwiperDirection.HORIZONTAL ? SwiperDirection.VERTICAL :
                      SwiperDirection.HORIZONTAL
                  this.toast('当前展示方向：' + (this.swiperDirection === SwiperDirection.HORIZONTAL ? '横向' : '纵向'))
                })
              })
            Button('是否展示禁选日期')
              .onClick(() => {
                this.refreshDisplay(() => {
                  if (!this.disabledDates.length) {
                    this.disabledDates = [new Date()]
                  } else {
                    this.disabledDates = []
                  }
                  this.toast('是否支持展示禁选日期：' + (this.disabledDates.length ? '是' : '否'))
                })
              })
            Button('是否支持选择时间（仅单日期以及横向滑动）')
              .onClick(() => {
                this.refreshDisplay(() => {
                  this.enableSelectTime = !this.enableSelectTime
                  this.toast('是否支持选择时间：' + (this.enableSelectTime ? '是' : '否'))
                })
              })
          }

          if (!this.refresh) {
            UICalendarPicker({
              embedded: true,
              type: this.type,
              swiperDirection: this.swiperDirection,
              disabledDates: this.disabledDates,
              enableSelectTime: this.enableSelectTime,
              startYear: 2025,
              endYear: 2025,
              onClickDate: (date) => {
                this.latestClick = date;
                if (this.type === TypePicker.SINGLE) {
                  this.selected = date
                } else if (this.type === TypePicker.MULTIPLE) {
                  if (this.selectDates.some((item) => item.toLocaleDateString() === date.toLocaleDateString())) {
                    this.selectDates =
                      this.selectDates.filter((item) => item.toLocaleDateString() !== date.toLocaleDateString())
                  } else {
                    this.selectDates.push(date)
                  }
                } else {
                  if (this.selectDates.length === 2) {
                    this.selectDates = []
                  }
                  this.selectDates.push(date)
                }
                this.selectDates.sort((a, b) => a.getTime() - b.getTime())
              },
            })
              .backgroundColor('#ffffff')
              .layoutWeight(1)
          } else {
            LoadingProgress().width(32)
          }
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('在页面中直接嵌入日期选择')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }

  refreshDisplay(callback: () => void) {
    this.refresh = true
    this.selected = undefined
    this.selectDates = []
    setTimeout(() => {
      callback()
      this.refresh = false
    }, 200)
  }

  toast(message: string) {
    try {
      this.getUIContext().getPromptAction().showToast({ message: JSON.stringify(message) })
    } catch (err) {
      console.error('open toast failed. error:' + JSON.stringify(err))
    }
  }
}