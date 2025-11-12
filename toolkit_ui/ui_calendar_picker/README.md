# 日历选择器 ui-calendar-picker

## 目录

- [简介](#简介)
- [约束与限制](#约束与限制)
- [使用](#使用)
- [API参考](#API参考)
- [支持情况说明](#支持情况说明)
- [异常情形说明](#异常情形说明)
- [示例代码](#示例代码)

## 简介

ui-calendar-picker 是一款日历选择器组件，包含单日期选择、多日期选择和时间段选择的功能，让用户快捷选择日期。

## 约束与限制

* DevEco Studio版本：DevEco Studio 5.0.0 Release及以上
* HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上
* 设备类型：华为手机（包括双折叠和阔折叠）、平板
* 系统版本：HarmonyOS 5.0.0(12)及以上

## 使用

1. 安装组件。

```bash
ohpm install @krislorem/ui-base
ohpm install @krislorem/ui-calendar-picker
```

2. 引入和调用组件，详细参数配置说明参见[API参考](#API参考)。

在应用的入口文件如 EntryAbility.ets 进行初始化

```
import { UIBase } from '@krislorem/ui-base';

onWindowStageCreate(windowStage:window.WindowStage):void {
  UIBase.init(windowStage);
}
```

在业务页面使用组件

```
import { CalendarPickerUtil } from '@krislorem/ui-calendar-picker';

@Entry
@Component
struct TestPage{
  build(){
    Column(){
      Button('日历').onClick(() => {
        CalendarPickerUtil.show()
      })
    }
    .width('100%')
    .height('100%')
  }
}
```

## API 参考

### 子组件

UICalendarPicker 可以包含单个子组件

### 接口

UICalendarPicker(option?: UICalendarPickerOptions)

| 参数名     | 类型                                                      | 是否必填 | 说明            |
|---------|---------------------------------------------------------|------|---------------|
| options | [UICalendarPickerOptions](#UICalendarPickerOptions对象说明) | 否    | 配置日历选择器组件的参数。 |

### CalendarPickerUtil方法说明

| 名称                                                                      | 描述           |
|:------------------------------------------------------------------------|:-------------|
| show(options?: [UICalendarPickerOptions](#UICalendarPickerOptions对象说明)) | 控制日历选择器打开的事件 |
| hide()                                                                  | 控制日历选择器关闭的事件 |

### UICalendarPickerOptions 对象说明

| 名称                | 类型                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | 是否必填 | 说明                                                          |
|:------------------|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:-----|:------------------------------------------------------------|
| type              | [TypePicker](#TypePicker枚举说明)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 否    | 日期选择器类型，默认值是SINGLE单日期                                       |
| dialogType        | [DialogType](#DialogType枚举说明)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | 否    | 弹窗类型，支持常规弹窗和半模态弹窗，默认值DialogType.SHEET                       |
| swiperDirection   | [SwiperDirection](#SwiperDirection枚举说明)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 否    | 滑动方向，支持左右滑动和上下滑动，仅半模态弹窗支持上下滑动，默认值SwiperDirection.HORIZONTAL |
| customColor       | [ResourceColor](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcecolor)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | 否    | 定制颜色，涉及所选日期背景色、当日字体、箭头、年月滚轮                                 |
| customFontColor   | [ResourceColor](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcecolor)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | 否    | 定制未选中文字颜色                                                   |
| startDayOfWeek    | number                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 一周起始天，默认值是0，星期天，取值范围0 - 6之间的整数                              |
| startYear         | number                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 切换年月的起始年份，默认是1900                                           |
| endYear           | number                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 切换年月的结束年份，默认是2100                                           |
| rangeLimit        | Date[]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 设置可选范围，取数组第一项作为可选范围的开始日期，第二项作为可选范围的结束日期                     |
| disabledDates     | Date[]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 设置禁选日期，仅针对单日期、多日期生效                                         |
| disableDayLabel   | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | 否    | 设置禁选日期下方的文字                                                 |
| maxGap            | number                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 设置起止日期之间的最大跨度，仅时间段类型生效                                      |
| enableSelectTime  | boolean                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 否    | 开启时间选择，默认值否，仅单日期类型以及横向滑动SwiperDirection.HORIZONTAL时生效       |
| isMilitaryTime    | boolean                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 否    | 时间选择是否24小时制，默认值否                                            |
| sheetTitle        | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | 否    | 设置半模态弹窗标题文字                                                 |
| sheetH            | [SheetSize](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-universal-attributes-sheet-transition#sheetsize%E6%9E%9A%E4%B8%BE%E8%AF%B4%E6%98%8E) \| [Length](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#length)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | 否    | 设置半模态弹窗高度，仅横向滑动SwiperDirection.HORIZONTAL生效                 |
| detents           | [ ([SheetSize](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-universal-attributes-sheet-transition#sheetsize%E6%9E%9A%E4%B8%BE%E8%AF%B4%E6%98%8E) \|[Length](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#length)), ([SheetSize](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-universal-attributes-sheet-transition#sheetsize%E6%9E%9A%E4%B8%BE%E8%AF%B4%E6%98%8E) \|[Length](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#length))?, ([SheetSize](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-universal-attributes-sheet-transition#sheetsize%E6%9E%9A%E4%B8%BE%E8%AF%B4%E6%98%8E) \|[Length](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#length))? ] |      | 设置半模态弹窗高度档位，仅纵向滑动SwiperDirection.VERTICAL生效                 |
| selected          | Date                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | 否    | 选中的单日期，无默认值                                                 |
| selectDates       | Date[]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 选中的多日期、时间段。时间段只取前两个日期作为开始和结束日期。无默认值                         |
| yOffset           | number                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 常规弹窗垂直方向偏移量，默认垂直居中对齐                                        |
| embedded （2.0.0+） | boolean                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | 否    | 是否直接嵌入页面，默认为否                                               |
| customBuildPanel  | () => void;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | 否    | 自定义触发弹窗的控件                                                  |
| onSelected        | (callback: (date: Date \|Date[]) => void)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | 否    | 确认选择的回调                                                     |
| cancel            | (callback: () => void)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | 否    | 取消选择的回调                                                     |
| onClickDate       | (callback: (date: Date) => void)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | 否    | 点击日期的回调                                                     |

### TypePicker 枚举说明

| 名称       | 描述  |
|:---------|:----|
| SINGLE   | 单日期 |
| MULTIPLE | 多日期 |
| RANGE    | 时间段 |

### DialogType 枚举说明

| 名称     | 描述    |
|:-------|:------|
| DIALOG | 常规弹窗  |
| SHEET  | 半模态弹窗 |

### SwiperDirection 枚举说明

| 名称         | 描述   |
|:-----------|:-----|
| HORIZONTAL | 水平方向 |
| VERTICAL   | 垂直方向 |

## 支持情况说明

1. 针对日历选择器在页面中不同的展示方式，参数支持情况说明如下：

| 类型                                                          | 通过控件触发 |                     | 嵌入页面 |
|-------------------------------------------------------------|--------|---------------------|------|
| 嵌入页面embedded                                                | √      | x（API携带，开发者手动更改不生效） | √    |
| 自定义构建函数customBuildPanel                                     | √      | x                   | x    |
| 确认选择的回调onSelected(callback: (date: Date \| Date[]) => void) | √      | √                   | x    |
| 取消选择的回调cancel(callback: () => void)                         | √      | √                   | x    |
| 点击日期的回调onClickDate(callback: (date: Date) => void)          | √      | √                   | √    |

2. 针对是否支持选择时间、设置禁选日期、设置可选范围、设置最大跨度，不同类型的日期选择器支持情况说明如下：

| 类型                   | 单日期 | 多日期 | 时间段 |
|----------------------|-----|-----|-----|
| 时间选择enableSelectTime | √   | x   | x   |
| 禁选disabledDates      | √   | √   | x   |
| 可选范围rangeLimit       | √   | √   | √   |
| 跨度maxGap             | x   | x   | √   |

## 异常情形说明

| 异常情形                         | 对应结果                          |
|:-----------------------------|:------------------------------|
| 一周起始天不合法                     | 取默认值0                         |
| 起始年份小于1900                   | 取默认值1900                      |
| 结束年份大于2100                   | 取默认值2100                      |
| 起始年份晚于结束年份                   | 起始年份、结束年份均为默认值                |
| 针对单日期选择，选中日期早于起始年份           | 选中日期非法，置空处理，当前视图为系统时间所在月      |
| 针对单日期选择，选中日期晚于结束年份           | 选中日期非法，置空处理，当前视图为系统时间所在月      |
| 针对单日期选择，起始年份晚于当前系统日期，选中日期未设置 | 当前视图为起始年份第一个月                 |
| 针对单日期选择，结束年份早于当前系统日期，选中日期未设置 | 当前视图为结束年份最后一个月                |
| 针对多日期选择，部分选中日期不在起止年份间        | 过滤掉不在起止年份间的日期，当前视图为第一个有效日期所在月 |
| 针对多日期选择，全部选中日期不在起止年份间        | 过滤所有非法日期，当前视图为系统时间所在月         |
| 针对时间段选择，开始日期不早于结束日期          | 默认值非法，置空处理，当前视图为系统时间所在月       |
| 针对时间段选择，开始日期或结束日期不在起止年份之间    | 默认值非法，置空处理，当前视图为系统时间所在月       |
| 针对可选范围rangeLimit，开始时间不早于结束时间 | 非法传参，参数不生效                    |

## 示例代码

> 代码过长时，请复制代码至代码编辑器查看

### 示例1

### 示例2

### 示例3

### 示例4

### 示例5

### 示例6