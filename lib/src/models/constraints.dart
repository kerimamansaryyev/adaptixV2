import 'package:adaptix/src/models/pixel_scale_configs.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:flutter/widgets.dart';

@immutable
class AdaptixConstraints with ArgsComparisonMixin {
  final PixelScaleConfigs configs;
  final double pixelScale;
  final Orientation orientation;

  const AdaptixConstraints(
      {required this.configs,
      required this.pixelScale,
      required this.orientation});

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConstraints &&
        other.configs.isSameAs(configs) &&
        other.orientation == orientation &&
        other.pixelScale == pixelScale;
  }
}
