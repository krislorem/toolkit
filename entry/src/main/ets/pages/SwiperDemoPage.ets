import { UISwiper } from '@krislorem/ui-swiper';

@Entry
@ComponentV2
export struct SwiperDemoPage {
  @Local imgList: Resource[] = new Array(4).fill('').map((item: string, index) => {
    return $r(`app.media.image${index + 1}`)
  })
  @Local imgHeight: number = 190
  @Local imgWidth: number = 264

  build() {
    Column() {
      Row() {
        Text('图片轮播')
          .fontSize(24)
      }
      .padding({ top: 50 }) // 因为页面沉浸了，没有状态栏的占位了，所以要让页面内容整体往下偏移
      .width('100%')
      .backgroundColor('#7EBFEA')
      .justifyContent(FlexAlign.Center)

      UISwiper({
        // 可以不设置宽高，有默认值
        // imgWidth: this.imgWidth,
        // imgHeight: this.imgHeight,
        imgList: this.imgList,
        // 默认开启循环
        // isLoop: true,
        // 中间图片覆盖两边
        isCovered: true,
        onImageClick: (index: number) => {
          console.log(`点击中间图片项索引为${index}`)
        }
      })
    }
  }
}