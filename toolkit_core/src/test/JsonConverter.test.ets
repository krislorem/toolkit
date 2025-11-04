import { describe, expect, it } from '@ohos/hypium';
import { JsonConverter } from '../main/ets/utils/JsonConverter';

// 定义测试用接口
interface TestUser {
  name: string;
  age: number;
}

interface Profile {
  age: number;
}

interface TestObject {
  name: string;
  hobbies: string[];
  profile: Profile;
}

interface CircularObj {
  name: string;
  self?: CircularObj;
}

interface DefaultType {
  error: boolean;
  name?: string;
}


export default function JsonConverterTest() {
  describe('JsonConverterTest', () => {
    it('should_convert_object_to_json_string_correctly', 0, () => {
      const obj: TestUser = { name: '张三', age: 25 };
      const json = JsonConverter.toJson(obj);
      expect(json).assertEqual('{"name":"张三","age":25}');
    });

    it('should_support_formatted_output', 0, () => {
      const obj: TestUser = { name: '张三', age: 25 };
      const json = JsonConverter.toJson(obj, true);
      expect(json.includes('\n')).assertTrue();
      expect(json.includes('  ')).assertTrue();
    });

    it('null_should_return_empty_string', 0, () => {
      expect(JsonConverter.toJson(null)).assertEqual('');
      expect(JsonConverter.toJson(undefined)).assertEqual('');
    });

    it('should_convert_json_string_to_object_correctly', 0, () => {
      const jsonStr = '{"name":"张三","age":25}';
      const user = JsonConverter.fromJson<TestUser>(jsonStr);
      if (user !== null) {
        expect(user.name).assertEqual('张三');
        expect(user.age).assertEqual(25);
      } else {
        expect(false).assertTrue(); // 强制失败
      }
    });

    it('invalid_json_should_return_null', 0, () => {
      const result = JsonConverter.fromJson<TestUser>('invalid json');
      expect(result).assertNull();
    });

    it('empty_string_should_return_null', 0, () => {
      const result = JsonConverter.fromJson<TestUser>('');
      expect(result).assertNull();
    });

    it('should_parse_json_correctly', 0, () => {
      const jsonStr = '{"name":"张三"}';
      const defaultVal: DefaultType = { error: true };
      const result = JsonConverter.safeJsonParse<DefaultType>(jsonStr, defaultVal);
      expect(result.name).assertEqual('张三');
    });

    it('should_return_default_value_when_parsing_fails', 0, () => {
      const defaultValue: DefaultType = { error: true };
      const result = JsonConverter.safeJsonParse<DefaultType>('invalid json', defaultValue);
      expect(result).assertEqual(defaultValue);
      expect(result.error).assertTrue();
    });

    it('should_deep_clone_object_correctly', 0, () => {
      const original: TestObject = {
        name: '张三',
        hobbies: ['阅读', '运动'],
        profile: { age: 25 } as Profile
      };


      const cloned = JsonConverter.deepClone<TestObject>(original);

      if (cloned !== null) {
        expect(cloned.name).assertEqual(original.name);

        // 修改克隆对象不应影响原对象
        cloned.hobbies.push('旅行');
        expect(original.hobbies.length).assertEqual(2);
        expect(cloned.hobbies.length).assertEqual(3);
      } else {
        expect(false).assertTrue(); // 强制失败
      }
    });

    it('object_with_circular_reference_should_return_null', 0, () => {
      const obj: CircularObj = { name: '张三' };
      obj.self = obj; // 循环引用

      const result = JsonConverter.deepClone<CircularObj>(obj);
      expect(result).assertNull();
    });

    it('should_validate_valid_json', 0, () => {
      expect(JsonConverter.isValidJson('{"name":"张三"}')).assertTrue();
      expect(JsonConverter.isValidJson('[]')).assertTrue();
      expect(JsonConverter.isValidJson('"string"')).assertTrue();
      expect(JsonConverter.isValidJson('123')).assertTrue();
    });

    it('should_reject_invalid_json', 0, () => {
      expect(JsonConverter.isValidJson('invalid')).assertFalse();
      expect(JsonConverter.isValidJson('{name: "张三"}')).assertFalse(); // 缺少引号
      expect(JsonConverter.isValidJson('')).assertFalse();
    });
  });
}
