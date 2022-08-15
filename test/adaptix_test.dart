import 'package:adaptix/adaptix.dart';
import 'package:adaptix/src/models/configs.dart';
import 'package:adaptix/src/models/data.dart';
import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:flutter_test/flutter_test.dart';

class TestSizeBreakPoint extends SizeBreakPoint {
  @override
  final double compareValue;

  @override
  Null get returnValue => null;

  const TestSizeBreakPoint(
      {required this.compareValue, required super.debugLabel})
      : super();
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
  test('Configs equality', () {
    const a = AdaptixConfigs(breakpoints: [
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
    ]);
    const b = AdaptixConfigs(breakpoints: [
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
    ]);
    const c = AdaptixConfigs(breakpoints: [
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
    ]);
    const d = AdaptixConfigs(breakpoints: [
      ResponsivePixelValueBreakPoint(deviceWidth: 199, pixelScale: 1),
      ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
    ]);
    expect(a.isSameAs(b), true);
    expect(a.isSameAs(c), false);
    expect(a.isSameAs(d), false);
  });

  test('Constraints equality', () {
    const a = AdaptixConstraints(
        configs: AdaptixConfigs(breakpoints: [
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
        ]),
        pixelScale:
            ResponsivePixelValueBreakPoint(deviceWidth: 120, pixelScale: 1));
    const b = AdaptixConstraints(
        configs: AdaptixConfigs(breakpoints: [
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
        ]),
        pixelScale:
            ResponsivePixelValueBreakPoint(deviceWidth: 120, pixelScale: 1));
    const c = AdaptixConstraints(
        configs: AdaptixConfigs(breakpoints: [
          ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
        ]),
        pixelScale:
            ResponsivePixelValueBreakPoint(deviceWidth: 120, pixelScale: 1));
    const d = AdaptixConstraints(
        configs: AdaptixConfigs(breakpoints: [
          ResponsivePixelValueBreakPoint(deviceWidth: 201, pixelScale: 1),
          ResponsivePixelValueBreakPoint(deviceWidth: 200, pixelScale: 1)
        ]),
        pixelScale:
            ResponsivePixelValueBreakPoint(deviceWidth: 121, pixelScale: 1));
    expect(a.isSameAs(b), true);
    expect(a.isSameAs(c), false);
    expect(a.isSameAs(d), false);
  });
}
