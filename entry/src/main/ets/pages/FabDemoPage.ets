import { PopMenuContent, TypeFab, UIFab } from '@krislorem/ui-fab';

@Entry
@ComponentV2
struct FabChangePosition {
  @Local fabColor: ResourceColor = Color.Blue;
  @Local isVertical: boolean = false;
  @Local enableDrag: boolean = false;
  @Local popMenuStyle: TypeFab = TypeFab.RIGHT_UNDER;
  @Local iconColor: boolean = false;
  @Local positionFab: Position | Edges | LocalizedEdges = { left: 16, top: 16 };
  @Local center: Edges = { left: 0, top: 0 };

  build() {
    Column() {
      Column({ space: 4 }) {
        Button(this.isVertical ? '纵向菜单' : '横向菜单')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.isVertical = !this.isVertical;
          })

        Button(this.enableDrag ? '支持拖动' : '不支持拖动')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.enableDrag = !this.enableDrag;
          })

        Button('fab放在左上角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { left: 16, top: 16 };
            this.popMenuStyle = TypeFab.RIGHT_UNDER;
          })
        Button('fab放在右上角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { right: 16, top: 16 };
            this.popMenuStyle = TypeFab.LEFT_UNDER;
          })
        Button('fab放在左下角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { left: 16, bottom: 16 };
            this.popMenuStyle = TypeFab.RIGHT_UP;
          })
        Button('fab放在右下角')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { right: 16, bottom: 16 };
            this.popMenuStyle = TypeFab.LEFT_UP;
          })
        Button('fab放在中间')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.positionFab = { top: this.center.top, left: this.center.left };
          })
        Button('菜单展开方向为右和下')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.RIGHT_UNDER;
          })
        Button('菜单展开方向为左和下')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.LEFT_UNDER;
          })
        Button('菜单展开方向为右和上')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.RIGHT_UP;
          })
        Button('菜单展开方向为左和上')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.popMenuStyle = TypeFab.LEFT_UP;
          })
        Button('更改图标颜色')
          .type(ButtonType.Capsule)
          .onClick(() => {
            if (this.fabColor == Color.Red) {
              this.fabColor = Color.Blue;
            } else if (this.fabColor == Color.Blue) {
              this.fabColor = Color.Red;
            }
          })
        Button('更改icon深浅色')
          .type(ButtonType.Capsule)
          .onClick(() => {
            this.iconColor = !this.iconColor;
          })
      }
      .backgroundColor(Color.Gray)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')

      UIFab({
        fabColor: this.fabColor,
        popMenuStyle: this.popMenuStyle,
        fabPosition: this.positionFab,
        enableDrag: this.enableDrag,
        darkIcon: this.iconColor,
        isVertical: this.isVertical,
        content: [
          new PopMenuContent(
            '1',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            '文字文字文字文字文字文字',
            () => {
              console.info('text1: success');
            }),
          new PopMenuContent(
            '2',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text12345',
            () => {
              console.info('text2: success');
            }),
          new PopMenuContent(
            '3',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text3',
            () => {
              console.info('text3: success');
            }),
          new PopMenuContent(
            '4',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text4',
            () => {
              console.info('text4: success');
            }),
          new PopMenuContent(
            '5',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text5',
            () => {
              console.info('text5: success');
            }),
          new PopMenuContent(
            '6',
            $r('app.media.icon_image'),
            $r('app.media.icon_image'),
            'text6',
            () => {
              console.info('text6: success');
            }),
        ],
      })
    }
    .height('100%')
    .width('100%')
    .onSizeChange((_, n) => {
      this.center.left = (n.width as number) / 2 - 20;
      this.center.top = (n.height as number) / 2;
    })
  }
}