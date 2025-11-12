import { IFileModel, UIFilePicker } from '@krislorem/ui-file-picker';

@Entry
@ComponentV2
struct FilePickerSample1 {
  build() {
    Column() {
      NavDestination() {
        Column() {
          UIFilePicker({
            onSelect: (files: IFileModel[]) => {
              console.log('onSelect, count of files: ' + files.length);
            }
          })
        }
        .width('100%')
        .padding(16)
      }
      .title('栅格模式')
      .backgroundColor($r('sys.color.ohos_id_color_sub_background'))
    }
  }
}