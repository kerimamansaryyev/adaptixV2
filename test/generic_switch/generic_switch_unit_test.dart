import 'package:adaptix/src/models/generic_switch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Generic switch rules equality and filtering', () {
    const rule1 = GenericResponsiveRule('mobile', 1);
    const rule2 = GenericResponsiveRule('mobile', 1);
    const rule3 = GenericResponsiveRule('tablet', 1);

    test('Testing equality of rules', () {
      expect(rule1.isSameAs(rule2), true);
      expect(rule1.isSameAs(rule3), false);
    });
    test('Filtering and removing non-unique rules', () {
      final genericSwitch = GenericResponsiveSwitch(
        const GenericResponsiveSwitchArgs(
          defaultValue: 1,
          rules: [rule1, rule2, rule3],
        ),
      );
      expect(genericSwitch.rulesTest.length, 2);
    });
  });
  group('Generic switch equality', () {
    test('Equality of generic switch is managed as default by Dart', () {
      const rule1 = GenericResponsiveRule('mobile', 1);
      const rule2 = GenericResponsiveRule('mobile', 1);
      final switch1 = GenericResponsiveSwitch(
        const GenericResponsiveSwitchArgs(
          defaultValue: 1,
          rules: [rule1, rule2],
        ),
      );
      final switch2 = GenericResponsiveSwitch(
        const GenericResponsiveSwitchArgs(
          defaultValue: 1,
          rules: [rule1, rule2],
        ),
      );
      expect(switch1 != switch2, true);
    });
  });
}
