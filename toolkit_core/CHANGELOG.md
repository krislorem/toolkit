# 更新日志

本文档记录了 @krislorem/toolkit_core 的所有重要变更。格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.0.0/)
，项目遵循 [语义化版本](https://semver.org/lang/zh-CN/)。

## [未发布]

### 计划中

- 性能优化和内存使用改进
- 更多国际化支持
- 增强错误处理机制

---

## [1.0.0] - 2025-11-04

### 🎉 首次发布

#### 新增功能

- **StringUtils 字符串工具类**
    - `generateUUID()` - 生成标准 UUID v4
    - `isEmail()` - 邮箱格式校验，支持国际化域名
    - `isPhone()` - 中国大陆手机号格式校验
    - `maskPhone()` - 手机号脱敏处理，保护用户隐私
    - `maskEmail()` - 邮箱地址脱敏处理
    - `base64Encode()` / `base64Decode()` - Base64 编解码
    - `isEmpty()` / `isNotEmpty()` - 空值判断
    - `truncate()` - 字符串截取并添加省略号
    - `stripHtml()` - 移除 HTML 标签
    - `capitalize()` - 首字母大写

- **DateUtils 日期工具类**
    - `format()` - 灵活的日期格式化，支持多种格式模板
    - `parseTimestamp()` - 时间戳解析
    - `fromNow()` - 相对时间显示（如 "3小时前"）
    - `diffDays()` / `diffHours()` / `diffMinutes()` - 时间差计算
    - `formatDuration()` - 时长格式化（HH:mm:ss 格式）
    - `formatDurationReadable()` - 人类可读时长格式
    - `isToday()` / `isYesterday()` - 日期判断
    - `getStartOfWeek()` / `getStartOfMonth()` / `getStartOfYear()` - 周期开始时间

- **MathKit 数学工具类**
    - `formatNumber()` - 数字格式化，支持千分位分隔符
    - `percentage()` - 百分比计算
    - `randomInt()` / `randomFloat()` - 随机数生成
    - `clamp()` - 数值范围限制
    - `round()` / `ceil()` / `floor()` - 四舍五入相关
    - `average()` / `sum()` / `max()` / `min()` - 数组统计计算

- **DeviceInfo 设备信息工具类**
    - `getModel()` - 获取设备型号
    - `getOSVersion()` - 获取操作系统版本
    - `getBrand()` - 获取设备品牌
    - `getDeviceType()` - 获取设备类型
    - `getSDKVersion()` - 获取 HarmonyOS SDK 版本
    - `getDeviceId()` - 获取设备唯一标识
    - `getFullInfo()` - 获取完整设备信息对象


- **JsonConverter JSON 转换工具类**
    - `toJson()` / `fromJson()` - JSON 序列化/反序列化
    - `safeJsonParse()` - 安全解析，支持默认值
    - `deepClone()` - 深拷贝对象
    - `isValidJson()` - JSON 格式校验

- **CommonConstants 公共常量**
    - 正则表达式常量（邮箱、手机号、URL 等）
    - 时间单位常量（秒、分钟、小时、天）
    - HTTP 状态码常量
    - 文件大小单位常量
    - 默认配置常量

#### 技术特性

- ✅ **零依赖设计** - 无外部依赖，纯 ArkTS 实现
- ✅ **类型安全** - 完整的 TypeScript/ArkTS 类型定义
- ✅ **文档完善** - 详细的 JSDoc 注释和使用示例
- ✅ **测试覆盖** - 核心功能单元测试覆盖
- ✅ **性能优化** - 针对 HarmonyOS 平台优化
- ✅ **标准规范** - 符合 HarmonyOS HAR 包规范

#### 开发工具

- 完整的单元测试套件
- API 使用示例和文档
- 标准化的项目结构
- 符合 HarmonyOS 开发规范

---

## 版本说明

### 版本号格式

本项目遵循语义化版本（Semantic Versioning）：

- **主版本号**：不兼容的 API 修改
- **次版本号**：向下兼容的功能性新增
- **修订号**：向下兼容的问题修正

### 更新类型说明

- `新增` - 新功能
- `变更` - 对现有功能的变更
- `弃用` - 即将移除的功能
- `移除` - 已移除的功能
- `修复` - 问题修复
- `安全` - 安全相关的修复

### 发布周期

- **主版本**：根据重大功能更新发布
- **次版本**：每月定期发布
- **修订版本**：根据 bug 修复情况随时发布

---

## 贡献指南

### 如何参与

1. Fork 本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交变更 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 提交 Pull Request

### 提交规范

- `[新增]` 新功能
- `[修复]` Bug 修复
- `[变更]` 功能变更
- `[文档]` 文档更新
- `[测试]` 测试相关
- `[优化]` 性能优化

### 问题反馈

- 请使用 [GitHub Issues](https://github.com/krislorem/toolkit/issues) 反馈问题
- 提供详细的复现步骤和环境信息
- 标明问题的严重程度和影响范围

---

## 许可证

本项目采用 [Apache-2.0 许可证](LICENSE)。