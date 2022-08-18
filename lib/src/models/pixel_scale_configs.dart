import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/device_detect_mixin.dart';
import 'package:adaptix/src/models/pixel_scale_breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

enum DeviceWidthSideStrategy { useShortestSide, useOriginalWidth }

@immutable
class PixelScaleConfigs
    with
        ArgsComparisonMixin,
        DeviceDetectMixin<ResponsivePixelScaleBreakpoint> {
  @override
  final List<ResponsivePixelScaleBreakpoint> breakpoints;

  final double defaultPixelScale;
  final DeviceWidthSideStrategy deviceWidthSideStrategy;

  const PixelScaleConfigs._(
      {required this.breakpoints,
      required this.defaultPixelScale,
      required this.deviceWidthSideStrategy});

  factory PixelScaleConfigs(
          {required List<ResponsivePixelScaleBreakpoint> breakpoints,
          DeviceWidthSideStrategy deviceWidthSideStrategy =
              DeviceWidthSideStrategy.useOriginalWidth,
          double defaultPixelScale = 1}) =>
      PixelScaleConfigs._(
              deviceWidthSideStrategy: deviceWidthSideStrategy,
              breakpoints: breakpoints,
              defaultPixelScale: defaultPixelScale)
          .sorted();

  static const defaultConfigs = PixelScaleConfigs._(
      breakpoints: [],
      defaultPixelScale: 1,
      deviceWidthSideStrategy: DeviceWidthSideStrategy.useOriginalWidth);

  static const defaultXSmallDevicePixelScale = 1.0;
  static const defaultSmallDevicePixelScale = 1.1;
  static const defaultMediumDevicePixelScale = 1.15;
  static const defaultTabletDevicePixelScale = 1.2;
  static const defaultDesktopDevicePixelScale = 1.25;

  factory PixelScaleConfigs.canonical(
      {double defaultPixelScale = 1,
      double xSmallDevice = defaultXSmallDevicePixelScale,
      double smallDevice = defaultSmallDevicePixelScale,
      double mediumDevice = defaultMediumDevicePixelScale,
      double tabletDevicePixelScale = defaultTabletDevicePixelScale,
      double desktopDevicePixelScale = defaultDesktopDevicePixelScale,
      DeviceWidthSideStrategy deviceWidthSideStrategy =
          DeviceWidthSideStrategy.useOriginalWidth}) {
    return PixelScaleConfigs(
        deviceWidthSideStrategy: deviceWidthSideStrategy,
        breakpoints: [
          ResponsivePixelScaleBreakpoint(
              deviceWidth: AdaptixConfigs.defaultXSmallDeviceWidthBreakpoint,
              pixelScale: xSmallDevice,
              debugLabel: AdaptixConfigs.xSmallDeviceTestDebugLabel),
          ResponsivePixelScaleBreakpoint(
              deviceWidth: AdaptixConfigs.defaultSmallDeviceWidthBreakpoint,
              pixelScale: smallDevice,
              debugLabel: AdaptixConfigs.smallDeviceTestDebugLabel),
          ResponsivePixelScaleBreakpoint(
              deviceWidth: AdaptixConfigs.defaultMediumDeviceWidthBreakpoint,
              pixelScale: mediumDevice,
              debugLabel: AdaptixConfigs.mediumDeviceTestDebugLabel),
          ResponsivePixelScaleBreakpoint(
              deviceWidth: AdaptixConfigs.defaultTabletDeviceWidthBreakpoint,
              pixelScale: tabletDevicePixelScale,
              debugLabel: AdaptixConfigs.tabletDeviceTestDebugLabel),
          ResponsivePixelScaleBreakpoint(
              deviceWidth: AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint,
              pixelScale: desktopDevicePixelScale,
              debugLabel: AdaptixConfigs.desktopDeviceTestDebugLabel)
        ]);
  }

  @override
  PixelScaleConfigs sorted() => PixelScaleConfigs._(
      defaultPixelScale: defaultPixelScale,
      deviceWidthSideStrategy: deviceWidthSideStrategy,
      breakpoints: sortedBreakpoints());

  @override
  bool isSameAs(ArgsComparisonMixin other) =>
      other is PixelScaleConfigs &&
      other.breakpoints.length == breakpoints.length &&
      const collection.ListEquality().equals(other.breakpoints, breakpoints) &&
      other.deviceWidthSideStrategy == deviceWidthSideStrategy;
}
