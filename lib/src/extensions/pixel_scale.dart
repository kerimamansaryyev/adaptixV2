import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';

extension PixelScaleExtension on num {
  double adaptedPx(BuildContext context, {double defaultValue = 1}) {
    final adaptix = Adaptix.of(context);
    final genericSwitch = adaptix.configs.pixelScaleSwitch;
    return genericSwitch.getValueAccordingtoBreakpoint(adaptix.breakpoint) *
        this;
  }
}
