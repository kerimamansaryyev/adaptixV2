import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';
import 'package:collection/collection.dart' as collection;

@immutable
class AdaptixConfigs with StraighComparisonMixin {
  final List<ResponsivePixelValueBreakPoint> breakpoints;
  final double defaultPixelScale;

  const AdaptixConfigs({required this.breakpoints, this.defaultPixelScale = 1});

  static const defaultConfigs =
      AdaptixConfigs(breakpoints: [], defaultPixelScale: 1);

  factory AdaptixConfigs.canonical(
      {double defaultPixelScale = 1,
      double xSmallMobileDevicePixelScale = 1,
      double smallMobileDevicePixelScale = 1.1,
      double mobileDevicePixelScale = 1.15,
      double taletDevicePixelScale = 1.2,
      double deskTopDevicePixelScale = 1.25}) {
    return AdaptixConfigs(breakpoints: [
      ResponsivePixelValueBreakPoint(
          deviceWidth: 380, pixelScale: xSmallMobileDevicePixelScale),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 414, pixelScale: smallMobileDevicePixelScale),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 600, pixelScale: mobileDevicePixelScale),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 800, pixelScale: taletDevicePixelScale),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 1100, pixelScale: deskTopDevicePixelScale)
    ]);
  }

  AdaptixConfigs sorted() => AdaptixConfigs(
      defaultPixelScale: defaultPixelScale,
      breakpoints: breakpoints.toSet().toList()
        ..sort((a, b) => b.compareTo(a)));

  @override
  bool isSameAs(StraighComparisonMixin other) =>
      other is AdaptixConfigs &&
      const collection.ListEquality().equals(other.breakpoints, breakpoints);
}
