import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';

extension PixelScaleExtension on num {
  /// Returns a pixel scale according to the current breakpoint of [Adaptix] of [context]
  /// multiplied by this num
  double adaptedPx(BuildContext context) =>
      this * Adaptix.of(context).pixelScale;
}
