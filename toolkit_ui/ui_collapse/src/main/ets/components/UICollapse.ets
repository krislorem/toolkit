@ComponentV2
export struct UICollapse {
  @Builder
  collapseItemBuilder() {
  }

  scroller: Scroller = new Scroller()
  @BuilderParam collapseItemBuilderParam: () => void = this.collapseItemBuilder

  build() {
    Scroll(this.scroller) {
      Column() {
        this.collapseItemBuilderParam()
      }
    }
    .scrollable(ScrollDirection.Vertical)
    .scrollBar(BarState.Off)
  }
}