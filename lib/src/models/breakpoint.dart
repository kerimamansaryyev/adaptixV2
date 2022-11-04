import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

/// Canonical preset that includes 4 device types.
///
/// Usually, the [values] are used inside of [AdaptixConfigs.canonical].
enum CanonicalResponsiveBreakpoint implements ResponsiveBreakpoint {
  xSmall(
    templateDeviceWidth: 280,
    key: xSmallKey,
    pixelScale: xSmallPixelScale,
  ),
  small(
    templateDeviceWidth: 320,
    key: smallKey,
    pixelScale: smallPixelScale,
  ),
  medium(
    templateDeviceWidth: 414,
    key: mediumKey,
    pixelScale: mediumPixelScale,
  ),
  fablet(
    templateDeviceWidth: 590,
    key: fabletKey,
    pixelScale: fabletPixelScale,
  ),
  tablet(
    templateDeviceWidth: 680,
    key: tabletKey,
    pixelScale: tabletPixelScale,
  ),
  desktop(
    templateDeviceWidth: 1020,
    key: desktopKey,
    pixelScale: desktopPixelScale,
  );

  static const xSmallKey = 'xSmall';
  static const smallKey = 'small';
  static const mediumKey = 'medium';
  static const fabletKey = 'fablet';
  static const tabletKey = 'tablet';
  static const desktopKey = 'desktop';

  static const xSmallPixelScale = 1.0;
  static const smallPixelScale = 1.1;
  static const mediumPixelScale = 1.15;
  static const fabletPixelScale = 1.17;
  static const tabletPixelScale = 1.2;
  static const desktopPixelScale = 1.25;

  static GenericResponsiveSwitchArgs<T> createCanonicalSwitchArguments<T>({
    required T defaultValue,
    T? xSmall,
    T? small,
    T? medium,
    T? fablet,
    T? tablet,
    T? desktop,
  }) {
    return GenericResponsiveSwitchArgs<T>(
      defaultValue: defaultValue,
      rules: {
        xSmallKey: xSmall ?? defaultValue,
        smallKey: small ?? defaultValue,
        mediumKey: medium ?? defaultValue,
        fabletKey: fablet ?? defaultValue,
        tabletKey: tablet ?? defaultValue,
        desktopKey: desktop ?? defaultValue,
      },
    );
  }

  static const canonicalPixelScaleRules = {
    xSmallKey: xSmallPixelScale,
    smallKey: smallPixelScale,
    mediumKey: mediumPixelScale,
    fabletKey: fabletPixelScale,
    tabletKey: tabletPixelScale,
    desktopKey: desktopPixelScale,
  };

  @visibleForTesting
  static const canonicalBreakpointKeys = [
    xSmallKey,
    smallKey,
    mediumKey,
    fabletKey,
    tabletKey,
    desktopKey
  ];

  @visibleForTesting
  static const canonicalPixelScales = [
    xSmallPixelScale,
    smallPixelScale,
    mediumPixelScale,
    fabletPixelScale,
    tabletPixelScale,
    desktopPixelScale,
  ];

  @override
  final double templateDeviceWidth;
  @override
  final String key;
  final double pixelScale;

  const CanonicalResponsiveBreakpoint({
    required this.templateDeviceWidth,
    required this.key,
    required this.pixelScale,
  });

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is ResponsiveBreakpoint &&
        other.templateDeviceWidth == templateDeviceWidth &&
        other.key == key;
  }

  @override
  bool hasSameValueAs(ResponsiveBreakpoint other) =>
      other.templateDeviceWidth == templateDeviceWidth;

  @override
  String get debugLabel => name;
}

/// A class that is used to declare layout types based on [templateDeviceWidth] and identified by [key].
@immutable
class ResponsiveBreakpoint with ArgsComparisonMixin {
  final double templateDeviceWidth;
  final String? debugLabel;
  final String key;

  const ResponsiveBreakpoint({
    required this.templateDeviceWidth,
    required this.key,
    this.debugLabel,
  });

  @override
  int get hashCode =>
      Object.hashAll([templateDeviceWidth.hashCode, key.hashCode]);

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is ResponsiveBreakpoint &&
        other.templateDeviceWidth == templateDeviceWidth &&
        other.key == key;
  }

  @override
  bool operator ==(other) =>
      other is ResponsiveBreakpoint && hashCode == other.hashCode;

  bool hasSameValueAs(ResponsiveBreakpoint other) =>
      other.templateDeviceWidth == templateDeviceWidth;
}
