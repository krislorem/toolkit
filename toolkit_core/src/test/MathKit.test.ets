import { describe, expect, it } from '@ohos/hypium';
import { MathKit } from '../main/ets/utils/MathKit';

export default function MathKitTest() {
  describe('MathKitTest', () => {
    it('should_format_number_correctly', 0, () => {
      expect(MathKit.formatNumber(1234567.89)).assertEqual('1,234,567.89');
      expect(MathKit.formatNumber(1000)).assertEqual('1,000');
      expect(MathKit.formatNumber(123)).assertEqual('123');
    });

    it('should_support_custom_decimal_places_for_format_number', 0, () => {
      expect(MathKit.formatNumber(1234.5678, 2)).assertEqual('1,234.57');
      expect(MathKit.formatNumber(1000, 0)).assertEqual('1,000');
    });

    it('should_calculate_percentage_correctly', 0, () => {
      expect(MathKit.percentage(25, 100)).assertEqual(25);
      expect(MathKit.percentage(50, 200)).assertEqual(25);
    });

    it('should_support_custom_decimal_places_for_percentage', 0, () => {
      expect(MathKit.percentage(1, 3, 2)).assertEqual(33.33);
      expect(MathKit.percentage(2, 3, 1)).assertEqual(66.7);
    });

    it('should_return_zero_when_divisor_is_zero_in_percentage', 0, () => {
      expect(MathKit.percentage(10, 0)).assertEqual(0);
    });

    it('should_generate_random_integer_in_range', 0, () => {
      for (let i = 0; i < 100; i++) {
        const num = MathKit.randomInt(1, 10);
        expect(num >= 1).assertTrue();
        expect(num <= 10).assertTrue();
      }
    });

    it('boundary_values_should_be_correct_for_random_int', 0, () => {
      const num = MathKit.randomInt(5, 5);
      expect(num).assertEqual(5);
    });

    it('should_generate_random_float_in_range', 0, () => {
      for (let i = 0; i < 100; i++) {
        const num = MathKit.randomFloat(1.0, 10.0);
        expect(num >= 1.0).assertTrue();
        expect(num <= 10.0).assertTrue();
      }
    });

    it('should_support_specified_decimal_places_for_random_float', 0, () => {
      const num = MathKit.randomFloat(1.0, 10.0, 2);
      const decimalPart = num.toString().split('.')[1];
      if (decimalPart) {
        expect(decimalPart.length <= 2).assertTrue();
      }
    });

    it('should_clamp_value_to_range', 0, () => {
      expect(MathKit.clamp(5, 0, 10)).assertEqual(5);
      expect(MathKit.clamp(-5, 0, 10)).assertEqual(0);
      expect(MathKit.clamp(15, 0, 10)).assertEqual(10);
    });

    it('should_calculate_average_correctly', 0, () => {
      expect(MathKit.average([1, 2, 3, 4, 5])).assertEqual(3);
      expect(MathKit.average([10, 20, 30])).assertEqual(20);
    });

    it('empty_array_should_return_zero_for_average', 0, () => {
      expect(MathKit.average([])).assertEqual(0);
    });

    it('should_calculate_sum_correctly', 0, () => {
      expect(MathKit.sum([1, 2, 3, 4, 5])).assertEqual(15);
      expect(MathKit.sum([10, 20, 30])).assertEqual(60);
    });

    it('empty_array_should_return_zero_for_sum', 0, () => {
      expect(MathKit.sum([])).assertEqual(0);
    });

    it('should_get_maximum_value', 0, () => {
      expect(MathKit.max([1, 5, 3, 9, 2])).assertEqual(9);
      expect(MathKit.max([10, 20, 15])).assertEqual(20);
    });

    it('empty_array_should_return_zero_for_max', 0, () => {
      expect(MathKit.max([])).assertEqual(0);
    });

    it('should_get_minimum_value', 0, () => {
      expect(MathKit.min([1, 5, 3, 9, 2])).assertEqual(1);
      expect(MathKit.min([10, 20, 15])).assertEqual(10);
    });

    it('empty_array_should_return_zero_for_min', 0, () => {
      expect(MathKit.min([])).assertEqual(0);
    });

    it('should_round_correctly', 0, () => {
      expect(MathKit.round(1.234, 2)).assertEqual(1.23);
      expect(MathKit.round(1.235, 2)).assertEqual(1.24);
      expect(MathKit.round(1.5, 0)).assertEqual(2);
    });

    it('should_ceil_correctly', 0, () => {
      expect(MathKit.ceil(1.234, 2)).assertEqual(1.24);
      expect(MathKit.ceil(1.1, 0)).assertEqual(2);
    });

    it('should_floor_correctly', 0, () => {
      expect(MathKit.floor(1.789, 2)).assertEqual(1.78);
      expect(MathKit.floor(1.9, 0)).assertEqual(1);
    });
  });
}
