import { buildUICalendarDialog } from '../components/UICalendarDialog';
import { DialogType, SwiperDirection } from './Constant';
import { CalendarDialogModel, UICalendarPickerOptions } from './Model';
import { PopViewUtil } from './PopViewUtil';

export class CalendarPickerUtil {
  private static _dialogType?: DialogType
  private static _isShow: boolean = false

  public static show(options?: UICalendarPickerOptions) {
    if (CalendarPickerUtil._isShow) {
      return;
    }
    const model = new CalendarDialogModel(options)
    CalendarPickerUtil._dialogType = model.dialogType;
    CalendarPickerUtil._isShow = true
    if (model.dialogType === DialogType.DIALOG) {
      PopViewUtil.openDialog(
        wrapBuilder(buildUICalendarDialog),
        {
          onWillDismiss: () => {
            CalendarPickerUtil.hide()
          },
        },
        model,
      )
    } else {
      PopViewUtil.openSheet(
        wrapBuilder(buildUICalendarDialog),
        {
          showClose: false,
          onWillDismiss: () => {
            CalendarPickerUtil.hide()
          },
          preferType: SheetType.CENTER,
          scrollSizeMode: ScrollSizeMode.CONTINUOUS,
          detents: model.swiperDirection === SwiperDirection.VERTICAL
            ? model.detents
            : undefined,
          height: model.swiperDirection === SwiperDirection.VERTICAL
            ? undefined
            : model.sheetH,
          backgroundColor: model.swiperDirection === SwiperDirection.VERTICAL
            ? $r('sys.color.ohos_id_color_dialog_bg')
            : undefined,
        },
        model,
      )
    }
  }

  public static hide() {
    if (!CalendarPickerUtil._dialogType) {
      return
    }
    if (CalendarPickerUtil._dialogType === DialogType.DIALOG) {
      PopViewUtil.closeDialog()
    } else {
      PopViewUtil.closeSheet()
    }
    CalendarPickerUtil._dialogType = undefined
    CalendarPickerUtil._isShow = false;
  }
}