import 'package:adaptix/src/models/generic_switch.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Generic switch equality', () {
    test('Equality of generic switch is managed as default by Dart', () {
      final switch1 = GenericResponsiveSwitch(
        const GenericResponsiveSwitchArgs(
          defaultValue: 1,
          rules: {
            'mobile': 1,
            'desktop': 2,
          },
        ),
      );
      final switch2 = GenericResponsiveSwitch(
        const GenericResponsiveSwitchArgs(
          defaultValue: 1,
          rules: {
            'mobile1': 1,
            'desktop': 2,
          },
        ),
      );
      expect(switch1 != switch2, true);
    });
  });
}
