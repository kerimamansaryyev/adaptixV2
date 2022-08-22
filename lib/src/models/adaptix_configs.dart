import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

enum DeviceBreakpointDecisionStrategy { useShortestSide, useOriginalWidth }

@immutable
class AdaptixConfigs with ArgsComparisonMixin {
  final DeviceBreakpointDecisionStrategy strategy;
  final List<ResponsiveBreakpoint> breakpoints;
  final GenericResponsiveSwitch<double> pixelScaleSwitch;

  static const List<CanonicalResponsiveBreakpoint> canonicalBreakpoints =
      CanonicalResponsiveBreakpoint.values;

  const AdaptixConfigs._(
      {required this.strategy,
      required this.breakpoints,
      required this.pixelScaleSwitch});

  const AdaptixConfigs.canonical(
      {DeviceBreakpointDecisionStrategy strategy =
          DeviceBreakpointDecisionStrategy.useOriginalWidth})
      : this._(
            strategy: strategy,
            breakpoints: canonicalBreakpoints,
            pixelScaleSwitch: const CanonicPixelResponsiveScaleSwitch());

  factory AdaptixConfigs(
      {DeviceBreakpointDecisionStrategy strategy =
          DeviceBreakpointDecisionStrategy.useOriginalWidth,
      List<GenericResponsiveRule<double>> pixelScaleRules = const [],
      double defaultPixelScale = 1,
      required List<ResponsiveBreakpoint> breakpoints}) {
    assert(breakpoints.isNotEmpty);
    return AdaptixConfigs._(
        strategy: strategy,
        pixelScaleSwitch: GenericResponsiveSwitch<double>(
            defaultValue: defaultPixelScale, rules: pixelScaleRules),
        breakpoints: breakpoints
            .iterableRemoveSame()
            .sorted((a, b) => a.value.compareTo(b.value))
            .toList());
  }

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConfigs &&
        other.breakpoints.length == breakpoints.length &&
        other.strategy == strategy &&
        other.pixelScaleSwitch.isSameAs(pixelScaleSwitch) &&
        const collection.ListEquality().equals(breakpoints, other.breakpoints);
  }
}
