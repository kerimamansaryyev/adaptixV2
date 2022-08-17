import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

enum DeviceWidthSideStrategy { useShortestSide, useOriginalWidth }

@immutable
class AdaptixConfigs with ArgsComparisonMixin {
  final List<ResponsivePixelValueBreakPoint> breakpoints;
  final double defaultPixelScale;
  final DeviceWidthSideStrategy deviceWidthSideStrategy;

  const AdaptixConfigs._(
      {required this.breakpoints,
      required this.defaultPixelScale,
      required this.deviceWidthSideStrategy});

  factory AdaptixConfigs(
          {required List<ResponsivePixelValueBreakPoint> breakpoints,
          DeviceWidthSideStrategy deviceWidthSideStrategy =
              DeviceWidthSideStrategy.useOriginalWidth,
          double defaultPixelScale = 1}) =>
      AdaptixConfigs._(
              deviceWidthSideStrategy: deviceWidthSideStrategy,
              breakpoints: breakpoints,
              defaultPixelScale: defaultPixelScale)
          .sorted();

  static const defaultConfigs = AdaptixConfigs._(
      breakpoints: [],
      defaultPixelScale: 1,
      deviceWidthSideStrategy: DeviceWidthSideStrategy.useOriginalWidth);

  static const defaultXSmallDeviceWidthBreakpoint = 380.0;
  static const defaultSmallDeviceWidthBreakpoint = 414.0;
  static const defaultMediumDeviceWidthBreakpoint = 600.0;
  static const defaultTabletDeviceWidthBreakpoint = 800.0;
  static const defaultDesktopDeviceWidthBreakpoint = 1100.0;

  factory AdaptixConfigs.canonical(
      {double defaultPixelScale = 1,
      double xSmallDevice = 1,
      double smallDevice = 1.1,
      double mediumDevice = 1.15,
      double tabletDevicePixelScale = 1.2,
      double desktopDevicePixelScale = 1.25,
      DeviceWidthSideStrategy deviceWidthSideStrategy =
          DeviceWidthSideStrategy.useOriginalWidth}) {
    return AdaptixConfigs(
        deviceWidthSideStrategy: deviceWidthSideStrategy,
        breakpoints: [
          ResponsivePixelValueBreakPoint(
              deviceWidth: defaultXSmallDeviceWidthBreakpoint,
              pixelScale: xSmallDevice,
              debugLabel: 'xSmall'),
          ResponsivePixelValueBreakPoint(
              deviceWidth: defaultSmallDeviceWidthBreakpoint,
              pixelScale: smallDevice,
              debugLabel: 'small'),
          ResponsivePixelValueBreakPoint(
              deviceWidth: defaultMediumDeviceWidthBreakpoint,
              pixelScale: mediumDevice,
              debugLabel: 'medium'),
          ResponsivePixelValueBreakPoint(
              deviceWidth: defaultTabletDeviceWidthBreakpoint,
              pixelScale: tabletDevicePixelScale,
              debugLabel: 'tablet'),
          ResponsivePixelValueBreakPoint(
              deviceWidth: defaultDesktopDeviceWidthBreakpoint,
              pixelScale: desktopDevicePixelScale,
              debugLabel: 'desktop')
        ]);
  }

  AdaptixConfigs sorted() => AdaptixConfigs._(
      defaultPixelScale: defaultPixelScale,
      deviceWidthSideStrategy: deviceWidthSideStrategy,
      breakpoints: breakpoints.toSet().toList()
        ..sort((a, b) => b.compareTo(a)));

  @override
  bool isSameAs(ArgsComparisonMixin other) =>
      other is AdaptixConfigs &&
      other.breakpoints.length == breakpoints.length &&
      const collection.ListEquality().equals(other.breakpoints, breakpoints) &&
      other.deviceWidthSideStrategy == deviceWidthSideStrategy;
}
