import { CommonGridSetting } from '@krislorem/ui-base';
import { configLG, configSM } from './Constant';

@ObservedV2
class ConfigUtil {
  @Trace breakpoint: string = 'sm'

  @Computed
  get uiConfig() {
    if (this.breakpoint === 'sm' || this.breakpoint === 'md') {
      return configSM;
    }
    return configLG;
  }

  @Computed
  get gridMargin(){
    return CommonGridSetting.getGridMargin(this.breakpoint)
  }

  public updateBreakPoint(val:string){
    this.breakpoint = val
  }
}

const util = new ConfigUtil()

export { util as ConfigUtil }