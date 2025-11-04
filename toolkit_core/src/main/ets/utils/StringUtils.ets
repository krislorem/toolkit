/*
 * Copyright (c) 2025 krislorem
 * toolkit_core is licensed under Mulan PSL v2.
 * You can use this software according to the terms and conditions of the Mulan PSL v2.
 * You may obtain a copy of Mulan PSL v2 at:
 *          http://license.coscl.org.cn/MulanPSL2
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND,
 * EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT,
 * MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE.
 * See the Mulan PSL v2 for more details.
 */

import util from '@ohos.util';

/**
 * 字符串工具类
 * 提供 UUID 生成、格式校验、Base64 编解码、数据脱敏等功能
 *
 * @author krislorem
 * @since 2025-11-01
 * @version 0.1.0
 */
export class StringUtils {
  /**
   * 生成 UUID (基于时间戳 + 随机数)
   * 用于生成用户唯一标识、设备 ID 等
   *
   * @returns {string} UUID 字符串 (格式: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx)
   *
   * @example
  * ```
   * const userId = StringUtils.generateUUID();
   * // 输出: "550e8400-e29b-41d4-a716-446655440000"
   * ```
   */
  static generateUUID(): string {
    const chars = '0123456789abcdef';
    let uuid = '';

    for (let i = 0; i < 36; i++) {
      if (i === 8 || i === 13 || i === 18 || i === 23) {
        uuid += '-';
      } else if (i === 14) {
        uuid += '4';
      } else if (i === 19) {
        uuid += chars.charAt(Math.floor(Math.random() * 4) + 8);
      } else {
        uuid += chars.charAt(Math.floor(Math.random() * 16));
      }
    }

    return uuid;
  }

  /**
   * 校验邮箱格式
   *
   * @param {string} email - 待校验的邮箱地址
   * @returns {boolean} 是否为合法邮箱格式
   *
   * @example
  * ```
   * StringUtils.isEmail('test@example.com'); // true
   * StringUtils.isEmail('invalid-email');     // false
   * ```
   */
  static isEmail(email: string): boolean {
    if (!email) {
      return false;
    }
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return emailRegex.test(email);
  }

  /**
   * 校验手机号格式 (中国大陆 11 位)
   *
   * @param {string} phone - 待校验的手机号
   * @returns {boolean} 是否为合法手机号
   *
   * @example
  * ```
   * StringUtils.isPhone('13812345678'); // true
   * StringUtils.isPhone('12345');        // false
   * ```
   */
  static isPhone(phone: string): boolean {
    if (!phone) {
      return false;
    }
    const phoneRegex = /^1[3-9]\d{9}$/;
    return phoneRegex.test(phone);
  }

  /**
   * 手机号脱敏处理
   * 用于隐私保护,显示时隐藏中间 4 位
   *
   * @param {string} phone - 原始手机号
   * @returns {string} 脱敏后的手机号
   *
   * @example
  * ```
   * StringUtils.maskPhone('13812345678'); // "138****5678"
   * ```
   */
  static maskPhone(phone: string): string {
    if (!phone || phone.length !== 11) {
      return phone;
    }
    return phone.substring(0, 3) + '****' + phone.substring(7);
  }

  /**
   * 邮箱脱敏处理
   * 隐藏 @ 符号前的部分字符
   *
   * @param {string} email - 原始邮箱
   * @returns {string} 脱敏后的邮箱
   *
   * @example
  * ```
   * StringUtils.maskEmail('test@example.com'); // "t***@example.com"
   * ```
   */
  static maskEmail(email: string): string {
    if (!email || !email.includes('@')) {
      return email;
    }
    const parts = email.split('@');
    const name = parts[0];
    const domain = parts[1];
    if (name.length <= 1) {
      return email;
    }
    const maskedName = name.charAt(0) + '***';
    return `${maskedName}@${domain}`;
  }

