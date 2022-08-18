import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/pixel_scale_breakpoint.dart';
import 'package:meta/meta.dart';

extension DetectBreakpointExtension on Iterable<SizeBreakPoint> {
  SizeBreakPoint? detectBreakpoint(double deviceWidth) {
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
    on Iterable<ResponsivePixelScaleBreakPoint> {
  ResponsivePixelScaleBreakPoint? _detectBreakPoint(double deviceWidth) =>
      detectBreakpoint(deviceWidth) as ResponsivePixelScaleBreakPoint?;

  double detectPixelScale(double deviceWidth, [double defaultScale = 1]) =>
      _detectBreakPoint(deviceWidth)?.pixelScale ?? defaultScale;

  @visibleForTesting
  String? detectDeviceTypeByDebugLabel(double deviceWidth) =>
      _detectBreakPoint(deviceWidth)?.debugLabel;
}
