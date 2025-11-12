import { FileLayoutMode, FileMediaType, SelectBtnType, UIFilePicker } from '@krislorem/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample3 {
  build() {
    Column() {
      NavDestination() {
        Column() {
          UIFilePicker({
            mode: FileLayoutMode.LIST,
            btnOption: {
              type: SelectBtnType.RICH,
            },
            fileMediaType: FileMediaType.ALL,
          })
        }
        .width('100%')
        .padding(16)
      }
      .title('复杂按钮')
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    }
  }
}