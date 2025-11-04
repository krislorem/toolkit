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
 * 正则表达式常量接口
 */
export interface RegexConstants {
  EMAIL: RegExp;
  PHONE: RegExp;
  ID_CARD: RegExp;
  URL: RegExp;
  IPV4: RegExp;
  CHINESE: RegExp;
}

/**
 * 时间常量接口 (毫秒)
 */
export interface TimeConstants {
  SECOND: number;
  MINUTE: number;
  HOUR: number;
  DAY: number;
  WEEK: number;
}

/**
 * HTTP 状态码接口
 */
export interface HttpStatusConstants {
  OK: number;
  CREATED: number;
  NO_CONTENT: number;
  BAD_REQUEST: number;
  UNAUTHORIZED: number;
  FORBIDDEN: number;
  NOT_FOUND: number;
  SERVER_ERROR: number;
  BAD_GATEWAY: number;
  SERVICE_UNAVAILABLE: number;
}

/**
 * 文件大小单位接口
 */
export interface FileSizeConstants {
  KB: number;
  MB: number;
  GB: number;
}

/**
 * 默认配置接口
 */
export interface DefaultConstants {
  TIMEOUT: number;
  PAGE: number;
  PAGE_SIZE: number;
  CACHE_TIME: number;
}

/**
 * 公共常量定义
 *
 * @author krislorem
 * @since 2025-11-01
 * @version 0.1.0
 */
export class CommonConstants {
  /**
   * 正则表达式常量
   */
  static readonly REGEX: RegexConstants = {
    /**
     * 邮箱正则
     */
    EMAIL: /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,

    /**
     * 手机号正则 (中国大陆 11 位)
     */
    PHONE: /^1[3-9]\d{9}$/,

    /**
     * 身份证号正则 (18 位)
     */
    ID_CARD: /^[1-9]\d{5}(18|19|20)\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])\d{3}[\dXx]$/,

    /**
     * URL 正则
     */
    URL: /^(https?:\/\/)?([\da-z.-]+)\.([a-z.]{2,6})([/\w .-]*)*\/?$/,

    /**
     * IPv4 地址正则
     */
    IPV4: /^((25[0-5]|2[0-4]\d|[01]?\d\d?)\.){3}(25[0-5]|2[0-4]\d|[01]?\d\d?)$/,

    /**
     * 汉字正则
     */
    CHINESE: /^[\u4e00-\u9fa5]+$/
  };
  /**
   * 时间相关常量 (毫秒)
   */
  static readonly TIME: TimeConstants = {
    SECOND: 1000,
    MINUTE: 60 * 1000,
    HOUR: 60 * 60 * 1000,
    DAY: 24 * 60 * 60 * 1000,
    WEEK: 7 * 24 * 60 * 60 * 1000
  };
  /**
   * HTTP 状态码
   */
  static readonly HTTP_STATUS: HttpStatusConstants = {
    OK: 200,
    CREATED: 201,
    NO_CONTENT: 204,
    BAD_REQUEST: 400,
    UNAUTHORIZED: 401,
    FORBIDDEN: 403,
    NOT_FOUND: 404,
    SERVER_ERROR: 500,
    BAD_GATEWAY: 502,
    SERVICE_UNAVAILABLE: 503
  };
  /**
   * 文件大小单位
   */
  static readonly FILE_SIZE: FileSizeConstants = {
    KB: 1024,
    MB: 1024 * 1024,
    GB: 1024 * 1024 * 1024
  };
  /**
   * 默认配置
   */
  static readonly DEFAULT: DefaultConstants = {
    /**
     * 默认请求超时时间 (毫秒)
     */
    TIMEOUT: 15000,

    /**
     * 默认页码
     */
    PAGE: 1,

    /**
     * 默认每页数量
     */
    PAGE_SIZE: 20,

    /**
     * 默认缓存时间 (秒)
     */
    CACHE_TIME: 1800
  };
}