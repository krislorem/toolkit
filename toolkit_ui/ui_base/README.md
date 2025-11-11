REindowStage:window.WindowStage):void {
  // 基础初始化
  UIBase.init(windowStage);

  windowStage.loadContent('pages/Index',(err) => {
  // ...
 });
}
```

### 2.3. 沉浸式窗口（推荐）

通过配置参数可以一键启用沉浸式全屏模式：

```
import { window } from '@kit.ArkUI';
import { UIBase } from '@krislorem/ui-base';

onWindowStageCreate(windowStage:window.WindowStage):void {
  // 配置沉浸式窗口
  UIBase.init(windowStage, { immersive: true });

  windowStage.loadContent('pages/Index',(err) => {
  // ...
 });
}
```

### 2.4. 自定义系统栏颜色

可以通过配置参数设置状态栏，导航栏颜色，如下：

```typescript
UIBase.init(windowStage, {
  immersive: true,
  statusBarColor: '#00000000', // 状态栏背景色（透明）
  navigationBarColor: '#00000000', // 导航栏背景色（透明）
  statusBarContentColor: '#FFFFFF', // 状态栏内容颜色（白色）
  navigationBarContentColor: '#FFFFFF'   // 导航栏内容颜色（白色）
});
```

## 3. 组件

### 3.1. LayoutFull 全屏布局组件

用于处理沉浸式全屏布局的安全区避让。

#### 3.1.1. 参数说明

| 参数名                | 类型            | 必填 | 默认值   | 说明         |
|--------------------|---------------|----|-------|------------|
| isLayoutFullScreen | boolean       | 否  | true  | 当前窗口是否为沉浸式 |
| needCalcPadding    | boolean       | 否  | false | 是否需要计算避让区域 |
| customBgColor      | ResourceColor | 否  | 系统背景色 | 自定义窗口背景颜色  |
| buildContent       | () => void    | 是  | -     | 页面内容构建器    |

#### 3.1.2. 使用示例

```
import { LayoutFull } from '@krislorem/ui-base';

@Entry
@Component
struct Index
{
  @Builder
  buildPageContent() {
    Column() {
      Text('页面内容')
        .fontSize(20)
        .fontColor(Color.White)
    }
    .
    width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
  }

  build(){
    Column(){
      LayoutFull({
        customBgColor: '#ff558eb3',
        buildContent: this.buildPageContent
      })
    }
    . width('100%')
    .height('100%')
  }
}
```

## 4. API 说明

### 4.1. UIBase

| 方法名                      | 参数                                              | 返回值                           | 说明               |
|--------------------------|-------------------------------------------------|-------------------------------|------------------|
| init                     | windowStage: WindowStage, config?: WindowConfig | void                          | 初始化窗口管理器，支持沉浸式配置 |
| getWindow                | -                                               | Window \| undefined           | 获取主窗口实例          |
| onAvoidAreaChange        | callback: Callback                              | void                          | 监听系统避让区域变化       |
| offAvoidAreaChange       | callback: Callback                              | void                          | 取消监听系统避让区域变化     |
| onWindowSizeChange       | callback: Callback                              | void                          | 监听窗口大小变化         |
| offWindowSizeChange      | callback: Callback                              | void                          | 取消监听窗口大小变化       |
| getWindowProperties      | -                                               | WindowProperties \| undefined | 获取窗口属性           |
| getWindowRect            | -                                               | Rect \| undefined             | 获取窗口矩形区域         |
| isWindowLayoutFullScreen | -                                               | boolean \| undefined          | 判断窗口是否为沉浸式       |

### 4.2. WindowConfig 接口

```typescript
interface WindowConfig {
immersive?: boolean; // 是否启用沉浸式
statusBarColor?: string; // 状态栏背景色
navigationBarColor?: string; // 导航栏背景色
statusBarContentColor?: string; // 状态栏内容颜色
navigationBarContentColor?: string; // 导航栏内容颜色
}
```

## 5. 约束与限制

1. 本组件仅支持标准系统上运行，支持设备：华为手机
2. HarmonyOS 系统：HarmonyOS 5.0.0 Release 及以上
3. DevEco Studio 版本：DevEco Studio 5.0.0 Release 及以上
4. HarmonyOS SDK 版本：API 20 及以上