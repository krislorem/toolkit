# @krislorem/toolkit_core

krislorem 鸿蒙工具集 - 核心基础工具包

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Version](https://img.shields.io/badge/Version-0.1.0-green.svg)](https://github.com/mqxu/toolkit)
[![HarmonyOS](https://img.shields.io/badge/Platform-HarmonyOS%20Next-blue.svg)](https://developer.harmonyos.com/)

## 简介

`@krislorem/toolkit_core` 是 krislorem 鸿蒙工具集的核心模块，为 HarmonyOS Next 应用开发提供丰富的基础工具类。该模块完全使用 ArkTS 开发，遵循 HarmonyOS HAR 规范，可无缝集成到任何 HarmonyOS 项目中。

**特性**:

- ✅ **零外部依赖**：可独立使用，无第三方库依赖
- ✅ **类型安全**：完整的 TypeScript/ArkTS 类型定义
- ✅ **文档完善**：详细的 JSDoc 注释和使用示例
- ✅ **标准规范**：符合 HarmonyOS HAR 包规范
- ✅ **测试覆盖**：完整的单元测试覆盖核心功能
- ✅ **性能优化**：针对 HarmonyOS 平台优化实现

## 安装

### 通过 OHPM 安装

```bash
ohpm install @krislorem/toolkit_core
```

### 在 DevEco Studio 中添加

1. 打开 `oh-package.json5`
2. 添加依赖：
```json5
{
  "dependencies": {
    "@krislorem/toolkit_core": "^0.1.0"
  }
}
```
3. 同步依赖

## 快速开始

```typescript
import { StringUtils, DateUtils, MathKit, DeviceInfo } from '@krislorem/toolkit_core';

// 1. 字符串工具
const uuid = StringUtils.generateUUID();
console.log(uuid); // "550e8400-e29b-41d4-a716-446655440000"

const isValid = StringUtils.isEmail('test@example.com'); // true
const masked = StringUtils.maskPhone('13812345678'); // "138****5678"

// 2. 日期工具
const now = new Date();
const formatted = DateUtils.format(now, 'yyyy-MM-dd HH:mm:ss');
const relative = DateUtils.fromNow(new Date(Date.now() - 3600000)); // "1小时前"

// 3. 数学工具
const percent = MathKit.percentage(45, 100); // 45
const formatted = MathKit.formatNumber(1234567); // "1,234,567"

// 4. 设备信息
const model = DeviceInfo.getModel(); // "HUAWEI Mate 60"
const osVersion = DeviceInfo.getOSVersion(); // "HarmonyOS 4.0.0"
```

## API 文档

### StringUtils - 字符串工具类

| 方法                         | 说明         | 示例                                                                 |
|----------------------------|------------|--------------------------------------------------------------------|
| `generateUUID()`           | 生成 UUID    | `StringUtils.generateUUID()`                                       |
| `isEmail(email)`           | 校验邮箱格式     | `StringUtils.isEmail('test@example.com')`                          |
| `isPhone(phone)`           | 校验手机号      | `StringUtils.isPhone('13812345678')`                               |
| `maskPhone(phone)`         | 手机号脱敏      | `StringUtils.maskPhone('13812345678')` → `"138****5678"`           |
| `maskEmail(email)`         | 邮箱脱敏       | `StringUtils.maskEmail('test@example.com')` → `"t***@example.com"` |
| `base64Encode(str)`        | Base64 编码  | `StringUtils.base64Encode('Hello')`                                |
| `base64Decode(str)`        | Base64 解码  | `StringUtils.base64Decode('SGVsbG8=')`                             |
| `isEmpty(str)`             | 判断字符串是否为空  | `StringUtils.isEmpty('')` → `true`                                 |
| `truncate(str, maxLength)` | 字符串截取      | `StringUtils.truncate('很长的文字', 5)`                                 |
| `stripHtml(html)`          | 移除 HTML 标签 | `StringUtils.stripHtml('<p>Hello</p>')`                            |
| `capitalize(str)`          | 首字母大写      | `StringUtils.capitalize('hello')` → `"Hello"`                      |

### DateUtils - 日期工具类

| 方法                                | 说明     | 示例                                                    |
|-----------------------------------|--------|-------------------------------------------------------|
| `format(date, pattern)`           | 日期格式化  | `DateUtils.format(new Date(), 'yyyy-MM-dd')`          |
| `fromNow(date)`                   | 相对时间   | `DateUtils.fromNow(date)` → `"3小时前"`                  |
| `diffDays(start, end)`            | 计算天数差  | `DateUtils.diffDays(start, end)`                      |
| `diffHours(start, end)`           | 计算小时差  | `DateUtils.diffHours(start, end)`                     |
| `diffMinutes(start, end)`         | 计算分钟差  | `DateUtils.diffMinutes(start, end)`                   |
| `formatDuration(seconds)`         | 格式化时长  | `DateUtils.formatDuration(3661)` → `"01:01:01"`       |
| `formatDurationReadable(seconds)` | 人类可读时长 | `DateUtils.formatDurationReadable(3661)` → `"1小时1分钟"` |
| `isToday(date)`                   | 是否为今天  | `DateUtils.isToday(new Date())`                       |
| `isYesterday(date)`               | 是否为昨天  | `DateUtils.isYesterday(date)`                         |
| `getStartOfWeek()`                | 本周第一天  | `DateUtils.getStartOfWeek()`                          |

### MathKit - 数学工具类

| 方法                                  | 说明     | 示例                                              |
|-------------------------------------|--------|-------------------------------------------------|
| `formatNumber(num, decimals)`       | 数字格式化  | `MathKit.formatNumber(1234567)` → `"1,234,567"` |
| `percentage(part, total, decimals)` | 计算百分比  | `MathKit.percentage(45, 100)` → `45`            |
| `randomInt(min, max)`               | 随机整数   | `MathKit.randomInt(1, 10)`                      |
| `randomFloat(min, max, decimals)`   | 随机小数   | `MathKit.randomFloat(1, 10, 2)`                 |
| `clamp(value, min, max)`            | 数值范围限制 | `MathKit.clamp(150, 0, 100)` → `100`            |
| `round(value, decimals)`            | 四舍五入   | `MathKit.round(3.14159, 2)` → `3.14`            |
| `average(numbers)`                  | 计算平均值  | `MathKit.average([1, 2, 3])` → `2`              |
| `sum(numbers)`                      | 计算总和   | `MathKit.sum([1, 2, 3])` → `6`                  |
| `max(numbers)`                      | 获取最大值  | `MathKit.max([1, 5, 3])` → `5`                  |
| `min(numbers)`                      | 获取最小值  | `MathKit.min([1, 5, 3])` → `1`                  |

### DeviceInfo - 设备信息工具类

| 方法                | 说明        | 示例                                                |
|-------------------|-----------|---------------------------------------------------|
| `getModel()`      | 获取设备型号    | `DeviceInfo.getModel()` → `"HUAWEI Mate 60"`      |
| `getOSVersion()`  | 获取系统版本    | `DeviceInfo.getOSVersion()` → `"HarmonyOS 4.0.0"` |
| `getBrand()`      | 获取设备品牌    | `DeviceInfo.getBrand()` → `"HUAWEI"`              |
| `getDeviceType()` | 获取设备类型    | `DeviceInfo.getDeviceType()` → `"phone"`          |
| `getSDKVersion()` | 获取 SDK 版本 | `DeviceInfo.getSDKVersion()` → `12`               |
| `getDeviceId()`   | 获取设备唯一标识  | `DeviceInfo.getDeviceId()`                        |
| `getFullInfo()`   | 获取完整设备信息  | `DeviceInfo.getFullInfo()`                        |

### UrlUtils - URL 工具类

| 方法                          | 说明          | 示例                                                  |
|-----------------------------|-------------|-----------------------------------------------------|
| `parseQuery(url)`           | 解析 URL 参数   | `UrlUtils.parseQuery('?id=123&name=test')`          |
| `buildUrl(baseUrl, params)` | 构建 URL      | `UrlUtils.buildUrl('https://api.com', { id: 123 })` |
| `encode(str)`               | URL 编码      | `UrlUtils.encode('张三')`                             |
| `decode(str)`               | URL 解码      | `UrlUtils.decode('%E5%BC%A0%E4%B8%89')`             |
| `getDomain(url)`            | 提取域名        | `UrlUtils.getDomain('https://api.example.com')`     |
| `isValidUrl(url)`           | 判断是否为合法 URL | `UrlUtils.isValidUrl('https://example.com')`        |

### JsonConverter - JSON 转换工具类

| 方法                                        | 说明           | 示例                                      |
|-------------------------------------------|--------------|-----------------------------------------|
| `toJson(obj, pretty)`                     | 对象转 JSON     | `JsonConverter.toJson({ name: '张三' })`  |
| `fromJson<T>(jsonStr)`                    | JSON 转对象     | `JsonConverter.fromJson<User>(jsonStr)` |
| `safeJsonParse<T>(jsonStr, defaultValue)` | 安全解析         | `JsonConverter.safeJsonParse(str, {})`  |
| `deepClone<T>(obj)`                       | 深拷贝          | `JsonConverter.deepClone(original)`     |
| `isValidJson(str)`                        | 判断是否为合法 JSON | `JsonConverter.isValidJson('{"a":1}')`  |

### CommonConstants - 公共常量

```typescript
import { CommonConstants } from '@krislorem/toolkit_core';

// 正则表达式
CommonConstants.REGEX.EMAIL // 邮箱正则
CommonConstants.REGEX.PHONE // 手机号正则
CommonConstants.REGEX.URL // URL 正则

// 时间常量 (毫秒)
CommonConstants.TIME.SECOND // 1000
CommonConstants.TIME.MINUTE // 60000
CommonConstants.TIME.HOUR // 3600000
CommonConstants.TIME.DAY // 86400000

// HTTP 状态码
CommonConstants.HTTP_STATUS.OK // 200
CommonConstants.HTTP_STATUS.UNAUTHORIZED // 401

// 文件大小单位
CommonConstants.FILE_SIZE.KB // 1024
CommonConstants.FILE_SIZE.MB // 1048576

// 默认配置
CommonConstants.DEFAULT.TIMEOUT // 15000
CommonConstants.DEFAULT.PAGE_SIZE // 20
```

## 应用场景

### 项目实际应用

```typescript
// 1. 用户手机号脱敏显示 (隐私保护)
const phone = user.phone;
const maskedPhone = StringUtils.maskPhone(phone); // "138****5678"

// 2. 学习时长格式化 (教育类应用)
const seconds = 3661;
const duration = DateUtils.formatDurationReadable(seconds); // "1小时1分钟"

// 3. 课程进度计算
const progress = MathKit.percentage(45, 100); // 45%

// 4. 设备信息采集 (用户画像分析)
const deviceInfo = DeviceInfo.getFullInfo();
// 上报用于数据分析

// 5. 深度链接解析
const params = UrlUtils.parseQuery('ohos-app://course?id=123');
// { id: "123" }
```

### 典型使用场景

- **移动应用开发**：用户信息处理、时间格式化、设备适配
- **教育类应用**：学习时长统计、进度计算、数据展示
- **电商应用**：价格格式化、订单时间、用户数据分析
- **工具类应用**：数据转换、格式化、验证等基础功能

## 兼容性

- **最低系统版本**：HarmonyOS API 12+
- **开发工具**：DevEco Studio 5.0+
- **ArkTS 版本**：TypeScript 5.0+

## 开发指南

### 本地开发

```bash
# 克隆项目
git clone https://github.com/krislorem/toolkit.git
cd toolkit/toolkit_core

# 安装依赖
ohpm install

# 运行测试
hvigor test

# 构建 HAR 包
hvigor buildHar
```

### 测试

```bash
# 运行所有测试
hvigor test

# 运行特定测试类
hvigor test --tests DateUtilsTest

# 生成测试覆盖率报告
hvigor collectCoverage
```

## 贡献指南

欢迎提交 Issue 和 Pull Request！

### 提交规范

- **Bug 修复**：`[fix] 修复 StringUtils 空值校验问题`
- **新功能**：`[feat] 添加 URL 编码解码功能`
- **文档更新**：`[docs] 更新 API 使用示例`
- **测试相关**：`[test] 增加 DateUtils 边界测试`

### 代码规范

- 使用 ArkTS 严格模式
- 完整的 JSDoc 注释
- 单元测试覆盖率 > 80%
- 遵循 HarmonyOS 开发规范

## 许可证

本项目采用 [Apache-2.0 许可证](LICENSE)。

## 相关链接

- [GitHub 仓库](https://github.com/mqxu/toolkit)
- [Issue 反馈](https://github.com/mqxu/toolkit/issues)
- [更新日志](CHANGELOG.md)
- [API 文档](https://github.com/mqxu/toolkit/wiki)