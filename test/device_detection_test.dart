import 'package:adaptix/src/extensions/detect_breakpoint_extension.dart';
import 'package:adaptix/src/models/pixel_scale_configs.dart';
import 'package:adaptix/src/models/pixel_scale_breakpoint.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final configs = PixelScaleConfigs.canonical();
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
        '$xSmallWidth < ${PixelScaleConfigs.defaultXSmallDeviceWidthBreakpoint} = xSmall',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth),
          'xSmall');
    });

    test(
        '$xSmallWidth2 < ${PixelScaleConfigs.defaultSmallDeviceWidthBreakpoint} = xSmall',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth2),
          'xSmall');
    });

    test(
        '$smallWidth < ${PixelScaleConfigs.defaultMediumDeviceWidthBreakpoint} = small',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(smallWidth),
          'small');
    });

    test(
        '$mediumWidth < ${PixelScaleConfigs.defaultTabletDeviceWidthBreakpoint} = medium',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(mediumWidth),
          'medium');
    });

    test(
        '$tabletWidth < ${PixelScaleConfigs.defaultDesktopDeviceWidthBreakpoint} = tablet',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(tabletWidth),
          'tablet');
    });

    test(
        '$desktopWidth >= ${PixelScaleConfigs.defaultDesktopDeviceWidthBreakpoint} = desktop',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(desktopWidth),
          'desktop');
    });
  });

  group('Detecting device width with non-canonical configs + close values', () {
    final configs = PixelScaleConfigs(breakpoints: const [
      ResponsivePixelScaleBreakPoint(
          deviceWidth: 200, pixelScale: 1, debugLabel: 'xSmall'),
      ResponsivePixelScaleBreakPoint(
          deviceWidth: 201, pixelScale: 1.1, debugLabel: 'small'),
      ResponsivePixelScaleBreakPoint(
          deviceWidth: 202, pixelScale: 1.15, debugLabel: 'medium'),
      ResponsivePixelScaleBreakPoint(
          deviceWidth: 203, pixelScale: 1.2, debugLabel: 'tablet'),
      ResponsivePixelScaleBreakPoint(
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
    const xSmallWidth = PixelScaleConfigs.defaultXSmallDeviceWidthBreakpoint;
    const smallWidth = PixelScaleConfigs.defaultSmallDeviceWidthBreakpoint;
    const mediumWidth = PixelScaleConfigs.defaultMediumDeviceWidthBreakpoint;
    const tabletWidth = PixelScaleConfigs.defaultTabletDeviceWidthBreakpoint;
    const desktopWidth = PixelScaleConfigs.defaultDesktopDeviceWidthBreakpoint;
    test(
        '$xSmallWidth < ${PixelScaleConfigs.defaultSmallDeviceWidthBreakpoint} = xSmall',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(xSmallWidth),
          'xSmall');
    });

    test(
        '$smallWidth < ${PixelScaleConfigs.defaultMediumDeviceWidthBreakpoint} = small',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(smallWidth),
          'small');
    });

    test(
        '$mediumWidth < ${PixelScaleConfigs.defaultTabletDeviceWidthBreakpoint} = medium',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(mediumWidth),
          'medium');
    });

    test(
        '$tabletWidth < ${PixelScaleConfigs.defaultDesktopDeviceWidthBreakpoint} = tablet',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(tabletWidth),
          'tablet');
    });

    test(
        '$desktopWidth >= ${PixelScaleConfigs.defaultDesktopDeviceWidthBreakpoint} = desktop',
        () {
      expect(configs.breakpoints.detectDeviceTypeByDebugLabel(desktopWidth),
          'desktop');
    });
  });
}
