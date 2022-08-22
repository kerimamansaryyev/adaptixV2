import 'package:adaptix/src/models/adaptix_constraints.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'adaptix_configs_test.dart' as adaptix_configs_test;

void main() {
  test('Testing $AdaptixConstraints equality', () {
    final constraints = AdaptixConstraints(
        size: const Size(800, 400),
        breakpoint: const ResponsiveBreakpoint(value: 120, key: 'mobile'),
        orientation: Orientation.landscape,
        configs: adaptix_configs_test.configs);
    final same = AdaptixConstraints(
        size: const Size(800, 400),
        breakpoint: const ResponsiveBreakpoint(value: 120, key: 'mobile'),
        orientation: Orientation.landscape,
        configs: adaptix_configs_test.configs);
    final orientationDiffers = AdaptixConstraints(
        size: const Size(800, 400),
        breakpoint: const ResponsiveBreakpoint(value: 120, key: 'mobile'),
        orientation: Orientation.portrait,
        configs: adaptix_configs_test.configs);
    final breakpointDiffers = AdaptixConstraints(
        size: const Size(800, 400),
        breakpoint: const ResponsiveBreakpoint(value: 120, key: 'tablet'),
        orientation: Orientation.landscape,
        configs: adaptix_configs_test.configs);
    final configsDiffers = AdaptixConstraints(
        size: const Size(800, 400),
        breakpoint: const ResponsiveBreakpoint(value: 120, key: 'mobile'),
        orientation: Orientation.landscape,
        configs: adaptix_configs_test.listHasMoreItemsButSame);
    final sizeDiffers = AdaptixConstraints(
        size: const Size(700, 400),
        breakpoint: const ResponsiveBreakpoint(value: 120, key: 'mobile'),
        orientation: Orientation.landscape,
        configs: adaptix_configs_test.listHasMoreItemsButSame);
    expect(constraints.isSameAs(same), true);
    expect(constraints.isSameAs(orientationDiffers), false);
    expect(constraints.isSameAs(breakpointDiffers), false);
    expect(constraints.isSameAs(configsDiffers), false);
    expect(constraints.isSameAs(sizeDiffers), false);
  });
}
