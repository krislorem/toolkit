import { describe, expect, it } from '@ohos/hypium';
import { DeviceInfo } from '../main/ets/utils/DeviceInfo';

export default function DeviceInfoTest() {
  describe('DeviceInfoTest', () => {
    it('should_return_non_empty_device_model', 0, () => {
      const model = DeviceInfo.getModel();
      expect(model !== null).assertTrue();
      expect(model.length > 0).assertTrue();
    });

    it('should_return_non_empty_os_version', 0, () => {
      const osVersion = DeviceInfo.getOSVersion();
      expect(osVersion !== null).assertTrue();
      expect(osVersion.length > 0).assertTrue();
    });

    it('should_return_non_empty_device_brand', 0, () => {
      const brand = DeviceInfo.getBrand();
      expect(brand !== null).assertTrue();
      expect(brand.length > 0).assertTrue();
    });

    it('should_return_non_empty_device_type', 0, () => {
      const deviceType = DeviceInfo.getDeviceType();
      expect(deviceType !== null).assertTrue();
      expect(deviceType.length > 0).assertTrue();
    });

    it('should_return_sdk_version_greater_than_zero', 0, () => {
      const sdkVersion = DeviceInfo.getSDKVersion();
      expect(sdkVersion > 0).assertTrue();
    });

    it('sdk_version_should_be_in_reasonable_range', 0, () => {
      const sdkVersion = DeviceInfo.getSDKVersion();
      // HarmonyOS Next SDK version should >= 12
      expect(sdkVersion >= 12).assertTrue();
    });

    it('should_return_non_empty_device_id', 0, () => {
      const deviceId = DeviceInfo.getDeviceId();
      expect(deviceId !== null).assertTrue();
      expect(deviceId.length > 0).assertTrue();
    });

    it('multiple_calls_should_return_same_device_id', 0, () => {
      const deviceId1 = DeviceInfo.getDeviceId();
      const deviceId2 = DeviceInfo.getDeviceId();
      expect(deviceId1).assertEqual(deviceId2);
    });

    it('should_return_complete_device_info_with_all_fields', 0, () => {
      const fullInfo = DeviceInfo.getFullInfo();
      expect(fullInfo !== null).assertTrue();
      expect(fullInfo.model !== null).assertTrue();
      expect(fullInfo.osVersion !== null).assertTrue();
      expect(fullInfo.brand !== null).assertTrue();
      expect(fullInfo.deviceType !== null).assertTrue();
      expect(fullInfo.sdkVersion > 0).assertTrue();
      expect(fullInfo.deviceId !== null).assertTrue();
    });

    it('returned_object_should_contain_seven_required_fields', 0, () => {
      const fullInfo = DeviceInfo.getFullInfo();
      const keys = Object.keys(fullInfo);
      expect(keys.length).assertEqual(7);
      expect(keys.includes('model')).assertTrue();
      expect(keys.includes('osVersion')).assertTrue();
      expect(keys.includes('brand')).assertTrue();
      expect(keys.includes('manufacturer')).assertTrue();
      expect(keys.includes('deviceType')).assertTrue();
      expect(keys.includes('sdkVersion')).assertTrue();
      expect(keys.includes('deviceId')).assertTrue();
    });

    it('each_field_value_should_match_individual_method_return_values', 0, () => {
      const fullInfo = DeviceInfo.getFullInfo();
      expect(fullInfo.model).assertEqual(DeviceInfo.getModel());
      expect(fullInfo.osVersion).assertEqual(DeviceInfo.getOSVersion());
      expect(fullInfo.brand).assertEqual(DeviceInfo.getBrand());
      expect(fullInfo.manufacturer).assertEqual(DeviceInfo.getManufacturer());
      expect(fullInfo.deviceType).assertEqual(DeviceInfo.getDeviceType());
      expect(fullInfo.sdkVersion).assertEqual(DeviceInfo.getSDKVersion());
      expect(fullInfo.deviceId).assertEqual(DeviceInfo.getDeviceId());
    });
  });
}
