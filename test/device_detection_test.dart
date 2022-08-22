import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const sampleBreakpoints = CanonicalResponsiveBreakpoint.values;
  group('Breakpoint tests', () {
    test(
        'value <= ${CanonicalResponsiveBreakpoint.xSmall.debugLabel}  => ${CanonicalResponsiveBreakpoint.xSmall.debugLabel}',
        () {
      final smaller = CanonicalResponsiveBreakpoint.xSmall.value - 1;
      final equal = CanonicalResponsiveBreakpoint.xSmall.value;
      expect(sampleBreakpoints.detectBreakpoint(smaller),
          CanonicalResponsiveBreakpoint.xSmall);
      expect(sampleBreakpoints.detectBreakpoint(equal),
          CanonicalResponsiveBreakpoint.xSmall);
    });
    test(
        'value <= ${CanonicalResponsiveBreakpoint.small.debugLabel} && value > ${CanonicalResponsiveBreakpoint.xSmall.debugLabel}  => ${CanonicalResponsiveBreakpoint.small.debugLabel}',
        () {
      final smaller = CanonicalResponsiveBreakpoint.small.value - 1;
      final equal = CanonicalResponsiveBreakpoint.small.value;
      expect(sampleBreakpoints.detectBreakpoint(smaller),
          CanonicalResponsiveBreakpoint.xSmall);
      expect(sampleBreakpoints.detectBreakpoint(equal),
          CanonicalResponsiveBreakpoint.small);
    });
    test(
        'value <= ${CanonicalResponsiveBreakpoint.medium.debugLabel} && value > ${CanonicalResponsiveBreakpoint.small.debugLabel}  => ${CanonicalResponsiveBreakpoint.medium.debugLabel}',
        () {
      final smaller = CanonicalResponsiveBreakpoint.medium.value - 1;
      final equal = CanonicalResponsiveBreakpoint.medium.value;
      expect(sampleBreakpoints.detectBreakpoint(smaller),
          CanonicalResponsiveBreakpoint.small);
      expect(sampleBreakpoints.detectBreakpoint(equal),
          CanonicalResponsiveBreakpoint.medium);
    });
    test(
        'value <= ${CanonicalResponsiveBreakpoint.tablet.debugLabel} && value > ${CanonicalResponsiveBreakpoint.medium.debugLabel}  => ${CanonicalResponsiveBreakpoint.tablet.debugLabel}',
        () {
      final smaller = CanonicalResponsiveBreakpoint.tablet.value - 1;
      final equal = CanonicalResponsiveBreakpoint.tablet.value;
      expect(sampleBreakpoints.detectBreakpoint(smaller),
          CanonicalResponsiveBreakpoint.medium);
      expect(sampleBreakpoints.detectBreakpoint(equal),
          CanonicalResponsiveBreakpoint.tablet);
    });
    test(
        'value <= ${CanonicalResponsiveBreakpoint.desktop.debugLabel} && value > ${CanonicalResponsiveBreakpoint.tablet.debugLabel}  => ${CanonicalResponsiveBreakpoint.desktop.debugLabel}',
        () {
      final smaller = CanonicalResponsiveBreakpoint.desktop.value - 1;
      final equal = CanonicalResponsiveBreakpoint.desktop.value;
      expect(sampleBreakpoints.detectBreakpoint(smaller),
          CanonicalResponsiveBreakpoint.tablet);
      expect(sampleBreakpoints.detectBreakpoint(equal),
          CanonicalResponsiveBreakpoint.desktop);
    });
    test(
        'value > ${CanonicalResponsiveBreakpoint.desktop.debugLabel} => ${CanonicalResponsiveBreakpoint.desktop.debugLabel}',
        () {
      expect(
          sampleBreakpoints.detectBreakpoint(
              CanonicalResponsiveBreakpoint.desktop.value + 1),
          CanonicalResponsiveBreakpoint.desktop);
    });
  });
}
