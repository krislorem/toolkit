import { Width } from './Constant';

/**
 * 网格布局配置类，用于统一管理应用的网格布局样式配置。主要功能包括：
 * 静态配置：定义了网格行选项（gutter、columns、breakpoints）和网格边距的默认值
 * 获取网格选项：getCommonGridOption 方法返回带有指定方向的网格配置副本
 * 获取边距：getGridMargin 根据断点返回对应边距值
 * 获取列数：getColumn 根据断点返回对应列数，默认4列
 */
export class CommonGridSetting {
  private static gridRowOptions: GridRowOptions = {
    gutter: {
      x: {
        sm: 16,
        md: 16,
        lg: 16,
        xl: 16
      }
    },
    columns: {
      sm: 4,
      md: 8,
      lg: 12,
      xl: 12
    },
    breakpoints: {
      value: [Width.ZERO, Width.SM, Width.MD, Width.LG],
      reference: BreakpointsReference.WindowSize,
    },
  };
  private static readonly gridMargin: GridRowSizeOption = {
    sm: 16,
    md: 24,
    lg: 24,
    xl: 24
  };

  static getCommonGridOption(direction: GridRowDirection = GridRowDirection.Row) {
    const options: GridRowOptions = JSON.parse(JSON.stringify(CommonGridSetting.gridRowOptions));
    options.direction = direction;
    return options;
  }

  static getGridMargin(breakpoint: string): number {
    return CommonGridSetting.gridMargin[breakpoint];
  }

  static getColumn(breakpoint: string): number {
    if (CommonGridSetting.gridRowOptions.columns) {
      return CommonGridSetting.gridRowOptions.columns[breakpoint];
    }
    return 4;
  }
}