  /**
   * Base64 编码
   *
   * @param {string} str - 待编码的字符串
   * @returns {string} Base64 编码后的字符串
   *
   * @example
  * ```
   * StringUtils.base64Encode('Hello World'); // "SGVsbG8gV29ybGQ="
   * ```
   */
  static base64Encode(str: string): string {
    if (!str) {
      return '';
    }

    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
    let output = '';
    let i = 0;

    const textEncoder = new util.TextEncoder();
    const bytes = textEncoder.encodeInto(str);

    while (i < bytes.length) {
      const chr1 = bytes[i++];
      const chr2 = i < bytes.length ? bytes[i++] : Number.NaN;
      const chr3 = i < bytes.length ? bytes[i++] : Number.NaN;

      const enc1 = chr1 >> 2;
      const enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
      let enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
      let enc4 = chr3 & 63;

      if (isNaN(chr2)) {
        enc3 = enc4 = 64;
      } else if (isNaN(chr3)) {
        enc4 = 64;
      }

      output += chars.charAt(enc1) + chars.charAt(enc2) +
      chars.charAt(enc3) + chars.charAt(enc4);
    }

    return output;
  }

  /**
   * Base64 解码
   *
   * @param {string} str - Base64 编码的字符串
   * @returns {string} 解码后的字符串
   *
   * @example
  * ```
   * StringUtils.base64Decode('SGVsbG8gV29ybGQ='); // "Hello World"
   * ```
   */
  static base64Decode(str: string): string {
    if (!str) {
      return '';
    }

    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
    let i = 0;

    str = str.replace(/[^A-Za-z0-9+/=]/g, '');

    const bytes: number[] = [];

    while (i < str.length) {
      const enc1 = chars.indexOf(str.charAt(i++));
      const enc2 = chars.indexOf(str.charAt(i++));
      const enc3 = chars.indexOf(str.charAt(i++));
      const enc4 = chars.indexOf(str.charAt(i++));

      const chr1 = (enc1 << 2) | (enc2 >> 4);
      const chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
      const chr3 = ((enc3 & 3) << 6) | enc4;

      bytes.push(chr1);
      if (enc3 !== 64) {
        bytes.push(chr2);
      }
      if (enc4 !== 64) {
        bytes.push(chr3);
      }
    }

    const textDecoder = new util.TextDecoder();
    return textDecoder.decodeToString(new Uint8Array(bytes));
  }

  /**
   * 判断字符串是否为空或仅包含空格
   *
   * @param {string} str - 待判断的字符串
   * @returns {boolean} 是否为空
   *
   * @example
  * ```
   * StringUtils.isEmpty('');      // true
   * StringUtils.isEmpty('   ');   // true
   * StringUtils.isEmpty('hello'); // false
   * ```
   */
  static isEmpty(str: string | null | undefined): boolean {
    return !str || str.trim().length === 0;
  }

  /**
   * 判断字符串是否不为空
   *
   * @param {string} str - 待判断的字符串
   * @returns {boolean} 是否不为空
   */
  static isNotEmpty(str: string | null | undefined): boolean {
    return !StringUtils.isEmpty(str);
  }

  /**
   * 字符串截取并添加省略号
   * 用于标题、描述等文本的截断显示
   *
   * @param {string} str - 原始字符串
   * @param {number} maxLength - 最大长度
   * @param {string} suffix - 省略号后缀 (默认: "...")
   * @returns {string} 截取后的字符串
   *
   * @example
  * ```
   * StringUtils.truncate('这是一段很长的文字', 5); // "这是一段很..."
   * ```
   */
  static truncate(str: string, maxLength: number, suffix: string = '...'): string {
    if (!str || str.length <= maxLength) {
      return str;
    }
    return str.substring(0, maxLength) + suffix;
  }

  /**
   * 移除 HTML 标签
   * 用于富文本内容的纯文本提取
   *
   * @param {string} html - HTML 字符串
   * @returns {string} 纯文本内容
   *
   * @example
  * ```
   * StringUtils.stripHtml('<p>Hello</p>'); // "Hello"
   * ```
   */
  static stripHtml(html: string): string {
    if (!html) {
      return '';
    }
    return html.replace(/<[^>]*>/g, '');
  }

  /**
   * 首字母大写
   *
   * @param {string} str - 原始字符串
   * @returns {string} 首字母大写后的字符串
   *
   * @example
  * ```
   * StringUtils.capitalize('hello'); // "Hello"
   * ```
   */
  static capitalize(str: string): string {
    if (!str) {
      return '';
    }
    return str.charAt(0).toUpperCase() + str.slice(1);
  }
}