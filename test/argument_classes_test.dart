import 'package:adaptix/adaptix.dart';
import 'package:adaptix/src/models/configs.dart';
import 'package:adaptix/src/models/constraints.dart';
import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestSizeBreakPoint extends SizeBreakPoint {
  @override
  final double compareValue;

  @override
  Null get returnValue => null;

  const TestSizeBreakPoint(
      {required this.compareValue, required super.debugLabel})
      : super();

  @override
  int getHashCode() => compareValue.hashCode;
}

void main() {
  group('Testing breakpoints', () {
    test('Ascending sort', () {
      final breakPoints = <TestSizeBreakPoint>[
        const TestSizeBreakPoint(compareValue: 200, debugLabel: 'two'),
        const TestSizeBreakPoint(compareValue: 100, debugLabel: 'one'),
        const TestSizeBreakPoint(compareValue: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => b.compareTo(a));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['one', 'two', 'three']);
    });
    test('Descening sort', () {
      final breakPoints = <TestSizeBreakPoint>[
        const TestSizeBreakPoint(compareValue: 200, debugLabel: 'two'),
        const TestSizeBreakPoint(compareValue: 100, debugLabel: 'one'),
        const TestSizeBreakPoint(compareValue: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => a.compareTo(b));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['three', 'two', 'one']);
    });
    test('Equality', () {
      const a = TestSizeBreakPoint(compareValue: 2, debugLabel: 'a');
      const b = TestSizeBreakPoint(compareValue: 2, debugLabel: 'b');
      const c = TestSizeBreakPoint(compareValue: 3, debugLabel: 'c');
      expect(a == b, true);
      expect(a == c, false);
    });
  });
  group('Configs', () {
    test('Equality', () {
      final sample = AdaptixConfigs(breakpoints: const [
        ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1)
      ]);
      final sampleIdentic = AdaptixConfigs(breakpoints: const [
        ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1)
      ]);
      final childValueDiffers = AdaptixConfigs(breakpoints: const [
        ResponsivePixelValueBreakPoint(deviceWidth: 199, pixelScale: 1),
        ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
      ]);
      expect(sample.isSameAs(sampleIdentic), true);
      expect(sample.isSameAs(childValueDiffers), false);
    });
    test(
        'Constructor sort must remove equal elements and sort them according to device width',
        () {
      const sample = [
        ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
      ];
      final configs = AdaptixConfigs(breakpoints: sample);
      expect(configs.breakpoints.length, 1);
      const sample2 = [
        ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1),
        ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
      ];
      final configs2 = AdaptixConfigs(breakpoints: sample2);
      expect(configs2.breakpoints, const [
        ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
        ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1)
      ]);
    });
  });

  test('Constraints equality', () {
    final sample = AdaptixConstraints(
        configs: AdaptixConfigs(breakpoints: const [
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1)
        ]),
        orientation: Orientation.landscape,
        pixelScale: 1);
    final sampleIdentical = AdaptixConstraints(
        orientation: Orientation.landscape,
        configs: AdaptixConfigs(breakpoints: const [
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1)
        ]),
        pixelScale: 1);
    final deviceWidthDiffers = AdaptixConstraints(
        orientation: Orientation.landscape,
        configs: AdaptixConfigs(breakpoints: const [
          ResponsivePixelValueBreakPoint(deviceWidth: 202, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
        ]),
        pixelScale: 1);
    final setPixelScaleDiffers = AdaptixConstraints(
        orientation: Orientation.landscape,
        configs: AdaptixConfigs(breakpoints: const [
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1)
        ]),
        pixelScale: 2);
    final orientationDiffers = AdaptixConstraints(
        configs: AdaptixConfigs(breakpoints: const [
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1)
        ]),
        pixelScale: 1,
        orientation: Orientation.portrait);
    expect(sample.isSameAs(sampleIdentical), true);
    expect(sample.isSameAs(deviceWidthDiffers), false);
    expect(sample.isSameAs(setPixelScaleDiffers), false);
    expect(sample.isSameAs(orientationDiffers), false);
  });
}
