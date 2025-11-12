import { DialogType, SwiperDirection, TypePicker, UICalendarPicker } from '@krislorem/ui-calendar-picker';

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
struct CalendarPickerSample1 {
  @Local selectedDate: Date = new Date(2025, 11, 10);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 10 }) {
          Row() {
            Text('常规弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.DIALOG,
              startYear: 2024,
              endYear: 2034,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              startYear: 2025,
              endYear: 2025,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动,2025年：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              startYear: 2025,
              endYear: 2025,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动，1900-2100：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，支持选择时间：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              enableSelectTime: true,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置禁选日期：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              disabledDates: [
                new Date('2024-12-20'),
                new Date(),
                new Date('2024-12-26'),
                new Date('2025-10-20'),
                new Date('2025-11-10'),
              ],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置range范围：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              rangeLimit: [new Date()],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，有默认值：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              selected: new Date(2025, 11, 10),
              startYear: 2020,
              endYear: 2030,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，有默认值，支持选择时间：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              dialogType: DialogType.SHEET,
              selected: new Date('2025-11-10 14:20:20'),
              enableSelectTime: true,
              startYear: 2020,
              endYear: 2030,
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
    .title('选择单日期')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}