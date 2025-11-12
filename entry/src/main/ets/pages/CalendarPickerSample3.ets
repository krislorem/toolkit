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
struct CalendarPickerSample3 {
  @Local selectedDate: Date = new Date(2025, 11, 10);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {

          Row() {
            Text('常规弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.DIALOG,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，纵向滑动：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
            })
          }.rowStyle()


          Row() {
            Text('半模态弹窗，设置最大跨度：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              maxGap: 3,
            })
          }.rowStyle()

          Row() {
            Text('半模态弹窗，设置range范围：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              rangeLimit: [new Date()],
            })
          }.rowStyle()


          Row() {
            Text('半模态弹窗，有默认值：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              swiperDirection: SwiperDirection.VERTICAL,
              selectDates: [new Date(2025, 10, 15), new Date(2025, 11, 15)],
              startYear: 1940,
              endYear: 2050,
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
    .title('选择时间段')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}