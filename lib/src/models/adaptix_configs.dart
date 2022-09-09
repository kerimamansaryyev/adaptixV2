import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

enum DeviceBreakpointDecisionStrategy { useShortestSide, useOriginalWidth }

@immutable
class AdaptixConfigs with ArgsComparisonMixin {
  static const List<CanonicalResponsiveBreakpoint> canonicalBreakpoints =
      CanonicalResponsiveBreakpoint.values;

  final DeviceBreakpointDecisionStrategy strategy;
  final List<ResponsiveBreakpoint> breakpoints;
  final GenericResponsiveSwitch<double> pixelScaleSwitch;
  final double globalPixelScaleFactor;

  factory AdaptixConfigs({
    required List<ResponsiveBreakpoint> breakpoints,
    DeviceBreakpointDecisionStrategy strategy =
        DeviceBreakpointDecisionStrategy.useOriginalWidth,
    List<GenericResponsiveRule<double>> pixelScaleRules = const [],
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
          .sorted((a, b) => a.value.compareTo(b.value))
          .toList(),
    );
  }

  const AdaptixConfigs._({
    required this.strategy,
    required this.breakpoints,
    required this.globalPixelScaleFactor,
    required this.pixelScaleSwitch,
  });

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
