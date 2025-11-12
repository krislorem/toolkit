# 文件选择 UIFilePicker

## 简介

ui-file-picker 是一个文件选择上传组件，
包含图片、视频、音频、压缩包等所有文件类型的选取，以及支持启动自动上传到云存储。其中图片支持栅格模式选取展示、支持大图预览，其他文件类型仅支持列表模式展示。

## 快速开始

### 安装

```
ohpm install @krislorem/ui-file-picker
```

### 使用

在业务页面使用组件

```typescript
import { UIFilePicker } from '@krislorem/ui-file-picker';

UIFilePicker()

```

### 相关权限

1. 如果启动自动上传云存储的能力，涉及申请权限：ohos.permission.INTERNET 和ohos.permission.GET_NETWORK_INFO

2.使用上传到云存储，前提条件：开通云存储服务，参考[开通云存储服务](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides/cloudfoundation-enable-storage)。

3. 为了快速体验云存储的功能，可以配置云存储的安全策略为始终可读写（无需获取用户凭据），具体操作如下：

   a. 登录[AppGallery Connect](https://developer.huawei.com/consumer/cn/service/josp/agc/index.html)，点击“我的项目”。

   b. 在项目列表中点击你的项目。

   c. 在左侧导航栏选择“云开发（Serverless） > 云存储”，进入云存储页面。

   d. 选择“安全”页签，在“配置策略”页面修改默认安全策略为始终可读写后，点击“发布”。

   ```typescript
   agc.cloud.storage[
       match: /{bucket}/{path=**} {
           allow read, write: if true;
       }
   ]
   ```
   e. 组件使用可参考[示例5](#示例5开启自动上传-云存储安全策略为始终可读写)

   [说明]
   云存储的默认安全策略是允许经过身份验证的用户执行读写操作，需要对[cloudStorageOption](#ICloudStorageOption对象说明)
   中的 cloudOptions 参数进行配置，
   主要是需要配置[认证提供方](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/cloudfoundation-cloudcommon#section136610231214)，
   可参考[示例4](#示例4开启自动上云-云存储安全策略为需鉴权)。

### 约束与限制

1. 本示例仅支持标准系统上运行，支持设备：华为手机。

2. HarmonyOS系统：HarmonyOS 5.0.0 Release及以上。

3. DevEco Studio版本：DevEco Studio 5.0.0 Release及以上。

4. HarmonyOS SDK版本：HarmonyOS 5.0.0 Release SDK及以上。

## 子组件

无

## 接口

### UIFilePicker(option: UIFilePickerOptions)

#### UIFilePickerOptions对象说明

| 名称                 | 类型                                                                                                    | 必填 | 说明                                                               |
|:-------------------|:------------------------------------------------------------------------------------------------------|:---|:-----------------------------------------------------------------|
| initFiles          | [IFileModel](#IFileModel对象说明)[]                                                                       | 否  | 初始传入的数据                                                          |
| readonly           | boolean                                                                                               | 否  | 组件是否只读，默认值false。只读状态下不支持预览、不显示选择、进度、删除按钮、文件大小等                   |
| disablePreview     | boolean                                                                                               | 否  | 是否禁止大图预览，在栅格展示方式下生效。默认值false                                     |
| showDelIcon        | boolean                                                                                               | 否  | 是否展示删除按钮，默认值true                                                 |
| fileNumLimit       | number                                                                                                | 否  | 文件数量限制，默认值9                                                      |
| mode               | [FileLayoutMode](#FileLayoutMode枚举说明)                                                                 | 否  | 显示模式，支持列表和栅格，默认值是栅格，注：栅格模式仅在fileMediaType为FileMediaType.IMAGE时生效 |
| fileMediaType      | [FileMediaType](#FileMediaType枚举说明)                                                                   | 否  | 文件媒体类型，支持仅图片、仅视频、图片和视频、音频和其他文件类型。默认值为仅图片                         |
| showLimit          | boolean                                                                                               | 否  | 设置是否显示当前选择的数量和上限值，默认值：true                                       |
| customSelectTip    | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) | 否  | 设置引导选择文件的提示语                                                     |
| cloudStorageOption | [ICloudStorageOption](#ICloudStorageOption对象说明)                                                       | 否  | 设置云存储选项                                                          |
| btnOption          | [IBtnOption](#IBtnOption对象说明)                                                                         | 否  | 按钮选项                                                             |
| listOption         | [IListOption](#IListOption对象说明)                                                                       | 否  | 列表选项，仅在mode取值FileLayoutMode.LIST时生效                              |
| packingOption      | [IPackingOption](#IPackingOption对象说明)                                                                 | 否  | 打包选项                                                             |

#### IFileModel对象说明

| 名称           | 类型                                                                                                                | 必填 | 说明             |            
|:-------------|:------------------------------------------------------------------------------------------------------------------|----|----------------|
| id           | string                                                                                                            | 否  | 文件id，唯一索引，自动生成 |
| uri          | string                                                                                                            | 否  | 系统picker获取的uri |
| name         | string                                                                                                            | 是  | 文件名            |
| buffer       | ArrayBuffer\|undefined                                                                                            | 是  | 文件buffer       |
| pixelMap     | [PixelMap](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-image#pixelmap7)\| undefined | 否  | 图片的pixelMap    |
| type         | [FileMediaType](#FileMediaType枚举说明)                                                                               | 否  | 文件类型           |
| processed    | number                                                                                                            | 否  | 上传进度           |
| uploadStatus | [request.agent.State](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/js-apis-request#state10)  | 否  | 上传状态           |
| sizes        | number                                                                                                            | 否  | 上传文件总大小        |
| url          | string                                                                                                            | 否  | 云端的地址          |

#### ICloudStorageOption对象说明

| 名称           | 类型                                                                                                                                             | 必填 | 说明                                                                                                                                        |
|:-------------|:-----------------------------------------------------------------------------------------------------------------------------------------------|----|-------------------------------------------------------------------------------------------------------------------------------------------|
| autoUpload   | boolean                                                                                                                                        | 是  | 是否开启自动上传到云存储，默认值false                                                                                                                     |
| bucketName   | string                                                                                                                                         | 否  | 存储实例名称。格式受云侧约束，只允许输入小写字母、数字、'-'，以字母或数字开头和结尾，长度为9-63个字符，且不能连续输入两个及以上'-'。<br>缺省时，将启动异步任务查询云侧默认实例。<br>非缺省时，请确保当前云侧存在该存储实例，否则后续操作将出现查询存储实例错误。 |
| dirName      | string                                                                                                                                         | 否  | 存储目录名称，默认值为/                                                                                                                              |
| cloudOptions | [cloudCommon.CloudOptions](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/cloudfoundation-cloudcommon#section6286921112312) | 否  | 云开发初始化选项                                                                                                                                  |

#### IPackingOption对象说明

| 名称                                                                 | 类型                                | 必填 | 说明                                                                            |
|:-------------------------------------------------------------------|:----------------------------------|----|-------------------------------------------------------------------------------|
| type                                                               | [FileSizeType](#FileSizeType枚举说明) | 是  |
 文件质量，支持原图、重新打包，默认值为原图。注：重新打包仅在fileMediaType为FileMediaType.IMAGE时生效 |
| format                                                             | string                            | 否  | 图片打包的格式，默认值image/jpeg。当前只支持"image/jpeg"、"image/webp"、"image/png"和"image/heif" 
 。注：仅在sizeType设置FileSizeType.COMPRESSED生效                           |
| quality                                                            | number                            | 否  | 图片打包的质量，取值0-100，默认值50。注：仅在sizeType设置FileSizeType.COMPRESSED生效                 |

#### IBtnOption对象说明

| 名称       | 类型                                                                                                    | 必填 | 说明                                   |
|:---------|:------------------------------------------------------------------------------------------------------|----|--------------------------------------|
| type     | [SelectBtnType](#SelectBtnType枚举说明)                                                                   | 是  | 设置按钮类型，默认值：SelectBtnType.SIMPLE      |
| label    | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) | 否  | 按钮主文字                                |
| subLabel | [ResourceStr](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcestr) | 否  | 按钮辅助文字，仅在type取值SelectBtnType.RICH时生效 |

#### IListOption对象说明

| 名称              | 类型                                                                                                        | 必填 | 说明                                                |
|:----------------|:----------------------------------------------------------------------------------------------------------|----|---------------------------------------------------|
| processBarColor | [ResourceColor](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#resourcecolor) | 否  | 设置上传进度条颜色，仅在cloudStorageOption.autoUpload为true时生效 |
| showFileIcon    | boolean                                                                                                   | 否  | 设置是否展示文件类型图标                                      |
| listHeight      | [Length](https://developer.huawei.com/consumer/cn/doc/harmonyos-references/ts-types#length)               | 否  | 列表高度                                              |

#### FileLayoutMode枚举说明

| 名称   | 描述   |
|:-----|:-----|
| LIST | 列表模式 |
| GRID | 栅格模式 |

#### FileMediaType枚举说明

| 名称          | 描述     |
|:------------|:-------|
| IMAGE       | 仅图片    |
| VIDEO       | 仅视频    |
| IMAGE_VIDEO | 图片和视频  |
| AUDIO       | 仅音频    |
| ALL         | 所有文件类型 |

#### FileSizeType枚举说明

| 名称       | 描述   |
|:---------|:-----|
| ORIGINAL | 原图   |
| PACKING  | 重新打包 |

#### SelectBtnType枚举说明

| 名称     | 描述   |
|:-------|:-----|
| SIMPLE | 简单按钮 |
| RICH   | 复杂按钮 |

## 事件

| 名称                                                                                | 描述              |
|:----------------------------------------------------------------------------------|:----------------|
| onSelect: (files: IFileModel[]) => void                                           | 选择文件后的回调        |
| onDelete: (file: IFileModel) => void                                              | 删除文件后的回调        |
| onChange(callback: (files: IFileModel[]) => void)                                 | 文件列表数据发生变化的回调   |
| onProcess(callback: (file: IFileModel, progress: request.agent.Progress) => void) | 开启自动上传后，上传过程的回调 |
| onSuccess(callback: (file: IFileModel, progress: request.agent.Progress) => void) | 开启自动上传后，上传成功的回调 |
| onFail(callback: (file: IFileModel, progress: request.agent.Progress) => void)    | 开启自动上传后，上传失败的回调 |

## 示例

### 示例1（栅格模式）

### 示例2（列表模式）

### 示例3（复杂按钮）

### 示例4（开启自动上云-云存储安全策略为需鉴权）

### 示例5（开启自动上传-云存储安全策略为始终可读写）