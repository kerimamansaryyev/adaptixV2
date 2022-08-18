import 'package:adaptix/src/extensions/detect_breakpoint_extension.dart';
import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/device_detect_mixin.dart';
import 'package:flutter_test/flutter_test.dart';

extension _PixelScaleBreakpointTest on Iterable<TestBreakpoint> {
  String? deviceDebugLabel(double deviceWidth) =>
      (detectBreakpoint(deviceWidth) as TestBreakpoint?)?.debugLabel;
}

class TestBreakpoint extends SizeBreakpoint {
  final double deviceWidth;

  const TestBreakpoint({required this.deviceWidth, required super.debugLabel});

  @override
  double get compareValue => deviceWidth;

  @override
  int getHashCode() => deviceWidth.hashCode;

  @override
  get returnValue => throw UnimplementedError();
}

class TestDeviceDetectConfigs with DeviceDetectMixin<TestBreakpoint> {
  @override
  final List<TestBreakpoint> breakpoints;

  TestDeviceDetectConfigs._({required this.breakpoints});

  factory TestDeviceDetectConfigs(
          {required List<TestBreakpoint> breakpoints}) =>
      TestDeviceDetectConfigs._(breakpoints: breakpoints).sorted();

  factory TestDeviceDetectConfigs.canonical() {
    return TestDeviceDetectConfigs(breakpoints: const [
      TestBreakpoint(
          deviceWidth: AdaptixConfigs.defaultXSmallDeviceWidthBreakpoint,
          debugLabel: AdaptixConfigs.xSmallDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: AdaptixConfigs.defaultSmallDeviceWidthBreakpoint,
          debugLabel: AdaptixConfigs.smallDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: AdaptixConfigs.defaultMediumDeviceWidthBreakpoint,
          debugLabel: AdaptixConfigs.mediumDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: AdaptixConfigs.defaultTabletDeviceWidthBreakpoint,
          debugLabel: AdaptixConfigs.tabletDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint,
          debugLabel: AdaptixConfigs.desktopDeviceTestDebugLabel)
    ]);
  }

  @override
  TestDeviceDetectConfigs sorted() =>
      TestDeviceDetectConfigs._(breakpoints: sortedBreakpoints());
}

