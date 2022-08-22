import 'package:adaptix/src/models/generic_switch.dart';
import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';

extension ResponsiveSwitchExtension on BuildContext {
  T responsiveSwitch<T>(GenericResponsiveSwitchArgs<T> arguments) {
    return GenericResponsiveSwitch<T>(arguments)
        .getValueAccordingtoBreakpoint(Adaptix.of(this).breakpoint);
  }
}
