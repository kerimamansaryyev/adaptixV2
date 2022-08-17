import 'package:adaptix/src/extensions/detect_breakpoint_extension.dart';
import 'package:adaptix/src/models/configs.dart';
import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final configs = AdaptixConfigs.canonical();
  group(
      'Must return breakpoint label according to given device width (parameters are not at an edge)',
      () {
    const xSmallWidth = 360.0;
    const xSmallWidth2 = 400.0;
    const smallWidth = 420.0;
    const mediumWidth = 620.0;
    const tabletWidth = 820.0;
    const desktopWidth = 1300.0;
    test(
        '$xSmallWidth < ${AdaptixConfigs.defaultXSmallDeviceWidthBreakpoint} = xSmall',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth),
          'xSmall');
    });

    test(
        '$xSmallWidth2 < ${AdaptixConfigs.defaultSmallDeviceWidthBreakpoint} = xSmall',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth2),
          'xSmall');
    });

    test(
        '$smallWidth < ${AdaptixConfigs.defaultMediumDeviceWidthBreakpoint} = small',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(smallWidth),
          'small');
    });

    test(
        '$mediumWidth < ${AdaptixConfigs.defaultTabletDeviceWidthBreakpoint} = medium',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(mediumWidth),
          'medium');
    });

    test(
        '$tabletWidth < ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = tablet',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(tabletWidth),
          'tablet');
    });

    test(
        '$desktopWidth >= ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = desktop',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(desktopWidth),
          'desktop');
    });
  });

  group('Detecting device width with non-canonical configs + close values', () {
    final configs = AdaptixConfigs(breakpoints: const [
      ResponsivePixelValueBreakPoint(
          deviceWidth: 200, pixelScale: 1, debugLabel: 'xSmall'),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 201, pixelScale: 1.1, debugLabel: 'small'),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 202, pixelScale: 1.15, debugLabel: 'medium'),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 203, pixelScale: 1.2, debugLabel: 'tablet'),
      ResponsivePixelValueBreakPoint(
          deviceWidth: 204, pixelScale: 1.25, debugLabel: 'desktop')
    ]);

    const xSmallWidth = 199.0;
    const xSmallWidth2 = 200.0;
    const smallWidth = 201.0;
    const mediumWidth = 202.0;
    const tabletWidth = 203.0;
    const desktopWidth = 204.0;
    test('$xSmallWidth < 200= xSmall', () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth),
          'xSmall');
    });

    test('$xSmallWidth2 < 201 = xSmall', () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth2),
          'xSmall');
    });

    test('$smallWidth < 202 = small', () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(smallWidth),
          'small');
    });

    test('$mediumWidth < 203 = medium', () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(mediumWidth),
          'medium');
    });

    test('$tabletWidth < 204 = tablet', () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(tabletWidth),
          'tablet');
    });

    test('$desktopWidth >= 204 = desktop', () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(desktopWidth),
          'desktop');
    });
  });

  group(
      'Must not include breakpoint itself while comparing through device breakpoints',
      () {
    const xSmallWidth = AdaptixConfigs.defaultXSmallDeviceWidthBreakpoint;
    const smallWidth = AdaptixConfigs.defaultSmallDeviceWidthBreakpoint;
    const mediumWidth = AdaptixConfigs.defaultMediumDeviceWidthBreakpoint;
    const tabletWidth = AdaptixConfigs.defaultTabletDeviceWidthBreakpoint;
    const desktopWidth = AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint;
    test(
        '$xSmallWidth < ${AdaptixConfigs.defaultSmallDeviceWidthBreakpoint} = xSmall',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth),
          'xSmall');
    });

    test(
        '$smallWidth < ${AdaptixConfigs.defaultMediumDeviceWidthBreakpoint} = small',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(smallWidth),
          'small');
    });

    test(
        '$mediumWidth < ${AdaptixConfigs.defaultTabletDeviceWidthBreakpoint} = medium',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(mediumWidth),
          'medium');
    });

    test(
        '$tabletWidth < ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = tablet',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(tabletWidth),
          'tablet');
    });

    test(
        '$desktopWidth >= ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = desktop',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(desktopWidth),
          'desktop');
    });
  });
}
