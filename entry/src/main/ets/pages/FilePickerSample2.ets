import { FileLayoutMode, UIFilePicker } from '@krislorem/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample2 {
  build() {
    Column() {
      NavDestination() {
        Column() {
          UIFilePicker({ mode: FileLayoutMode.LIST })
        }
        .width('100%')
        .padding(16)
      }
      .title('列表模式')
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    }
  }
}