void main() {
  group(
      'Must return breakpoint label according to given device width (parameters are not at an edge)',
      () {
    final configs = TestDeviceDetectConfigs.canonical();
    const xSmallWidth = 360.0;
    const xSmallWidth2 = 400.0;
    const smallWidth = 420.0;
    const mediumWidth = 620.0;
    const tabletWidth = 820.0;
    const desktopWidth = 1300.0;
    test(
        '$xSmallWidth < ${AdaptixConfigs.defaultXSmallDeviceWidthBreakpoint} = ${AdaptixConfigs.xSmallDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(xSmallWidth),
          AdaptixConfigs.xSmallDeviceTestDebugLabel);
    });

    test(
        '$xSmallWidth2 < ${AdaptixConfigs.defaultSmallDeviceWidthBreakpoint} = ${AdaptixConfigs.xSmallDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(xSmallWidth2),
          AdaptixConfigs.xSmallDeviceTestDebugLabel);
    });

    test(
        '$smallWidth < ${AdaptixConfigs.defaultMediumDeviceWidthBreakpoint} = ${AdaptixConfigs.smallDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(smallWidth),
          AdaptixConfigs.smallDeviceTestDebugLabel);
    });

    test(
        '$mediumWidth < ${AdaptixConfigs.defaultTabletDeviceWidthBreakpoint} = ${AdaptixConfigs.mediumDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(mediumWidth),
          AdaptixConfigs.mediumDeviceTestDebugLabel);
    });

    test(
        '$tabletWidth < ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = ${AdaptixConfigs.tabletDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(tabletWidth),
          AdaptixConfigs.tabletDeviceTestDebugLabel);
    });

    test(
        '$desktopWidth >= ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = ${AdaptixConfigs.desktopDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(desktopWidth),
          AdaptixConfigs.desktopDeviceTestDebugLabel);
    });
  });

  group(
      'Detecting device width with non-canonical (custom) configs + close values',
      () {
    final configs = TestDeviceDetectConfigs(breakpoints: const [
      TestBreakpoint(
          deviceWidth: 200,
          debugLabel: AdaptixConfigs.xSmallDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: 201,
          debugLabel: AdaptixConfigs.smallDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: 202,
          debugLabel: AdaptixConfigs.mediumDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: 203,
          debugLabel: AdaptixConfigs.tabletDeviceTestDebugLabel),
      TestBreakpoint(
          deviceWidth: 204,
          debugLabel: AdaptixConfigs.desktopDeviceTestDebugLabel)
    ]);

    const xSmallWidth = 199.0;
    const xSmallWidth2 = 200.0;
    const smallWidth = 201.0;
    const mediumWidth = 202.0;
    const tabletWidth = 203.0;
    const desktopWidth = 204.0;
    test('$xSmallWidth < 200= ${AdaptixConfigs.xSmallDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(xSmallWidth),
          AdaptixConfigs.xSmallDeviceTestDebugLabel);
    });

    test('$xSmallWidth2 < 201 = ${AdaptixConfigs.xSmallDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(xSmallWidth2),
          AdaptixConfigs.xSmallDeviceTestDebugLabel);
    });

    test('$smallWidth < 202 = ${AdaptixConfigs.smallDeviceTestDebugLabel}', () {
      expect(configs.breakpoints.deviceDebugLabel(smallWidth),
          AdaptixConfigs.smallDeviceTestDebugLabel);
    });

    test('$mediumWidth < 203 = ${AdaptixConfigs.mediumDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(mediumWidth),
          AdaptixConfigs.mediumDeviceTestDebugLabel);
    });

    test('$tabletWidth < 204 = ${AdaptixConfigs.tabletDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(tabletWidth),
          AdaptixConfigs.tabletDeviceTestDebugLabel);
    });

    test('$desktopWidth >= 204 = ${AdaptixConfigs.desktopDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(desktopWidth),
          AdaptixConfigs.desktopDeviceTestDebugLabel);
    });
  });

  group(
      'Must not include breakpoint itself while comparing through device breakpoints',
      () {
    final configs = TestDeviceDetectConfigs.canonical();
    const xSmallWidth = AdaptixConfigs.defaultXSmallDeviceWidthBreakpoint;
    const smallWidth = AdaptixConfigs.defaultSmallDeviceWidthBreakpoint;
    const mediumWidth = AdaptixConfigs.defaultMediumDeviceWidthBreakpoint;
    const tabletWidth = AdaptixConfigs.defaultTabletDeviceWidthBreakpoint;
    const desktopWidth = AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint;
    test(
        '$xSmallWidth < ${AdaptixConfigs.defaultSmallDeviceWidthBreakpoint} = ${AdaptixConfigs.xSmallDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(xSmallWidth),
          AdaptixConfigs.xSmallDeviceTestDebugLabel);
    });

    test(
        '$smallWidth < ${AdaptixConfigs.defaultMediumDeviceWidthBreakpoint} = ${AdaptixConfigs.smallDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(smallWidth),
          AdaptixConfigs.smallDeviceTestDebugLabel);
    });

    test(
        '$mediumWidth < ${AdaptixConfigs.defaultTabletDeviceWidthBreakpoint} = ${AdaptixConfigs.mediumDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(mediumWidth),
          AdaptixConfigs.mediumDeviceTestDebugLabel);
    });

    test(
        '$tabletWidth < ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = ${AdaptixConfigs.tabletDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(tabletWidth),
          AdaptixConfigs.tabletDeviceTestDebugLabel);
    });

    test(
        '$desktopWidth >= ${AdaptixConfigs.defaultDesktopDeviceWidthBreakpoint} = ${AdaptixConfigs.desktopDeviceTestDebugLabel}',
        () {
      expect(configs.breakpoints.deviceDebugLabel(desktopWidth),
          AdaptixConfigs.desktopDeviceTestDebugLabel);
    });
  });
}
