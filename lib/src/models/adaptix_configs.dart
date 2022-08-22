import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

enum DeviceBreakpointDecisionStrategy { useShortestSide, useOriginalWidth }

@immutable
class AdaptixConfigs with ArgsComparisonMixin {
  final DeviceBreakpointDecisionStrategy strategy;
  final List<ResponsiveBreakpoint> breakpoints;

  const AdaptixConfigs._({required this.strategy, required this.breakpoints});

  factory AdaptixConfigs(
          {DeviceBreakpointDecisionStrategy strategy =
              DeviceBreakpointDecisionStrategy.useOriginalWidth,
          required List<ResponsiveBreakpoint> breakpoints}) =>
      AdaptixConfigs._(
          strategy: strategy,
          breakpoints: breakpoints.iterableRemoveSame().toList());

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConfigs &&
        other.breakpoints.length == breakpoints.length &&
        other.strategy == strategy &&
        const collection.ListEquality().equals(breakpoints, other.breakpoints);
  }
}
