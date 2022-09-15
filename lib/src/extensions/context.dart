import 'package:adaptix/src/models/adaptix_constraints.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';

extension ResponsiveSwitchExtension on BuildContext {
  /// Uses [GenericResponsiveSwitch.getValueAccordingtoBreakpoint] passing the breakpoints of [Adaptix] from this context.
  T responsiveSwitch<T>(GenericResponsiveSwitchArgs<T> arguments) =>
      Adaptix.of(this).responsiveSwitch(arguments);

  /// Returns an object of type [T] according to [AdaptixConstraints.orientation] of the context
  T orientationSwitch<T>({required T onLandscape, required T onPortrait}) =>
      Adaptix.of(this)
          .orientationSwitch(onLandscape: onLandscape, onPortrait: onPortrait);
}
