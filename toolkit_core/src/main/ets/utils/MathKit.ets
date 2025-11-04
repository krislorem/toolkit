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
 * 数学工具类
 * 提供数字格式化、百分比计算、随机数生成等功能
 *
 * @author krislorem
 * @since 2025-11-01
 * @version 0.1.0
 */
export class MathKit {
  /**
   * 数字格式化 (千分位分隔)
   *
   * @param {number} num - 待格式化的数字
   * @param {number} decimals - 小数位数 (默认: 0)
   * @returns {string} 格式化后的字符串
   *
   * @example
  * ```
   * MathKit.formatNumber(1234567);       // "1,234,567"
   * MathKit.formatNumber(1234.567, 2);   // "1,234.57"
   * ```
   */
  static formatNumber(num: number, decimals: number = 0): string {
    if (isNaN(num)) {
      return '0';
    }

    const fixed = num.toFixed(decimals);
    const parts = fixed.split('.');
    const integerPart = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ',');

    return decimals > 0 && parts[1] ? `${integerPart}.${parts[1]}` : integerPart;
  }

  /**
   * 计算百分比
   * 用于显示课程进度、完成率等
   *
   * @param {number} part - 部分值
   * @param {number} total - 总值
   * @param {number} decimals - 小数位数 (默认: 0)
   * @returns {number} 百分比数值
   *
   * @example
  * ```
   * MathKit.percentage(45, 100);     // 45
   * MathKit.percentage(33, 100, 2);  // 33.00
   * ```
   */
  static percentage(part: number, total: number, decimals: number = 0): number {
    if (total === 0) {
      return 0;
    }
    const percent = (part / total) * 100;
    return Number(percent.toFixed(decimals));
  }

  /**
   * 生成指定范围内的随机整数
   *
   * @param {number} min - 最小值 (包含)
   * @param {number} max - 最大值 (包含)
   * @returns {number} 随机整数
   *
   * @example
  * ```
   * MathKit.randomInt(1, 10);  // 1-10 之间的随机整数
   * ```
   */
  static randomInt(min: number, max: number): number {
    min = Math.ceil(min);
    max = Math.floor(max);
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }

  /**
   * 生成指定范围内的随机小数
   *
   * @param {number} min - 最小值
   * @param {number} max - 最大值
   * @param {number} decimals - 小数位数 (默认: 2)
   * @returns {number} 随机小数
   *
   * @example
  * ```
   * MathKit.randomFloat(1, 10, 2);  // 1.00-10.00 之间的随机小数
   * ```
   */
  static randomFloat(min: number, max: number, decimals: number = 2): number {
    const rand = Math.random() * (max - min) + min;
    return Number(rand.toFixed(decimals));
  }

  /**
   * 数值范围限制
   * 确保数值在指定范围内
   *
   * @param {number} value - 原始值
   * @param {number} min - 最小值
   * @param {number} max - 最大值
   * @returns {number} 限制后的值
   *
   * @example
  * ```
   * MathKit.clamp(150, 0, 100);  // 100
   * MathKit.clamp(-10, 0, 100);  // 0
   * MathKit.clamp(50, 0, 100);   // 50
   * ```
   */
  static clamp(value: number, min: number, max: number): number {
    return Math.min(Math.max(value, min), max);
  }

  /**
   * 四舍五入到指定小数位
   *
   * @param {number} value - 原始值
   * @param {number} decimals - 小数位数
   * @returns {number} 四舍五入后的值
   *
   * @example
  * ```
   * MathKit.round(3.14159, 2);  // 3.14
   * ```
   */
  static round(value: number, decimals: number = 0): number {
    const multiplier = Math.pow(10, decimals);
    return Math.round(value * multiplier) / multiplier;
  }

  /**
   * 向上取整到指定小数位
   *
   * @param {number} value - 原始值
   * @param {number} decimals - 小数位数
   * @returns {number} 向上取整后的值
   */
  static ceil(value: number, decimals: number = 0): number {
    const multiplier = Math.pow(10, decimals);
    return Math.ceil(value * multiplier) / multiplier;
  }

  /**
   * 向下取整到指定小数位
   *
   * @param {number} value - 原始值
   * @param {number} decimals - 小数位数
   * @returns {number} 向下取整后的值
   */
  static floor(value: number, decimals: number = 0): number {
    const multiplier = Math.pow(10, decimals);
    return Math.floor(value * multiplier) / multiplier;
  }

  /**
   * 计算平均值
   *
   * @param {number[]} numbers - 数字数组
   * @returns {number} 平均值
   *
   * @example
  * ```
   * MathKit.average([1, 2, 3, 4, 5]);  // 3
   * ```
   */
  static average(numbers: number[]): number {
    if (!numbers || numbers.length === 0) {
      return 0;
    }
    let sum = 0;
    for (let i = 0; i < numbers.length; i++) {
      sum += numbers[i];
    }
    return sum / numbers.length;
  }

  /**
   * 计算总和
   *
   * @param {number[]} numbers - 数字数组
   * @returns {number} 总和
   *
   * @example
  * ```
   * MathKit.sum([1, 2, 3, 4, 5]);  // 15
   * ```
   */
  static sum(numbers: number[]): number {
    if (!numbers || numbers.length === 0) {
      return 0;
    }
    let sum = 0;
    for (let i = 0; i < numbers.length; i++) {
      sum += numbers[i];
    }
    return sum;
  }

  /**
   * 获取最大值
   *
   * @param {number[]} numbers - 数字数组
   * @returns {number} 最大值
   */
  static max(numbers: number[]): number {
    if (!numbers || numbers.length === 0) {
      return 0;
    }
    return Math.max(...numbers);
  }

  /**
   * 获取最小值
   *
   * @param {number[]} numbers - 数字数组
   * @returns {number} 最小值
   */
  static min(numbers: number[]): number {
    if (!numbers || numbers.length === 0) {
      return 0;
    }
    return Math.min(...numbers);
  }
}