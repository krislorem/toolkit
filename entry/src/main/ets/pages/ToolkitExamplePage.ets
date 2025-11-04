import { DateUtils, DeviceInfo, JsonConverter, MathKit, StringUtils } from '@krislorem/toolkit_core';

/**
 * 用户示例对象接口
 */
interface UserExample {
  name: string;
  age: number;
  courses: string[];
}

@Entry
@Component
struct ToolkitExamplePage {
  @State userPhone: string = '13812345678';
  @State maskedPhone: string = '';
  @State userEmail: string = 'test@example.com';
  @State maskedEmail: string = '';
  @State learningDuration: string = '';
  @State courseProgress: number = 0;
  @State deviceInfo: string = '';
  @State urlExample: string = '';
  @State jsonExample: string = '';

  aboutToAppear() {
    this.loadExamples();
  }

  loadExamples() {
    // 示例 1: 手机号和邮箱脱敏 (StringUtils)
    this.maskedPhone = StringUtils.maskPhone(this.userPhone);
    this.maskedEmail = StringUtils.maskEmail(this.userEmail);

    // 示例 2: 学习时长格式化 (DateUtils)
    const seconds = 3661; // 1小时1分钟1秒
    this.learningDuration = DateUtils.formatDurationReadable(seconds);

    // 示例 3: 课程进度计算 (MathKit)
    const completedLessons = 15;
    const totalLessons = 20;
    this.courseProgress = MathKit.percentage(completedLessons, totalLessons, 1);

    // 示例 4: 获取设备信息 (DeviceInfo)
    const info = DeviceInfo.getFullInfo();
    this.deviceInfo = `${info.brand} ${info.model}\n${info.osVersion}\nSDK: ${info.sdkVersion}`;


    // 示例 6: JSON 转换 (JsonConverter)
    const userObj: UserExample = {
      name: '张三',
      age: 25,
      courses: ['HarmonyOS', 'TypeScript']
    };
    this.jsonExample = JsonConverter.toJson(userObj, true);
  }

  build() {
    Scroll() {
      Column({ space: 16 }) {
        Text('@krislorem/toolkit_core 使用示例')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 20, bottom: 10 })

        // StringUtils 示例
        this.buildExampleCard(
          'StringUtils - 隐私数据脱敏',
          `原始手机号: ${this.userPhone}\n脱敏后: ${this.maskedPhone}\n\n原始邮箱: ${this.userEmail}\n脱敏后: ${this.maskedEmail}`
        )

        // DateUtils 示例
        this.buildExampleCard(
          'DateUtils - 学习时长格式化',
          `学习时长: ${this.learningDuration}\n(原始秒数: 3661)`
        )

        // MathKit 示例
        this.buildExampleCard(
          'MathKit - 课程进度计算',
          `课程进度: ${this.courseProgress}%\n(已完成 15/20 节)`
        )

        // DeviceInfo 示例
        this.buildExampleCard(
          'DeviceInfo - 设备信息采集',
          this.deviceInfo
        )

        // UrlUtils 示例
        this.buildExampleCard(
          'UrlUtils - URL 参数解析',
          this.urlExample
        )

        // JsonConverter 示例
        this.buildExampleCard(
          'JsonConverter - JSON 转换',
          this.jsonExample
        )

        Text('更多 API 详见 toolkit_core/README.md')
          .fontSize(14)
          .fontColor('#8E8E93')
          .margin({ top: 10, bottom: 30 })
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7')
  }

  @Builder
  buildExampleCard(title: string, content: string) {
    Column() {
      Text(title)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .alignSelf(ItemAlign.Start)
        .margin({ bottom: 8 })

      Text(content)
        .fontSize(15)
        .fontColor('#3C3C43')
        .lineHeight(22)
        .alignSelf(ItemAlign.Start)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(12)
  }
}
