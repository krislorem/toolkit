# Changelog

## [v1.2.0] 2025-11-10

### 新增功能

- 新增智能配色功能：LayoutFull 组件根据背景颜色亮度自动调整状态栏和导航栏内容颜色
    - 浅色背景（如 #ff7cb3d7）自动配黑色文字，确保清晰可见
    - 深色背景（如 #ff558eb3）自动配白色文字，提升对比度
- 新增 UIBase.isLightColor() 方法，使用 YIQ 公式判断颜色是否为浅色
- 新增 UIBase.setSystemBarColor() 方法，根据背景色动态设置系统栏内容颜色

### 改进

- LayoutFull 组件在 aboutToAppear 时自动根据 customBgColor 设置状态栏内容颜色
- 优化用户体验，无需手动配置状态栏文字颜色

### 使用示例

```typescript
// 浅色背景 - 自动使用黑色文字
LayoutFull({
  customBgColor: '#ff7cb3d7',
  buildContent: this.buildPageContent
})

// 深色背景 - 自动使用白色文字
LayoutFull({
  customBgColor: '#ff558eb3',
  buildContent: this.buildPageContent
})
```

## [v1.1.0] 2025-11-10

### 新增功能

- UIBase.init() 方法支持沉浸式窗口配置，可通过 `{ immersive: true }` 一键启用
- 新增 WindowConfig 接口，支持自定义状态栏和导航栏颜色
- LayoutFull 组件优化，简化使用方式，自动适配沉浸式窗口

### 改进

- 使用 Promise 方式调用窗口 API，避免废弃 API 警告
- 优化 LayoutFull 组件文档，添加详细使用说明
- 简化沉浸式窗口的配置流程，无需在 EntryAbility 中手动设置

## [v1.0.0] 2025-11-10

- 提供窗口大小监听的方法
- 提供 UI 组件的基础能力