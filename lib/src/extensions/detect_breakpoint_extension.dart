import 'package:adaptix/src/models/pixel_breakpoint.dart';

extension DetectBreakpointExtension
    on Iterable<ResponsivePixelValueBreakPoint> {
  double detectPixelScale(double deviceWidth, [double defaultScale = 1]) {
    if (isEmpty) {
      return defaultScale;
    } else if (deviceWidth <= first.deviceWidth) {
      return first.pixelScale;
    }

    for (int i = 1; i < length - 1; i++) {
      if (deviceWidth < elementAt(i).deviceWidth) {
        return elementAt(i).pixelScale;
      }
    }

    return last.pixelScale;
  }
}
