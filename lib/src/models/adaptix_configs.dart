import 'package:adaptix/src/models/pixel_scale_configs.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

@immutable
class AdaptixConfigs with ArgsComparisonMixin {
  final PixelScaleConfigs pixelScaleConfigs;

  const AdaptixConfigs({required this.pixelScaleConfigs});

  static const defaultXSmallDeviceWidthBreakpoint = 380.0;
  static const defaultSmallDeviceWidthBreakpoint = 414.0;
  static const defaultMediumDeviceWidthBreakpoint = 600.0;
  static const defaultTabletDeviceWidthBreakpoint = 800.0;
  static const defaultDesktopDeviceWidthBreakpoint = 1100.0;

  static const xSmallDeviceTestDebugLabel = 'xSmall';
  static const smallDeviceTestDebugLabel = 'small';
  static const mediumDeviceTestDebugLabel = 'medium';
  static const tabletDeviceTestDebugLabel = 'tablet';
  static const desktopDeviceTestDebugLabel = 'desktop';

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixConfigs &&
        pixelScaleConfigs.isSameAs(other.pixelScaleConfigs);
  }
}
