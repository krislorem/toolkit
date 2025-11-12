import {
  DialogType, SwiperDirection, TypePicker, UICalendarPicker
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
struct CalendarPickerSample2 {
  @Local selectedDate: Date = new Date(2025, 11, 10);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Row() {
            Text('常规弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.DIALOG,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
            })
          }.rowStyle()


          Row() {
            Text('半模态弹窗，设置禁选日期：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
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
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
              rangeLimit: [new Date()],
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，有默认值：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              dialogType: DialogType.SHEET,
              selectDates: [new Date(2024, 2, 15)],
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
    .title('选择多日期')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}