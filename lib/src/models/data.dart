import 'package:adaptix/src/models/configs.dart';
import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

@immutable
class AdaptixConstraints with StraighComparisonMixin {
  @protected
  final AdaptixConfigs configs;
  final ResponsivePixelValueBreakPoint pixelScale;

  const AdaptixConstraints({required this.configs, required this.pixelScale});

  @override
  bool isSameAs(StraighComparisonMixin other) {
    return other is AdaptixConstraints &&
        other.configs.isSameAs(configs) &&
        other.pixelScale.isSameAs(pixelScale);
  }
}
