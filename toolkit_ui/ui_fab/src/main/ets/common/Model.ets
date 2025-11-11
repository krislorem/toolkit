@ObservedV2
export class PopMenuContent {
  // 分类id，唯一索引
  id: string;
  // 菜单图标点击前的路径
  iconPath: ResourceStr;
  // 菜单图标点击后的路径
  iconSelectedPath: ResourceStr;
  // 菜单文本内容
  text: string;
  // 菜单图标点击事件
  popClick: () => void = () => {
  };

  constructor(id: string, iconPath: ResourceStr, iconSelectedPath: ResourceStr, text: string, popClick: () => void) {
    this.id = id;
    this.iconPath = iconPath;
    this.iconSelectedPath = iconSelectedPath;
    this.text = text;
    this.popClick = popClick;
  }
}