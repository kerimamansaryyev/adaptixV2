import 'package:adaptix/src/exceptions/device_detection.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:flutter_test/flutter_test.dart';

// It's okay to ignore the lints on test
// ignore: long-method
void main() {
  const sampleBreakpoints = CanonicalResponsiveBreakpoint.values;
  group('Breakpoint tests', () {
    test('Throws exception if list is empty', () {
      expect(
        () => <ResponsiveBreakpoint>[].detectBreakpoint(120),
        throwsA(isA<ResponsiveBreakpointsListEmptyException>()),
      );
    });
    test(
        'value <= ${CanonicalResponsiveBreakpoint.xSmall.debugLabel}  => ${CanonicalResponsiveBreakpoint.xSmall.debugLabel}',
        () {
      final smaller =
          CanonicalResponsiveBreakpoint.xSmall.templateDeviceWidth - 1;
      final equal = CanonicalResponsiveBreakpoint.xSmall.templateDeviceWidth;
      expect(
        sampleBreakpoints.detectBreakpoint(smaller),
        CanonicalResponsiveBreakpoint.xSmall,
      );
      expect(
        sampleBreakpoints.detectBreakpoint(equal),
        CanonicalResponsiveBreakpoint.xSmall,
      );
    });
    test(
        'value >= ${CanonicalResponsiveBreakpoint.small.debugLabel} && value < ${CanonicalResponsiveBreakpoint.medium.debugLabel}  => ${CanonicalResponsiveBreakpoint.small.debugLabel}',
        () {
      final smaller =
          CanonicalResponsiveBreakpoint.small.templateDeviceWidth - 1;
      final equal = CanonicalResponsiveBreakpoint.small.templateDeviceWidth;
      expect(
        sampleBreakpoints.detectBreakpoint(smaller),
        CanonicalResponsiveBreakpoint.xSmall,
      );
      expect(
        sampleBreakpoints.detectBreakpoint(equal),
        CanonicalResponsiveBreakpoint.small,
      );
    });
    test(
        'value >= ${CanonicalResponsiveBreakpoint.medium.debugLabel} && value < ${CanonicalResponsiveBreakpoint.fablet.debugLabel}  => ${CanonicalResponsiveBreakpoint.medium.debugLabel}',
        () {
      final smaller =
          CanonicalResponsiveBreakpoint.medium.templateDeviceWidth - 1;
      final equal = CanonicalResponsiveBreakpoint.medium.templateDeviceWidth;
      expect(
        sampleBreakpoints.detectBreakpoint(smaller),
        CanonicalResponsiveBreakpoint.small,
      );
      expect(
        sampleBreakpoints.detectBreakpoint(equal),
        CanonicalResponsiveBreakpoint.medium,
      );
    });
    test(
        'value >= ${CanonicalResponsiveBreakpoint.fablet.debugLabel} && value < ${CanonicalResponsiveBreakpoint.tablet.debugLabel}  => ${CanonicalResponsiveBreakpoint.fablet.debugLabel}',
        () {
      final smaller =
          CanonicalResponsiveBreakpoint.fablet.templateDeviceWidth - 1;
      final equal = CanonicalResponsiveBreakpoint.fablet.templateDeviceWidth;
      expect(
        sampleBreakpoints.detectBreakpoint(smaller),
        CanonicalResponsiveBreakpoint.medium,
      );
      expect(
        sampleBreakpoints.detectBreakpoint(equal),
        CanonicalResponsiveBreakpoint.fablet,
      );
    });
    test(
        'value >= ${CanonicalResponsiveBreakpoint.tablet.debugLabel} && value < ${CanonicalResponsiveBreakpoint.desktop.debugLabel}  => ${CanonicalResponsiveBreakpoint.tablet.debugLabel}',
        () {
      final smaller =
          CanonicalResponsiveBreakpoint.tablet.templateDeviceWidth - 1;
      final equal = CanonicalResponsiveBreakpoint.tablet.templateDeviceWidth;
      expect(
        sampleBreakpoints.detectBreakpoint(smaller),
        CanonicalResponsiveBreakpoint.fablet,
      );
      expect(
        sampleBreakpoints.detectBreakpoint(equal),
        CanonicalResponsiveBreakpoint.tablet,
      );
    });
    test(
        'value >= ${CanonicalResponsiveBreakpoint.desktop.debugLabel} => ${CanonicalResponsiveBreakpoint.desktop.debugLabel}',
        () {
      final smaller =
          CanonicalResponsiveBreakpoint.desktop.templateDeviceWidth - 1;
      final equal = CanonicalResponsiveBreakpoint.desktop.templateDeviceWidth;
      expect(
        sampleBreakpoints.detectBreakpoint(smaller),
        CanonicalResponsiveBreakpoint.tablet,
      );
      expect(
        sampleBreakpoints.detectBreakpoint(equal),
        CanonicalResponsiveBreakpoint.desktop,
      );
    });
    test(
        'value > ${CanonicalResponsiveBreakpoint.desktop.debugLabel} => ${CanonicalResponsiveBreakpoint.desktop.debugLabel}',
        () {
      expect(
        sampleBreakpoints.detectBreakpoint(
          CanonicalResponsiveBreakpoint.desktop.templateDeviceWidth + 1,
        ),
        CanonicalResponsiveBreakpoint.desktop,
      );
    });
  });
}
