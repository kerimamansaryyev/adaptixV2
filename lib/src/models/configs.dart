import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

@immutable
class AdaptixConfigs with StraighComparisonMixin {
  final List<ResponsivePixelValueBreakPoint> breakpoints;

  const AdaptixConfigs({required this.breakpoints});

  AdaptixConfigs sorted() => AdaptixConfigs(
      breakpoints: breakpoints.toSet().toList()
        ..sort((a, b) => b.compareTo(a)));

  @override
  bool isSameAs(StraighComparisonMixin other) =>
      other is AdaptixConfigs &&
      const collection.ListEquality().equals(other.breakpoints, breakpoints);
}
