import { describe, expect, it } from '@ohos/hypium';
import { StringUtils } from '../main/ets/utils/StringUtils';

export default function StringUtilsTest() {
  describe('StringUtilsTest', () => {
    it('should_generate_valid_uuid', 0, () => {
      const uuid = StringUtils.generateUUID();
      expect(uuid.length).assertEqual(36);
      expect(uuid.charAt(8)).assertEqual('-');
      expect(uuid.charAt(13)).assertEqual('-');
      expect(uuid.charAt(14)).assertEqual('4');
      expect(uuid.charAt(18)).assertEqual('-');
      expect(uuid.charAt(23)).assertEqual('-');
    });

    it('each_uuid_should_be_different', 0, () => {
      const uuid1 = StringUtils.generateUUID();
      const uuid2 = StringUtils.generateUUID();
      expect(uuid1 === uuid2).assertFalse();
    });

    it('should_validate_valid_email', 0, () => {
      expect(StringUtils.isEmail('test@example.com')).assertTrue();
      expect(StringUtils.isEmail('user.name@domain.co.uk')).assertTrue();
      expect(StringUtils.isEmail('user_123@test-domain.com')).assertTrue();
    });

    it('should_reject_invalid_email', 0, () => {
      expect(StringUtils.isEmail('invalid-email')).assertFalse();
      expect(StringUtils.isEmail('@example.com')).assertFalse();
      expect(StringUtils.isEmail('test@')).assertFalse();
      expect(StringUtils.isEmail('')).assertFalse();
    });

    it('should_validate_valid_phone', 0, () => {
      expect(StringUtils.isPhone('13812345678')).assertTrue();
      expect(StringUtils.isPhone('15987654321')).assertTrue();
      expect(StringUtils.isPhone('18611112222')).assertTrue();
    });

    it('should_reject_invalid_phone', 0, () => {
      expect(StringUtils.isPhone('12345')).assertFalse();
      expect(StringUtils.isPhone('12812345678')).assertFalse();
      expect(StringUtils.isPhone('')).assertFalse();
    });

    it('should_mask_phone_correctly', 0, () => {
      expect(StringUtils.maskPhone('13812345678')).assertEqual('138****5678');
      expect(StringUtils.maskPhone('15987654321')).assertEqual('159****4321');
    });

    it('invalid_phone_should_return_original', 0, () => {
      expect(StringUtils.maskPhone('123')).assertEqual('123');
      expect(StringUtils.maskPhone('')).assertEqual('');
    });

    it('should_mask_email_correctly', 0, () => {
      expect(StringUtils.maskEmail('test@example.com')).assertEqual('t***@example.com');
      expect(StringUtils.maskEmail('user@domain.com')).assertEqual('u***@domain.com');
    });

    it('invalid_email_should_return_original', 0, () => {
      expect(StringUtils.maskEmail('invalid')).assertEqual('invalid');
      expect(StringUtils.maskEmail('')).assertEqual('');
    });

    it('should_encode_string_to_base64', 0, () => {
      expect(StringUtils.base64Encode('Hello World')).assertEqual('SGVsbG8gV29ybGQ=');
      const encoded = StringUtils.base64Encode('测试');
      expect(encoded.length > 0).assertTrue();
    });

    it('empty_string_should_return_empty_base64', 0, () => {
      expect(StringUtils.base64Encode('')).assertEqual('');
    });

    it('should_decode_base64_string', 0, () => {
      expect(StringUtils.base64Decode('SGVsbG8gV29ybGQ=')).assertEqual('Hello World');
    });

    it('empty_base64_should_return_empty_string', 0, () => {
      expect(StringUtils.base64Decode('')).assertEqual('');
    });

    it('should_detect_empty_string', 0, () => {
      expect(StringUtils.isEmpty('')).assertTrue();
      expect(StringUtils.isEmpty('   ')).assertTrue();
      expect(StringUtils.isEmpty(null)).assertTrue();
      expect(StringUtils.isEmpty(undefined)).assertTrue();
    });

    it('should_detect_non_empty_string', 0, () => {
      expect(StringUtils.isEmpty('hello')).assertFalse();
      expect(StringUtils.isEmpty(' hello ')).assertFalse();
    });

    it('should_detect_non_empty_string_for_isNotEmpty', 0, () => {
      expect(StringUtils.isNotEmpty('hello')).assertTrue();
      expect(StringUtils.isNotEmpty(' hello ')).assertTrue();
    });

    it('should_detect_empty_string_for_isNotEmpty', 0, () => {
      expect(StringUtils.isNotEmpty('')).assertFalse();
      expect(StringUtils.isNotEmpty('   ')).assertFalse();
      expect(StringUtils.isNotEmpty(null)).assertFalse();
    });

    it('should_truncate_string_correctly', 0, () => {
      expect(StringUtils.truncate('这是一段很长的文字', 5)).assertEqual('这是一段很...');
      expect(StringUtils.truncate('short', 10)).assertEqual('short');
    });

    it('empty_string_should_return_original_when_truncate', 0, () => {
      expect(StringUtils.truncate('', 5)).assertEqual('');
    });

    it('should_strip_html_tags', 0, () => {
      expect(StringUtils.stripHtml('<p>Hello</p>')).assertEqual('Hello');
      expect(StringUtils.stripHtml('<div><span>Test</span></div>')).assertEqual('Test');
    });

    it('empty_string_should_return_empty_when_strip_html', 0, () => {
      expect(StringUtils.stripHtml('')).assertEqual('');
    });

    it('should_capitalize_first_letter', 0, () => {
      expect(StringUtils.capitalize('hello')).assertEqual('Hello');
      expect(StringUtils.capitalize('world')).assertEqual('World');
    });

    it('empty_string_should_return_empty_when_capitalize', 0, () => {
      expect(StringUtils.capitalize('')).assertEqual('');
    });
  });
}
