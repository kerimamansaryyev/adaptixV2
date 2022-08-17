import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:meta/meta.dart';

extension DetectBreakpointExtension on List<ResponsivePixelValueBreakPoint> {
  ResponsivePixelValueBreakPoint? _detectBreakpoint(double deviceWidth) {
    if (isEmpty) {
      return null;
    } else if (deviceWidth < first.deviceWidth) {
      return first;
    }

    for (int i = 1; i < length; i++) {
      if (deviceWidth < elementAt(i).deviceWidth) {
        return elementAt(i - 1);
      }
    }

    return last;
  }

  double detectPixelScale(double deviceWidth, [double defaultScale = 1]) =>
      _detectBreakpoint(deviceWidth)?.pixelScale ?? defaultScale;

  @visibleForTesting
  String? detectDeviceTypeByDebugLabel(double deviceWidth) =>
      _detectBreakpoint(deviceWidth)?.debugLabel;
}
