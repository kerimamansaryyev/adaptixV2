import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:adaptix/src/models/adaptix_constraints.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:adaptix/src/widgets/adaptix_initializer.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

/// The strategies that define what value will be used to detect a current breakpoint of [AdaptixConstraints].
enum DeviceBreakpointDecisionStrategy {
  /// [AdaptixConstraints.breakpoint] will be calculated accordint to the shortest side of the device
  useShortestSide,

  /// [AdaptixConstraints.breakpoint] will be calculated accordint to the device width
  useOriginalWidth
}

/// Configurations that are passed to [AdaptixInitializer]
@immutable
class AdaptixConfigs with ArgsComparisonMixin {
  static const List<CanonicalResponsiveBreakpoint> canonicalBreakpoints =
      CanonicalResponsiveBreakpoint.values;

  /// A strategy that defines what value will be used to detect a current breakpoint of [AdaptixConstraints].
  final DeviceBreakpointDecisionStrategy strategy;

  /// Breakpoints that are used to mark a type of the layout.
  final List<ResponsiveBreakpoint> breakpoints;

  /// A [GenericResponsiveSwitch] that decides what pixel scale to use on a layout change.
  final GenericResponsiveSwitch<double> pixelScaleSwitch;

  ///  [AdaptixConstraints.breakpoint] of a context will be multiplied by this value so you can change pixel scale globally.
  final double globalPixelScaleFactor;

  /// A class for creating custom configuration of a layout constraints.
  /// Arguments:
  /// - [breakpoints] - a list of [ResponsiveBreakpoint], where [ResponsiveBreakpoint.templateDeviceWidth] means a point at what [AdaptixInitializer] decides
  /// changing [Adaptix] constraints according to [strategy]
  /// - [strategy] - see [DeviceBreakpointDecisionStrategy].
  /// - [pixelScaleRules] - A [Map] with [String] key that corresponds to the breakpoint key and [double] value that represents a pixel scale to the breakpoint.
  /// - [defaultPixelScale] - if [pixelScaleSwitch] can not find respective value for [AdaptixConstraints.breakpoint] of a context through its rules, it will use
  /// this value as a pixel scale.
  /// - [globalPixelScaleFactor] - [AdaptixConstraints.breakpoint] of a context will be multiplied by this value so you can change pixel scale globally.
  factory AdaptixConfigs({
    required List<ResponsiveBreakpoint> breakpoints,
    DeviceBreakpointDecisionStrategy strategy =
        DeviceBreakpointDecisionStrategy.useOriginalWidth,
    Map<String, double> pixelScaleRules = const {},
    double defaultPixelScale = 1,
    double globalPixelScaleFactor = 1,
  }) {
    assert(breakpoints.isNotEmpty);
    return AdaptixConfigs._(
      strategy: strategy,
      globalPixelScaleFactor: globalPixelScaleFactor,
      pixelScaleSwitch: GenericResponsiveSwitch<double>(
        GenericResponsiveSwitchArgs(
          defaultValue: defaultPixelScale,
          rules: pixelScaleRules,
        ),
      ),
      breakpoints: breakpoints
          .iterableRemoveSame()
          .sorted(
            (a, b) => a.templateDeviceWidth.compareTo(b.templateDeviceWidth),
          )
          .toList(),
    );
  }

  const AdaptixConfigs._({
    required this.strategy,
    required this.breakpoints,
    required this.globalPixelScaleFactor,
    required this.pixelScaleSwitch,
  });

  /// A constructor that uses the canonical package presets such as
  /// - [CanonicPixelResponsiveScaleSwitch]
  const AdaptixConfigs.canonical({
    DeviceBreakpointDecisionStrategy strategy =
        DeviceBreakpointDecisionStrategy.useOriginalWidth,
    double globalPixelScaleFactor = 1,
  }) : this._(
          globalPixelScaleFactor: globalPixelScaleFactor,
          strategy: strategy,
          breakpoints: canonicalBreakpoints,
          pixelScaleSwitch: const CanonicPixelResponsiveScaleSwitch(),
        );

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConfigs &&
        other.breakpoints.length == breakpoints.length &&
        other.strategy == strategy &&
        other.pixelScaleSwitch.isSameAs(pixelScaleSwitch) &&
        other.globalPixelScaleFactor == globalPixelScaleFactor &&
        const collection.ListEquality().equals(breakpoints, other.breakpoints);
  }
}
