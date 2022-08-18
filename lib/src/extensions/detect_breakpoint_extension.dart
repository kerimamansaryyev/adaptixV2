import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/pixel_scale_breakpoint.dart';

extension DetectBreakpointExtension on Iterable<SizeBreakpoint> {
  SizeBreakpoint? detectBreakpoint(double deviceWidth) {
    if (isEmpty) {
      return null;
    } else if (deviceWidth < first.compareValue) {
      return first;
    }

    for (int i = 1; i < length; i++) {
      if (deviceWidth < elementAt(i).compareValue) {
        return elementAt(i - 1);
      }
    }

    return last;
  }
}

extension DetectBreakpointPixelScaleExtension
    on Iterable<ResponsivePixelScaleBreakpoint> {
  ResponsivePixelScaleBreakpoint? _detectBreakpoint(double deviceWidth) =>
      detectBreakpoint(deviceWidth) as ResponsivePixelScaleBreakpoint?;

  double detectPixelScale(double deviceWidth, [double defaultScale = 1]) =>
      _detectBreakpoint(deviceWidth)?.pixelScale ?? defaultScale;
}
