import 'dart:math';

import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:meta/meta.dart';

@visibleForTesting
enum TestDeviceMock {
  phone(TestDeviceModeMock.phonePortrait, TestDeviceModeMock.phoneLandscape),
  tablet(TestDeviceModeMock.tabletPortrait, TestDeviceModeMock.tabletLandscape),
  desktop(
    TestDeviceModeMock.desktopPortrait,
    TestDeviceModeMock.desktopLandscape,
  );

  final TestDeviceModeMock portrait;
  final TestDeviceModeMock landscape;

  double get biggestSide => max(portrait.breakpoint, landscape.breakpoint);
  double get smallestSide => min(portrait.breakpoint, landscape.breakpoint);

  const TestDeviceMock(this.portrait, this.landscape);
}

@visibleForTesting
enum TestDeviceModeMock {
  phonePortrait(breakpoint: 650, breakpointPixelScale: 1),
  tabletPortrait(breakpoint: 950, breakpointPixelScale: 1.1),
  tabletLandscape(breakpoint: 1100, breakpointPixelScale: 1.15),
  phoneLandscape(breakpoint: 1200, breakpointPixelScale: 1.2),
  desktopPortrait(breakpoint: 1000, breakpointPixelScale: 1.12),
  desktopLandscape(breakpoint: 1300, breakpointPixelScale: 1.5);

  final double breakpoint;
  final double breakpointPixelScale;

  static List<ResponsiveBreakpoint> get breakpoints => [
        for (var value in values)
          ResponsiveBreakpoint(value: value.breakpoint, key: value.name)
      ];

  static List<GenericResponsiveRule<double>> get pixelScaleRules => [
        for (var value in values)
          GenericResponsiveRule(value.name, value.breakpointPixelScale)
      ];

  const TestDeviceModeMock({
    required this.breakpoint,
    required this.breakpointPixelScale,
  });
}
