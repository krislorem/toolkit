import { TagSize, TagType } from '../common/TagConstant';

@ComponentV2
export struct UITag {
  @Local tagRadius: ResourceStr = $r('sys.float.ohos_id_corner_radius_mark');
  // 标签内容
  @Param customText: ResourceStr = '';
  // 标签尺寸
  @Param tagSize: TagSize = TagSize.DEFAULT;
  // 默认背景颜色
  @Local tagBackGroundColor: ResourceColor = $r('sys.color.ohos_id_color_button_normal');
  // 传入自定义背景色
  @Param customBackgroundColor: ResourceColor = $r('sys.color.ohos_id_color_emphasize');
  // 是否启用
  @Param enable: boolean = true;
  // 标签类型
  @Param type: TagType = TagType.NORMAL;
  // 是否为胶囊
  @Param isCapsule: boolean = false;
  // 字体颜色
  @Local fontColor: ResourceColor = $r('sys.color.ohos_id_color_text_primary');
  // 是否有边框
  @Local isBorder: boolean = false;
  // 传入自定义边框颜色
  @Param customBorderColor: ResourceColor = $r('sys.color.ohos_id_color_emphasize');
  // 默认margin
  @Local tagMargin: ResourceStr = $r('app.float.default_margin');
  // 传入自定义margin
  @Param customMargin: ResourceStr | number = '';
  // 传入自定义最大宽度
  @Param customMaxWidth: ResourceStr | number = 0;
  // 点击事件
  @Event onClickEvent: () => void = () => {
  };

  showBorder(type: TagType) {
    return type === TagType.BORDER;
  }

  getFontColor(type: TagType) {
    return type === TagType.NORMAL ? this.fontColor :
      (type === TagType.BORDER ?
        (this.customBorderColor) :
        $r('sys.color.ohos_id_color_text_primary_contrary'));
  }

  getBackgroundColor(type: TagType) {
    return type === TagType.NORMAL ? this.tagBackGroundColor :
      (type === TagType.COLOR ?
        (this.customBackgroundColor) : '');
  }

  getRadius(isCapsule: boolean, tagSize: TagSize) {
    return isCapsule ?
      ((tagSize === TagSize.SMALL ? $r('sys.float.ohos_id_corner_radius_default_s') :
        (tagSize === TagSize.LARGE ? $r('sys.float.ohos_id_corner_radius_default_m') :
          $r('sys.float.ohos_id_corner_radius_switch')))) : this.tagRadius;
  }

  // 纵向边距
  getPortraitPadding(size: TagSize) {
    return size === TagSize.LARGE ? $r('app.float.large_top_padding') :
      (size === TagSize.DEFAULT ? $r('app.float.default_top_padding') :
        $r('app.float.small_top_padding'))
  }

  // 横向边距
  getHorizontalPadding(size: TagSize) {
    return size === TagSize.LARGE ? $r('app.float.large_left_padding') :
      (size === TagSize.DEFAULT ? $r('app.float.default_left_padding') :
        $r('app.float.small_left_padding'))
  }

  build() {
    Column() {
      Text(this.customText)
        .width('auto')
        .height(this.tagSize === TagSize.LARGE ? $r('app.float.large_height') :
          (this.tagSize === TagSize.DEFAULT ? $r('app.float.default_height') :
            $r('app.float.small_height')))
        .padding({
          top: this.getPortraitPadding(this.tagSize),
          left: this.getHorizontalPadding(this.tagSize),
          bottom: this.getPortraitPadding(this.tagSize),
          right: this.getHorizontalPadding(this.tagSize)
        })
        .fontSize(this.tagSize === TagSize.LARGE ? $r('sys.float.ohos_id_text_size_body2') :
          (this.tagSize === TagSize.DEFAULT ? $r('sys.float.ohos_id_text_size_body3') :
            $r('sys.float.ohos_id_text_size_caption')))
        .fontFamily($r('sys.string.ohos_id_text_font_family_regular'))
        .textAlign(TextAlign.Center)
        .backgroundColor(this.getBackgroundColor(this.type))
        .fontColor(this.getFontColor(this.type))
        .textOverflow({ overflow: TextOverflow.Ellipsis })
        .maxLines(1)
        .constraintSize({ maxWidth: this.customMaxWidth ? this.customMaxWidth : $r('app.float.default_max_width') })
        .enabled(this.enable)
        .margin(this.customMargin ? this.customMargin : this.tagMargin)
        .border(this.showBorder(this.type) ? {
          width: $r('app.float.border_width'),
          color: this.customBorderColor,
          radius: this.getRadius(this.isCapsule, this.tagSize),
          style: BorderStyle.Solid
        } : null)
        .borderRadius(this.getRadius(this.isCapsule, this.tagSize))
        .opacity(this.enable ? $r('app.float.tag_opacity') : $r('sys.float.ohos_id_alpha_disabled'))
        .onClick(() => {
          this.onClickEvent()
        })
    }
  }
}