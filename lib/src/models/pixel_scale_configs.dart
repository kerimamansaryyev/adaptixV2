import 'package:adaptix/src/models/pixel_scale_breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

enum DeviceWidthSideStrategy { useShortestSide, useOriginalWidth }

@immutable
class PixelScaleConfigs with ArgsComparisonMixin {
  final List<ResponsivePixelScaleBreakPoint> breakpoints;
  final double defaultPixelScale;
  final DeviceWidthSideStrategy deviceWidthSideStrategy;

  const PixelScaleConfigs._(
      {required this.breakpoints,
      required this.defaultPixelScale,
      required this.deviceWidthSideStrategy});

  factory PixelScaleConfigs(
          {required List<ResponsivePixelScaleBreakPoint> breakpoints,
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

  static const defaultXSmallDeviceWidthBreakpoint = 380.0;
  static const defaultSmallDeviceWidthBreakpoint = 414.0;
  static const defaultMediumDeviceWidthBreakpoint = 600.0;
  static const defaultTabletDeviceWidthBreakpoint = 800.0;
  static const defaultDesktopDeviceWidthBreakpoint = 1100.0;

  factory PixelScaleConfigs.canonical(
      {double defaultPixelScale = 1,
      double xSmallDevice = 1,
      double smallDevice = 1.1,
      double mediumDevice = 1.15,
      double tabletDevicePixelScale = 1.2,
      double desktopDevicePixelScale = 1.25,
      DeviceWidthSideStrategy deviceWidthSideStrategy =
          DeviceWidthSideStrategy.useOriginalWidth}) {
    return PixelScaleConfigs(
        deviceWidthSideStrategy: deviceWidthSideStrategy,
        breakpoints: [
          ResponsivePixelScaleBreakPoint(
              deviceWidth: defaultXSmallDeviceWidthBreakpoint,
              pixelScale: xSmallDevice,
              debugLabel: 'xSmall'),
          ResponsivePixelScaleBreakPoint(
              deviceWidth: defaultSmallDeviceWidthBreakpoint,
              pixelScale: smallDevice,
              debugLabel: 'small'),
          ResponsivePixelScaleBreakPoint(
              deviceWidth: defaultMediumDeviceWidthBreakpoint,
              pixelScale: mediumDevice,
              debugLabel: 'medium'),
          ResponsivePixelScaleBreakPoint(
              deviceWidth: defaultTabletDeviceWidthBreakpoint,
              pixelScale: tabletDevicePixelScale,
              debugLabel: 'tablet'),
          ResponsivePixelScaleBreakPoint(
              deviceWidth: defaultDesktopDeviceWidthBreakpoint,
              pixelScale: desktopDevicePixelScale,
              debugLabel: 'desktop')
        ]);
  }

  PixelScaleConfigs sorted() => PixelScaleConfigs._(
      defaultPixelScale: defaultPixelScale,
      deviceWidthSideStrategy: deviceWidthSideStrategy,
      breakpoints: breakpoints.toSet().toList()
        ..sort((a, b) => b.compareTo(a)));

  @override
  bool isSameAs(ArgsComparisonMixin other) =>
      other is PixelScaleConfigs &&
      other.breakpoints.length == breakpoints.length &&
      const collection.ListEquality().equals(other.breakpoints, breakpoints) &&
      other.deviceWidthSideStrategy == deviceWidthSideStrategy;
}
