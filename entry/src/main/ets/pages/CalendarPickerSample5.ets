import {
  CalendarPickerUtil, DialogType, SwiperDirection, TypePicker,
} from '@krislorem/ui-calendar-picker';

@Extend(Row)
function rowStyle() {
  .width('100%')
  .justifyContent(FlexAlign.SpaceBetween)
  .padding(16)
  .borderRadius(12)
  .backgroundColor($r('sys.color.ohos_id_color_card_bg'))
}

@Extend(Text)
function textStyle() {
  .margin({ right: 20 })
  .layoutWeight(1)
}

@Entry
@ComponentV2
struct CalendarPickerSample5 {
  @Local selectedDate: Date = new Date(2025, 11, 10);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          Row() {
            Text('Api方式拉起常规弹窗，单选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.SINGLE,
                  dialogType: DialogType.DIALOG,
                  startYear: 2025,
                  endYear: 2035,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，单选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.SINGLE,
                  dialogType: DialogType.SHEET,
                  startYear: 2025,
                  endYear: 2035,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，纵向滑动，单选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.SINGLE,
                  dialogType: DialogType.SHEET,
                  swiperDirection: SwiperDirection.VERTICAL,
                  startYear: 2025,
                  endYear: 2035,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，设置range范围，多选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.MULTIPLE,
                  dialogType: DialogType.SHEET,
                  rangeLimit: [new Date()],
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，设置禁选日期，多选：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.MULTIPLE,
                  dialogType: DialogType.SHEET,
                  disabledDates: [
                    new Date(),
                    new Date('2025-10-15'),
                    new Date('2025-11-20'),
                    new Date('2025-12-25'),
                  ],
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()

          Row() {
            Text('Api方式拉起半模态弹窗，设置最大跨度，时间段选择：').textStyle()
            Button('点击')
              .onClick(() => {
                CalendarPickerUtil.show({
                  type: TypePicker.RANGE,
                  dialogType: DialogType.SHEET,
                  maxGap: 3,
                  onSelected: (date) => {
                    this.toast(date)
                  },
                })
              })
          }.rowStyle()
        }
        .width('100%')
      }
      .padding(16)
      .height('100%')
      .edgeEffect(EdgeEffect.Spring)
      .align(Alignment.TopStart)
    }
    .title('Api方式拉起选择器')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }

  toast(date: Date | Date[]) {
    let message = ''
    if (date instanceof Date) {
      message = date.toLocaleDateString()
    } else {
      message = date.map((item) => item.toLocaleDateString()).join(';')
    }
    try {
      this.getUIContext().getPromptAction().showToast({ message: JSON.stringify(message) })
    } catch (err) {
      console.error('open toast failed. error:' + JSON.stringify(err))
    }
  }
}