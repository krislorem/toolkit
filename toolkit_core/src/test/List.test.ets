import DateUtilsTest from './DateUtils.test';
import DeviceInfoTest from './DeviceInfo.test';
import JsonConverterTest from './JsonConverter.test';
import MathKitTest from './MathKit.test';
import StringUtilsTest from './StringUtils.test';

export default function testsuite() {
  DateUtilsTest();
  StringUtilsTest();
  MathKitTest();
  DeviceInfoTest();
  JsonConverterTest();
}
