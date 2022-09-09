import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/generic_switch.dart';
import 'package:flutter_test/flutter_test.dart';

final configs = AdaptixConfigs(
  breakpoints: const [ResponsiveBreakpoint(value: 120, key: 'mobile')],
  strategy: DeviceBreakpointDecisionStrategy.useOriginalWidth,
);
final same = AdaptixConfigs(
  breakpoints: const [ResponsiveBreakpoint(value: 120, key: 'mobile')],
  strategy: DeviceBreakpointDecisionStrategy.useOriginalWidth,
);
final strategyDiffers = AdaptixConfigs(
  breakpoints: const [ResponsiveBreakpoint(value: 120, key: 'mobile')],
  strategy: DeviceBreakpointDecisionStrategy.useShortestSide,
);
final listDiffers = AdaptixConfigs(
  breakpoints: const [
    ResponsiveBreakpoint(value: 120, key: 'mobile'),
    ResponsiveBreakpoint(value: 121, key: 'mobile')
  ],
  strategy: DeviceBreakpointDecisionStrategy.useOriginalWidth,
);
final listHasSameValues = AdaptixConfigs(
  breakpoints: const [
    ResponsiveBreakpoint(value: 120, key: 'mobile'),
    ResponsiveBreakpoint(value: 120, key: 'mobile')
  ],
  strategy: DeviceBreakpointDecisionStrategy.useOriginalWidth,
);
final listHasMoreItemsButSame = AdaptixConfigs(
  breakpoints: const [
    ResponsiveBreakpoint(value: 120, key: 'mobile'),
    ResponsiveBreakpoint(value: 120, key: 'mobile'),
    ResponsiveBreakpoint(value: 121, key: 'mobile')
  ],
  strategy: DeviceBreakpointDecisionStrategy.useOriginalWidth,
);
final scaleFactorDiffers = AdaptixConfigs(
  breakpoints: const [ResponsiveBreakpoint(value: 120, key: 'mobile')],
  strategy: DeviceBreakpointDecisionStrategy.useOriginalWidth,
  globalPixelScaleFactor: 2,
);

void main() {
  test('$AdaptixConfigs equality', () {
    expect(configs.isSameAs(same), true);
    expect(configs.isSameAs(strategyDiffers), false);
    expect(configs.isSameAs(listDiffers), false);
    expect(listHasSameValues.breakpoints.length, 1);
    expect(listHasMoreItemsButSame.isSameAs(listHasSameValues), false);
    expect(configs.isSameAs(scaleFactorDiffers), false);
  });
  test('Assertion must be triggered if the breakpoints list is emty', () {
    expect(() => AdaptixConfigs(breakpoints: const []), throwsAssertionError);
  });
  test(
      'Canonical constructor must contain $CanonicPixelResponsiveScaleSwitch for pixel scaling',
      () {
    expect(
      const AdaptixConfigs.canonical().pixelScaleSwitch,
      const CanonicPixelResponsiveScaleSwitch(),
    );
  });
}
