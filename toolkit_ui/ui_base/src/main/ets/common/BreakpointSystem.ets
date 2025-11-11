import mediaQuery from '@ohos.mediaquery';
import { BREAKPOINT_PROP_NAME, Width } from './Constant';
import { Logger } from '@krislorem/toolkit_core';

/**
 * 实现了一个响应式断点系统，用于监听屏幕宽度变化并更新对应的断点状态（sm、md、lg、xl）。
 * 通过媒体查询匹配不同宽度区间，并在匹配成功时更新全局存储中的断点值，同时提供注册和注销监听器的方法。
 */
export class CommonBreakpointSystem {
  private static smListen: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(`(width<${Width.SM})`);
  private static mdListen: mediaQuery.MediaQueryListener =
    mediaQuery.matchMediaSync(`(width>=${Width.SM}) and (width<${Width.MD})`);
  private static lgListen: mediaQuery.MediaQueryListener =
    mediaQuery.matchMediaSync(`(width>=${Width.MD}) and (width<${Width.LG})`);
  private static xlListen: mediaQuery.MediaQueryListener = mediaQuery.matchMediaSync(`(width>=${Width.LG})`);
  private static registered: boolean = false;

  static register() {
    if (CommonBreakpointSystem.registered) {
      return;
    }
    CommonBreakpointSystem.registered = true;
    CommonBreakpointSystem.smListen.on('change', CommonBreakpointSystem.smFunc);
    CommonBreakpointSystem.mdListen.on('change', CommonBreakpointSystem.mdFunc);
    CommonBreakpointSystem.lgListen.on('change', CommonBreakpointSystem.lgFunc);
    CommonBreakpointSystem.xlListen.on('change', CommonBreakpointSystem.xlFunc);
    Logger.info('BreakpointSystem register success.');
  }

  static unRegister() {
    if (!CommonBreakpointSystem.registered) {
      return;
    }
    CommonBreakpointSystem.registered = false;
    CommonBreakpointSystem.smListen.off('change', CommonBreakpointSystem.smFunc);
    CommonBreakpointSystem.mdListen.off('change', CommonBreakpointSystem.mdFunc);
    CommonBreakpointSystem.lgListen.off('change', CommonBreakpointSystem.lgFunc);
    CommonBreakpointSystem.xlListen.off('change', CommonBreakpointSystem.xlFunc);
    Logger.info('BreakpointSystem unregister success.');
  }

  private static updateBreakpoint(value: string) {
    AppStorage.setOrCreate(BREAKPOINT_PROP_NAME, value);
    Logger.info(`BreakpointSystem update: ${value}`);
  }

  private static smFunc(result: mediaQuery.MediaQueryResult) {
    if (result.matches) {
      CommonBreakpointSystem.updateBreakpoint('sm');
    }
  }

  private static mdFunc(result: mediaQuery.MediaQueryResult) {
    if (result.matches) {
      CommonBreakpointSystem.updateBreakpoint('md');
    }
  }

  private static lgFunc(result: mediaQuery.MediaQueryResult) {
    if (result.matches) {
      CommonBreakpointSystem.updateBreakpoint('lg');
    }
  }

  private static xlFunc(result: mediaQuery.MediaQueryResult) {
    if (result.matches) {
      CommonBreakpointSystem.updateBreakpoint('xl');
    }
  }
}