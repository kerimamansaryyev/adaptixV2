import 'package:adaptix/src/models/pixel_breakpoint.dart';

extension DetectBreakpointExtension
    on Iterable<ResponsivePixelValueBreakPoint> {
  double detectPixelScale(double deviceWidth, [double? defaultScale]) {
    for (var breakpoint in this) {
      if (deviceWidth <= breakpoint.deviceWidth) {
        return breakpoint.pixelScale;
      }
    }
    return defaultScale ?? 1;
  }
}
