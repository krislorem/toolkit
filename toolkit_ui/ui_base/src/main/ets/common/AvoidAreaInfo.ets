import { window } from '@kit.ArkUI';
import { UIBase } from './UIBase';
import { AvoidAreaCallback, PaddingType } from './Model';
import { Logger } from '@krislorem/toolkit_core';

/**
 * 用于处理ArkUI窗口中需要避让的区域（如状态栏、挖孔屏、导航条等）。主要功能包括：
 * 获取各类避让区域的高度和位置；
 * 根据是否启用AI导航条，返回相应的底部内边距；
 * 提供获取状态栏和导航条高度的接口。
 */
export class AvoidAreaInfo {
  static readonly paddingWithAIBar: number = 16;
  static readonly paddingWithoutAIBar: number = 16;
  private static isEnableAIBar: boolean = true;
  private static systemH: number = 0;
  private static aiBarH: number = 0;
  private static cutout: PaddingType = {
    top: 0,
    bottom: 0,
    left: 0,
    right: 0
  };

  // 获取内容区域和底部的距离
  public static getCommonPaddingBottom(): number {
    if (AvoidAreaInfo.isEnableAIBar) {
      return AvoidAreaInfo.paddingWithAIBar;
    }
    return AvoidAreaInfo.paddingWithoutAIBar;
  }

  public static getAvoidAreaOnce(considerCutout: boolean = false): PaddingType | undefined {
    const windowClass = UIBase.getWindow();

    if (!windowClass) {
      return undefined;
    }

    try {
      Logger.info('getAvoidAreaOnce start.')
      const systemArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM);
      AvoidAreaInfo.handle({ type: window.AvoidAreaType.TYPE_SYSTEM, area: systemArea }, considerCutout);

      const cutoutArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_CUTOUT);
      AvoidAreaInfo.handle({ type: window.AvoidAreaType.TYPE_CUTOUT, area: cutoutArea }, considerCutout);

      const aiBarArea = windowClass.getWindowAvoidArea(window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR);
      return AvoidAreaInfo.handle({
        type: window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR,
        area: aiBarArea
      }, considerCutout);
    } catch (e) {
      Logger.error(`getAvoidAreaOnce failed, exception: ${JSON.stringify(e)}`);
      return undefined;
    }
  }

  public static handle(data: AvoidAreaCallback, considerCutout: boolean = false) {
    Logger.info('AvoidAreaInfo handle start.');
    // 状态栏
    if (data.type === window.AvoidAreaType.TYPE_SYSTEM) {
      AvoidAreaInfo.systemH = px2vp(data.area.topRect.height);
      Logger.info(`AvoidAreaInfo handle, system height: ${AvoidAreaInfo.systemH}vp`);
    }

    // 挖孔
    if (data.type === window.AvoidAreaType.TYPE_CUTOUT) {
      const windowRect = UIBase.getWindowRect();

      if (data.area.topRect.height) {
        AvoidAreaInfo.cutout.top = px2vp(data.area.topRect.top + data.area.topRect.height);
        Logger.info(`AvoidAreaInfo handle, cutout top height: ${AvoidAreaInfo.cutout.top}vp`);
      } else if (data.area.rightRect.height && windowRect?.width) {
        AvoidAreaInfo.cutout.right = px2vp(windowRect.width - data.area.rightRect.left);
        Logger.info(`AvoidAreaInfo handle, cutout right width: ${AvoidAreaInfo.cutout.right}vp`);
      } else if (data.area.bottomRect.height && windowRect?.height) {
        AvoidAreaInfo.cutout.bottom = px2vp(windowRect.height - data.area.bottomRect.top);
        Logger.info(`AvoidAreaInfo handle, cutout bottom height: ${AvoidAreaInfo.cutout.bottom}vp`);
      } else if (data.area.leftRect.height) {
        AvoidAreaInfo.cutout.left = px2vp(data.area.leftRect.left + data.area.leftRect.width);
        Logger.info(`AvoidAreaInfo handle, cutout left width: ${AvoidAreaInfo.cutout.left}vp`);
      }
    }

    // 底部导航条
    if (data.type === window.AvoidAreaType.TYPE_NAVIGATION_INDICATOR) {
      AvoidAreaInfo.aiBarH = px2vp(data.area.bottomRect.height);
      Logger.info(`AvoidAreaInfo handle, navigation indicator height: ${AvoidAreaInfo.aiBarH}vp`);
      AvoidAreaInfo.enableAIBar(AvoidAreaInfo.aiBarH > 0);
    }

    Logger.info('AvoidAreaInfo handle end.');
    return AvoidAreaInfo.get(considerCutout);
  }

  // 获取上下左右需要避让的距离
  public static get(considerCutout: boolean = false): PaddingType {
    let cutoutInfo: PaddingType = {
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
    };
    if (considerCutout) {
      cutoutInfo = AvoidAreaInfo.cutout;
    }
    const resp: PaddingType = {
      top: 0,
      bottom: 0,
      left: 0,
      right: 0,
    };

    resp.top = Math.max(AvoidAreaInfo.systemH, cutoutInfo.top);
    resp.bottom = Math.max(AvoidAreaInfo.aiBarH, cutoutInfo.bottom);
    resp.left = cutoutInfo.left;
    resp.right = cutoutInfo.right;

    return resp;
  }

  // 获取状态栏的高度
  public static getStatusH() {
    return AvoidAreaInfo.systemH;
  }

  // 获取底部导航条的高度
  public static getAIBarH() {
    return AvoidAreaInfo.aiBarH;
  }

  private static enableAIBar(flag: boolean): void {
    AvoidAreaInfo.isEnableAIBar = flag;
  }
}