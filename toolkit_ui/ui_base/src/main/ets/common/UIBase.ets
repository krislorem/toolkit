import { window } from '@kit.ArkUI';
import { Callback } from '@kit.BasicServicesKit';
import { Logger } from '@krislorem/toolkit_core';
import { AvoidAreaCallback, WindowConfig } from './Model';

/**
 * 用于管理应用窗口相关操作。主要功能包括：
 * 初始化窗口管理器、获取主窗口、监听与取消监听系统规避区域和窗口大小变化、以及获取窗口属性和布局信息
 * 通过封装 window 模块的 API，提供更便捷的窗口控制方法
 * 支持一键配置沉浸式窗口和系统栏样式
 */
export class UIBase {
  static readonly windowStageName: string = 'UI.WindowStage';

  // 初始化窗口管理器，支持沉浸式配置
  static init(windowStage: window.WindowStage, config?: WindowConfig): void {
    AppStorage.setOrCreate(UIBase.windowStageName, windowStage);

    if (config?.immersive) {
      UIBase.setupImmersiveWindow(config);
    }
  }

  // 获取主窗口
  static getWindow(): window.Window | undefined {
    const windowStage: window.WindowStage | undefined = AppStorage.get(UIBase.windowStageName);
    if (!windowStage) {
      return undefined;
    }
    try {
      return windowStage.getMainWindowSync();
    } catch (e) {
      Logger.error(`UIBase getWindow failed, exception: ${JSON.stringify(e)}`);
      return undefined;
    }
  }

  // 开启系统规避区域的监听
  static onAvoidAreaChange(callback: Callback<AvoidAreaCallback>) {
    const windowCur = UIBase.getWindow();
    if (!windowCur) {
      return;
    }
    try {
      windowCur.on('avoidAreaChange', callback);
    } catch (e) {
      Logger.error(`UIBase onAvoidAreaChange failed, exception: ${JSON.stringify(e)}`);
    }
  }

  // 关闭系统规避区域的监听
  static offAvoidAreaChange(callback: Callback<AvoidAreaCallback>) {
    const windowCur = UIBase.getWindow();
    if (!windowCur) {
      return;
    }
    try {
      windowCur.off('avoidAreaChange', callback);
    } catch (e) {
      Logger.error(`UIBase offAvoidAreaChange failed, exception: ${JSON.stringify(e)}`);
    }
  }

  // 监听窗口大小变化
  static onWindowSizeChange(callback: Callback<Size>) {
    const windowCur = UIBase.getWindow();
    if (!windowCur) {
      return;
    }
    try {
      windowCur.on('windowSizeChange', callback);
    } catch (e) {
      Logger.error('UIBase on windowSizeChange fail, error: ' + JSON.stringify(e));
    }
  }

  // 取消监听窗口大小变化
  static offWindowSizeChange(callback: Callback<Size>) {
    const windowCur = UIBase.getWindow();
    if (!windowCur) {
      return;
    }
    try {
      windowCur.off('windowSizeChange', callback);
    } catch (e) {
      Logger.error('UIBase off windowSizeChange fail, error: ' + JSON.stringify(e));
    }
  }

  // 获取窗口属性
  public static getWindowProperties(): window.WindowProperties | undefined {
    const windowClass: window.Window | undefined = UIBase.getWindow();
    try {
      return windowClass?.getWindowProperties();
    } catch (e) {
      Logger.error(`AvoidAreaInfo getWindowRect failed, exception: ${JSON.stringify(e)}`);
      return undefined;
    }
  }

  // 获取窗口Rect
  public static getWindowRect() {
    const windowProperties: window.WindowProperties | undefined = UIBase.getWindowProperties();
    return windowProperties?.windowRect;
  }

  // 判断窗口是否沉浸式
  public static isWindowLayoutFullScreen() {
    const windowProperties: window.WindowProperties | undefined = UIBase.getWindowProperties();
    return windowProperties?.isLayoutFullScreen;
  }

  // 根据颜色字符串计算亮度，返回是否为浅色
  public static isLightColor(colorStr: string | ResourceColor): boolean {
    if (typeof colorStr !== 'string') {
      return false;
    }

    let color = colorStr.trim();
    let r = 0, g = 0, b = 0;

    // 处理 #RRGGBB 或 #AARRGGBB 格式
    if (color.startsWith('#')) {
      color = color.substring(1);
      if (color.length === 6) {
        r = parseInt(color.substring(0, 2), 16);
        g = parseInt(color.substring(2, 4), 16);
        b = parseInt(color.substring(4, 6), 16);
      } else if (color.length === 8) {
        r = parseInt(color.substring(2, 4), 16);
        g = parseInt(color.substring(4, 6), 16);
        b = parseInt(color.substring(6, 8), 16);
      }
    }

    // 使用 YIQ 公式计算亮度
    const yiq = (r * 299 + g * 587 + b * 114) / 1000;
    return yiq >= 128;
  }

  // 动态设置系统栏颜色
  public static setSystemBarColor(bgColor: string | ResourceColor): void {
    const windowCur = UIBase.getWindow();
    if (!windowCur) {
      Logger.error('UIBase setSystemBarColor failed: window is undefined');
      return;
    }

    const isLight = UIBase.isLightColor(bgColor);
    const contentColor = isLight ? '#000000' : '#FFFFFF';

    const systemBarProperties: window.SystemBarProperties = {
      statusBarColor: '#00000000',
      navigationBarColor: '#00000000',
      statusBarContentColor: contentColor,
      navigationBarContentColor: contentColor
    };

    windowCur.setWindowSystemBarProperties(systemBarProperties).then(() => {
      Logger.info(`UIBase: Set system bar content color to ${contentColor} for bg ${bgColor}`);
    }).catch((err: Error) => {
      Logger.error(`UIBase: Failed to set system bar properties. Cause: ${JSON.stringify(err)}`);
    });
  }

  // 设置沉浸式窗口
  private static setupImmersiveWindow(config: WindowConfig): void {
    const windowStage: window.WindowStage | undefined = AppStorage.get(UIBase.windowStageName);
    if (!windowStage) {
      Logger.error('UIBase setupImmersiveWindow failed: windowStage is undefined');
      return;
    }

    windowStage.getMainWindow().then((windowClass: window.Window) => {
      windowClass.setWindowLayoutFullScreen(true).then(() => {
        Logger.info('UIBase: Succeeded in setting window layout full screen');
      }).catch((err: Error) => {
        Logger.error(`UIBase: Failed to set window layout full screen. Cause: ${JSON.stringify(err)}`);
      });

      const systemBarProperties: window.SystemBarProperties = {
        statusBarColor: config.statusBarColor || '#00000000',
        navigationBarColor: config.navigationBarColor || '#00000000',
        statusBarContentColor: config.statusBarContentColor || '#FFFFFF',
        navigationBarContentColor: config.navigationBarContentColor || '#FFFFFF'
      };

      windowClass.setWindowSystemBarProperties(systemBarProperties).then(() => {
        Logger.info('UIBase: Succeeded in setting system bar properties');
      }).catch((err: Error) => {
        Logger.error(`UIBase: Failed to set system bar properties. Cause: ${JSON.stringify(err)}`);
      });
    }).catch((err: Error) => {
      Logger.error(`UIBase: Failed to get main window. Cause: ${JSON.stringify(err)}`);
    });
  }
}