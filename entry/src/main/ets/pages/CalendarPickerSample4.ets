import { DialogType, TypePicker, UICalendarPicker } from '@krislorem/ui-calendar-picker';

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
struct CalendarPickerSample4 {
  @Local selectedDate: Date = new Date(2025, 11, 10);
  @Local selectedDates: Date[] = [];

  build() {
    NavDestination() {
      Scroll() {
        Column({ space: 20 }) {
          Row() {
            Text('单日期-自定义主题色：').textStyle()
            UICalendarPicker({
              type: TypePicker.SINGLE,
              customColor: Color.Orange,
              selected: this.selectedDate,
              onSelected: (date) => {
                this.selectedDate = date as Date;
              },
            }) {
              Text(this.selectedDate.toLocaleDateString())
            }
          }.rowStyle()

          Row() {
            Text('多日期-自定义控件：').textStyle()
            UICalendarPicker({
              type: TypePicker.MULTIPLE,
              customColor: Color.Pink,
              selectDates: this.selectedDates,
              onSelected: (date) => {
                this.selectedDates = date as Date[];
              },
            }) {
              Scroll() {
                Column({ space: 4 }) {
                  if (this.selectedDates.length) {
                    ForEach(this.selectedDates, (item: Date) => {
                      Text(item.toLocaleDateString())
                    })
                  } else {
                    Text('请选择您的日期')
                  }
                }
              }.constraintSize({ maxHeight: 200, minHeight: 40 })
            }
          }.rowStyle()

          Row() {
            Text('半模态弹窗，点击日期有事件：').textStyle()
            UICalendarPicker({
              type: TypePicker.RANGE,
              dialogType: DialogType.SHEET,
              onClickDate: (date) => {
                this.getUIContext().getPromptAction().showToast({ message: '点击了日期:' + date });
              },
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
    .title('定制参数')
    .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
  }
}