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

/**
 * JSON 转换工具类
 * 提供 JSON 与对象互转、安全解析等功能
 *
 * @author krislorem
 * @since 2025-11-01
 * @version 0.1.0
 */
export class JsonConverter {
  /**
   * 对象转 JSON 字符串
   *
   * @param {ESObject} obj - 待转换的对象
   * @param {boolean} pretty - 是否格式化输出 (默认: false)
   * @returns {string} JSON 字符串
   *
   * @example
  * ```
   * const user = { name: '张三', age: 25 };
   * JsonConverter.toJson(user);
   * // '{"name":"张三","age":25}'
   *
   * JsonConverter.toJson(user, true);
   * // {
   * //   "name": "张三",
   * //   "age": 25
   * // }
   * ```
   */
  static toJson(obj: object | null | undefined, pretty: boolean = false): string {
    if (obj === null || obj === undefined) {
      return '';
    }

    try {
      return pretty ? JSON.stringify(obj, null, 2) : JSON.stringify(obj);
    } catch (e) {
      console.error('JsonConverter.toJson error:', e);
      return '';
    }
  }

  /**
   * JSON 字符串转对象 (带类型推断)
   *
   * @param {string} jsonStr - JSON 字符串
   * @returns {T | null} 解析后的对象,失败返回 null
   *
   * @example
  * ```
   * interface User {
   *   name: string;
   *   age: number;
   * }
   *
   * const jsonStr = '{"name":"张三","age":25}';
   * const user = JsonConverter.fromJson<User>(jsonStr);
   * // { name: "张三", age: 25 }
   * ```
   */
  static fromJson<T>(jsonStr: string): T | null {
    if (!jsonStr) {
      return null;
    }

    try {
      return JSON.parse(jsonStr) as T;
    } catch (e) {
      console.error('JsonConverter.fromJson error:', e);
      return null;
    }
  }

  /**
   * 安全的 JSON 解析 (失败时返回默认值)
   *
   * @param {string} jsonStr - JSON 字符串
   * @param {T} defaultValue - 解析失败时的默认值
   * @returns {T} 解析后的对象或默认值
   *
   * @example
  * ```
   * const data = JsonConverter.safeJsonParse('invalid json', { error: true });
   * // { error: true }
   * ```
   */
  static safeJsonParse<T>(jsonStr: string, defaultValue: T): T {
    try {
      return JSON.parse(jsonStr) as T;
    } catch (e) {
      return defaultValue;
    }
  }

  /**
   * 深拷贝对象 (通过 JSON 序列化实现)
   *
   * @param {T} obj - 待拷贝的对象
   * @returns {T | null} 拷贝后的对象
   *
   * @example
  * ```
   * const original = { name: '张三', hobbies: ['阅读', '运动'] };
   * const copied = JsonConverter.deepClone(original);
   * // copied 是 original 的深拷贝
   * ```
   */
  static deepClone<T>(obj: T): T | null {
    try {
      return JSON.parse(JSON.stringify(obj)) as T;
    } catch (e) {
      console.error('JsonConverter.deepClone error:', e);
      return null;
    }
  }

  /**
   * 判断字符串是否为合法 JSON
   *
   * @param {string} str - 待判断的字符串
   * @returns {boolean} 是否为合法 JSON
   *
   * @example
  * ```
   * JsonConverter.isValidJson('{"name":"张三"}'); // true
   * JsonConverter.isValidJson('invalid');         // false
   * ```
   */
  static isValidJson(str: string): boolean {
    if (!str) {
      return false;
    }

    try {
      JSON.parse(str);
      return true;
    } catch (e) {
      return false;
    }
  }
}