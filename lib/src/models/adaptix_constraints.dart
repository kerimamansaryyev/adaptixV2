import 'dart:math';

import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';

/// Constraints that are changed on a layout change.
///
/// The constraints of a context can be accessed as [Adaptix.of]
@immutable
class AdaptixConstraints with ArgsComparisonMixin {
  /// User configs
  final AdaptixConfigs configs;

  /// Current calculated breakpoint.
  final ResponsiveBreakpoint breakpoint;

  /// Current calculated orientation
  final Orientation orientation;

  /// Current calculated size.
  final Size size;

  const AdaptixConstraints({
    required this.breakpoint,
    required this.orientation,
    required this.size,
    required this.configs,
  });

  /// Shortest side of the device
  double get shortestSide => min(size.width, size.height);

  /// Longest side of the device
  double get longestSide => max(size.width, size.height);

  double get pixelScale {
    final genericSwitch = configs.pixelScaleSwitch;
    return genericSwitch.getValueAccordingtoBreakpoint(breakpoint) *
        1 *
        configs.globalPixelScaleFactor;
  }

  T responsiveSwitch<T>(GenericResponsiveSwitchArgs<T> arguments) {
    return GenericResponsiveSwitch<T>(arguments)
        .getValueAccordingtoBreakpoint(breakpoint);
  }

  /// Returns an object of type [T] according to [orientation]
  T orientationSwitch<T>({required T onLandscape, required T onPortrait}) {
    switch (orientation) {
      case Orientation.portrait:
        return onPortrait;
      case Orientation.landscape:
        return onLandscape;
    }
  }

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConstraints &&
        other.breakpoint.isSameAs(breakpoint) &&
        other.configs.isSameAs(configs) &&
        other.size == size &&
        other.orientation == orientation;
  }
}
