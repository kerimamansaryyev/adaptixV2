import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:collection/collection.dart';

const _listEquality = ListEquality();
// It's okay to ignore the lints on test
// ignore: long-method
void main() {
  test('Testing breakpoint equality', () {
    const breakpoint =
        ResponsiveBreakpoint(templateDeviceWidth: 120, key: 'mobile');
    const same = ResponsiveBreakpoint(templateDeviceWidth: 120, key: 'mobile');
    const valueDiffers =
        ResponsiveBreakpoint(templateDeviceWidth: 121, key: 'mobile');
    const keyDiffers =
        ResponsiveBreakpoint(templateDeviceWidth: 120, key: 'tablet');
    const bothDiffers =
        ResponsiveBreakpoint(templateDeviceWidth: 121, key: 'tablet');
    expect(breakpoint.isSameAs(valueDiffers), false);
    expect(breakpoint.isSameAs(same), true);
    expect(breakpoint.isSameAs(keyDiffers), false);
    expect(breakpoint.isSameAs(bothDiffers), false);
  });

  test('Test transequality between canonical breakpoint and non-canonical', () {
    final nonCanonical = ResponsiveBreakpoint(
      templateDeviceWidth:
          CanonicalResponsiveBreakpoint.small.templateDeviceWidth,
      key: CanonicalResponsiveBreakpoint.small.key,
    );
    expect(nonCanonical.isSameAs(CanonicalResponsiveBreakpoint.small), true);
  });

  test('Must return only unique elements from iterable', () {
    final breakpoints = [
      const ResponsiveBreakpoint(templateDeviceWidth: 120, key: 'mobile'),
      const ResponsiveBreakpoint(templateDeviceWidth: 120, key: 'mobile'),
      const ResponsiveBreakpoint(templateDeviceWidth: 120, key: 'mobile1'),
      const ResponsiveBreakpoint(templateDeviceWidth: 121, key: 'mobile'),
      ResponsiveBreakpoint(
        templateDeviceWidth:
            CanonicalResponsiveBreakpoint.small.templateDeviceWidth,
        key: CanonicalResponsiveBreakpoint.small.key,
      ),
      CanonicalResponsiveBreakpoint.small
    ].iterableRemoveSame();
    expect(breakpoints.length, 3);
  });

  group('Static methods are matching with value objects', () {
    test('Key matches with value object name', () {
      final vObjectKeys = CanonicalResponsiveBreakpoint.values
          .map((element) => element.name)
          .toList();
      expect(
        _listEquality.equals(
          vObjectKeys,
          CanonicalResponsiveBreakpoint.canonicalBreakpointKeys,
        ),
        true,
      );
      expect(
        CanonicalResponsiveBreakpoint.canonicalBreakpointKeys.length,
        vObjectKeys.length,
      );
    });
    test('Keys match with value-object name', () {
      final vObjectKeys = CanonicalResponsiveBreakpoint.values
          .map((element) => element.name)
          .toList();
      expect(
        _listEquality.equals(
          vObjectKeys,
          CanonicalResponsiveBreakpoint.canonicalBreakpointKeys,
        ),
        true,
      );
      expect(
        CanonicalResponsiveBreakpoint.canonicalBreakpointKeys.length,
        vObjectKeys.length,
      );
    });

    test('Pixel scales number matches with number of value objects', () {
      expect(
        CanonicalResponsiveBreakpoint.values.length,
        CanonicalResponsiveBreakpoint.canonicalPixelScales.length,
      );
    });

    test('Rules number matches with number of value objects', () {
      expect(
        CanonicalResponsiveBreakpoint.createCanonicalSwitchArguments(
          defaultValue: 1,
        ).rules.length,
        CanonicalResponsiveBreakpoint.values.length,
      );
    });
  });
}
