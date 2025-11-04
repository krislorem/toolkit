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

import deviceInfo from '@ohos.deviceInfo';

/**
 * 设备完整信息接口
 */
export interface DeviceFullInfo {
  model: string;
  osVersion: string;
  brand: string;
  manufacturer: string;
  deviceType: string;
  sdkVersion: number;
  deviceId: string;
}

/**
 * 设备信息工具类
 * 获取设备型号、系统版本、屏幕信息等
 *
 * @author krislorem
 * @since 2025-11-01
 * @version 0.1.0
 */
export class DeviceInfo {
  /**
   * 获取设备型号
   *
   * @returns {string} 设备型号 (如: "HUAWEI Mate 60")
   *
   * @example
  * ```
   * const model = DeviceInfo.getModel();
   * console.log(model); // "HUAWEI Mate 60"
   * ```
   */
  static getModel(): string {
    return deviceInfo.productModel || 'Unknown';
  }

  /**
   * 获取系统版本号
   *
   * @returns {string} 系统版本 (如: "HarmonyOS 4.0.0")
   *
   * @example
  * ```
   * const version = DeviceInfo.getOSVersion();
   * console.log(version); // "HarmonyOS 4.0.0"
   * ```
   */
  static getOSVersion(): string {
    return deviceInfo.osFullName || 'Unknown';
  }

  /**
   * 获取设备品牌
   *
   * @returns {string} 设备品牌 (如: "HUAWEI")
   */
  static getBrand(): string {
    return deviceInfo.brand || 'Unknown';
  }

  /**
   * 获取设备制造商
   *
   * @returns {string} 设备制造商
   */
  static getManufacturer(): string {
    return deviceInfo.manufacture || 'Unknown';
  }

  /**
   * 获取设备类型
   *
   * @returns {string} 设备类型 (phone/tablet/tv/wearable)
   */
  static getDeviceType(): string {
    return deviceInfo.deviceType || 'Unknown';
  }

  /**
   * 获取 SDK 版本号
   *
   * @returns {number} SDK API Level
   */
  static getSDKVersion(): number {
    return deviceInfo.sdkApiVersion || 0;
  }

  /**
   * 获取设备标识信息
   * 注意: UDID 和序列号都需要特殊权限，这里返回设备型号作为标识
   *
   * @returns {string} 设备标识（基于型号和品牌组合）
   */
  static getDeviceId(): string {
    const model = deviceInfo.productModel || 'Unknown';
    const brand = deviceInfo.brand || 'Unknown';
    return `${brand}_${model}`;
  }

  /**
   * 获取系统完整信息
   *
   * @returns {DeviceFullInfo} 设备信息对象
   *
   * @example
  * ```
   * const info = DeviceInfo.getFullInfo();
   * console.log(info);
   * // {
   * //   model: "HUAWEI Mate 60",
   * //   osVersion: "HarmonyOS 4.0.0",
   * //   brand: "HUAWEI",
   * //   deviceType: "phone"
   * // }
   * ```
   */
  static getFullInfo(): DeviceFullInfo {
    return {
      model: DeviceInfo.getModel(),
      osVersion: DeviceInfo.getOSVersion(),
      brand: DeviceInfo.getBrand(),
      manufacturer: DeviceInfo.getManufacturer(),
      deviceType: DeviceInfo.getDeviceType(),
      sdkVersion: DeviceInfo.getSDKVersion(),
      deviceId: DeviceInfo.getDeviceId()
    };
  }
}