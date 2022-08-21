import 'package:adaptix/src/models/generic_switch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Equality and filtering', () {
    const rule1 = GenericResponsiveRule('mobile', 1);
    const rule2 = GenericResponsiveRule('mobile', 1);
    const rule3 = GenericResponsiveRule('tablet', 1);

    test('Testing equality of rules', () {
      expect(rule1.isSameAs(rule2), true);
      expect(rule1.isSameAs(rule3), false);
    });
    test('Filtering and removing non-unique rules', () {
      final genericSwitch = GenericResponsiveSwitch(
          defaultValue: 1, rules: const [rule1, rule2, rule3]);
      expect(genericSwitch.rules.length, 2);
    });
  });
}
