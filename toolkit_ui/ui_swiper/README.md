# 轮播图组件 ui-swiper

## 简介

ui-swiper 是一款可以缩放的轮播图组件，支持滑动过程中缩放图片、自动轮播等功能。

## 快速开始

### 安装

```
ohpm install @krislorem/ui-swiper
```

### 使用

/引入组件

```
import {ui-swiper} from '@krislorem/ui-swiper';
```

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。
2. HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上。
3. DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上。
4. HarmonyOS SDK 版本：HarmonyOS 5.0.0 Release SDK 及以上。

## 子组件

无

## 接口

### ui-swiper (options: ui-swiperOptions)

**ui-swiper 对象说明**

| 参数        | 类型      | 必填 | 说明                                                                                                                                                                                                                                                                                                          |
|:----------|:--------|:---|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| imgList   | Src[]   | 是  | 传入图片资源数组，Src类型参照<a href="https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/ts-basic-components-image-V5#image-1" title="Image组件">Image组件</a>，至少传入3张图片。                                                                                                                                   |
| imgWidth  | number  | 否  | 单位为vp,在360vp容器宽度下，默认值为264。<br />覆盖模式下，建议最大宽度:296vp(上传图片超过最大宽度时,保持原宽高比缩放至296vp宽,以适应容器边界)；建议最小宽度:164vp(上传图片低于最小宽度时,保持原宽高比放大至164vp宽,以适应容器边界)。<br />平铺模式下，建议最大宽度:264vp(上传图片超过最大窝度时,保持原宽高比缩放至264vp宽,以适应容器边界)；建议最小宽度:136vp(上传圈片低于最小宽度时,保持原宽高比放大至136vp宽,以适应容器边界)。当容器宽度不为360vp,默认值，最小宽度，最大宽度参照当前容器宽度与360vp的比值等比例变化。 |
| imgHeight | number  | 否  | 单位为vp,默认值为190。若宽度不在推荐范围内，保持宽高比跟随宽度缩放。                                                                                                                                                                                                                                                                       |
| interval  | number  | 否  | 单位为ms,默认值为5000，轮播间隔。                                                                                                                                                                                                                                                                                        |
| isLoop    | boolean | 否  | 默认值true,是否循环轮播                                                                                                                                                                                                                                                                                              |
| isCovered | boolean | 否  | 默认值false,是否为覆盖模式，false为平铺模式。建议覆盖模式下，传入4张及以上图片。                                                                                                                                                                                                                                                              |

**Src 参数说明**

| 参数  | 类型                                           | 必填 | 说明                                                                                                                                                                                                                                                                                                                         |
|:----|:---------------------------------------------|:---|:---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Src | PixelMap \| ResourceStr\| DrawableDescriptor | 是  | 图片的数据源，支持本地图片和网络图片，引用方式请参考加载<a href="https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/arkts-graphics-display-V5#%E5%8A%A0%E8%BD%BD%E5%9B%BE%E7%89%87%E8%B5%84%E6%BA%90" title="图片资源">图片资源</a>。1. PixelMap格式为像素图，常用于图片编辑的场景。2. ResourceStr包含Resource和string格式。3. 当传入资源id或name为普通图片时，生成DrawableDescriptor对象。 |

## 使用限制

无

## 事件

| 名称                                  | 功能描述                 |
|:------------------------------------|:---------------------|
| onImageClick(index:number) => void） | 点击中间图片时触发，回调值为图片对应索引 |

## 示例

### 示例1

```typescript
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
      UISwiper({
        imgWidth: this.imgWidth,
        imgHeight: this.imgHeight,
        imgList: this.imgList,
        isLoop: true,
        isCovered: true,
        onImageClick: (index: number) => {
          console.log(`点击中间图片项索引为${index}`)
        }
      })
    }
  }
}
```