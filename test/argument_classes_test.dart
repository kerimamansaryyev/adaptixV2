import 'package:adaptix/adaptix.dart';
import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestSizeBreakpoint extends SizeBreakpoint {
  @override
  final double compareValue;

  @override
  Null get returnValue => null;

  const TestSizeBreakpoint(
      {required this.compareValue, required super.debugLabel})
      : super();

  @override
  int getHashCode() => compareValue.hashCode;
}

void main() {
  group('Testing breakpoints', () {
    test('Ascending sort', () {
      final breakPoints = <TestSizeBreakpoint>[
        const TestSizeBreakpoint(compareValue: 200, debugLabel: 'two'),
        const TestSizeBreakpoint(compareValue: 100, debugLabel: 'one'),
        const TestSizeBreakpoint(compareValue: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => b.compareTo(a));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['one', 'two', 'three']);
    });
    test('Descening sort', () {
      final breakPoints = <TestSizeBreakpoint>[
        const TestSizeBreakpoint(compareValue: 200, debugLabel: 'two'),
        const TestSizeBreakpoint(compareValue: 100, debugLabel: 'one'),
        const TestSizeBreakpoint(compareValue: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => a.compareTo(b));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['three', 'two', 'one']);
    });
    test('Equality', () {
      const a = TestSizeBreakpoint(compareValue: 2, debugLabel: 'a');
      const b = TestSizeBreakpoint(compareValue: 2, debugLabel: 'b');
      const c = TestSizeBreakpoint(compareValue: 3, debugLabel: 'c');
      expect(a == b, true);
      expect(a == c, false);
    });
  });
  group('Pixel scale configs', () {
    test('Equality', () {
      final sample = PixelScaleConfigs(breakpoints: const [
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1)
      ]);
      final sampleIdentic = PixelScaleConfigs(breakpoints: const [
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1)
      ]);
      final childValueDiffers = PixelScaleConfigs(breakpoints: const [
        ResponsivePixelScaleBreakpoint(deviceWidth: 199, pixelScale: 1),
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
      ]);
      final decisionDiffers = PixelScaleConfigs(breakpoints: const [
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1),
      ], deviceWidthSideStrategy: DeviceWidthSideStrategy.useShortestSide);
      expect(sample.isSameAs(sampleIdentic), true);
      expect(sample.isSameAs(childValueDiffers), false);
      expect(sample.isSameAs(decisionDiffers), false);
    });
    test(
        'Constructor sort must remove equal elements and sort them according to device width',
        () {
      const sample = [
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1)
      ];
      final configs = PixelScaleConfigs(breakpoints: sample);
      expect(configs.breakpoints.length, 1);
      const sample2 = [
        ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1),
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1)
      ];
      final configs2 = PixelScaleConfigs(breakpoints: sample2);
      expect(configs2.breakpoints, const [
        ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1)
      ]);
    });
  });

  test('Constraints equality', () {
    final sample = AdaptixConstraints(
        configs: AdaptixConfigs(
            pixelScaleConfigs: PixelScaleConfigs(breakpoints: const [
          ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1)
        ])),
        orientation: Orientation.landscape,
        pixelScale: 1);
    final sampleIdentical = AdaptixConstraints(
        orientation: Orientation.landscape,
        configs: AdaptixConfigs(
            pixelScaleConfigs: PixelScaleConfigs(breakpoints: const [
          ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1)
        ])),
        pixelScale: 1);
    final deviceWidthDiffers = AdaptixConstraints(
        orientation: Orientation.landscape,
        configs: AdaptixConfigs(
          pixelScaleConfigs: PixelScaleConfigs(breakpoints: const [
            ResponsivePixelScaleBreakpoint(deviceWidth: 202, pixelScale: 1),
            ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1)
          ]),
        ),
        pixelScale: 1);
    final setPixelScaleDiffers = AdaptixConstraints(
        orientation: Orientation.landscape,
        configs: AdaptixConfigs(
            pixelScaleConfigs: PixelScaleConfigs(breakpoints: const [
          ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1)
        ])),
        pixelScale: 2);
    final orientationDiffers = AdaptixConstraints(
        configs: AdaptixConfigs(
            pixelScaleConfigs: PixelScaleConfigs(breakpoints: const [
          ResponsivePixelScaleBreakpoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelScaleBreakpoint(deviceWidth: 201, pixelScale: 1)
        ])),
        pixelScale: 1,
        orientation: Orientation.portrait);
    expect(sample.isSameAs(sampleIdentical), true);
    expect(sample.isSameAs(deviceWidthDiffers), false);
    expect(sample.isSameAs(setPixelScaleDiffers), false);
    expect(sample.isSameAs(orientationDiffers), false);
  });
}
