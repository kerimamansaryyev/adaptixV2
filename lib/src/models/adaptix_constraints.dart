import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:flutter/widgets.dart';

@immutable
class AdaptixConstraints with ArgsComparisonMixin {
  final AdaptixConfigs configs;
  final ResponsiveBreakpoint breakpoint;
  final Orientation orientation;

  const AdaptixConstraints(
      {required this.breakpoint,
      required this.orientation,
      required this.configs});

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConstraints &&
        other.breakpoint.isSameAs(breakpoint) &&
        other.configs.isSameAs(configs) &&
        other.orientation == orientation;
  }
}
