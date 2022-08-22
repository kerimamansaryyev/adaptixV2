import 'dart:math';

import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:flutter/widgets.dart';

@immutable
class AdaptixConstraints with ArgsComparisonMixin {
  final AdaptixConfigs configs;
  final ResponsiveBreakpoint breakpoint;
  final Orientation orientation;
  final Size size;

  const AdaptixConstraints(
      {required this.breakpoint,
      required this.orientation,
      required this.size,
      required this.configs});

  double get shortestSide => min(size.width, size.height);
  double get longestSide => max(size.width, size.height);

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConstraints &&
        other.breakpoint.isSameAs(breakpoint) &&
        other.configs.isSameAs(configs) &&
        other.size == size &&
        other.orientation == orientation;
  }
}
