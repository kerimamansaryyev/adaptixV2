import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/device_mock.dart';
import 'utils/initializer_test_app.dart';

void _changeOrientation(
    {required Orientation orientation,
    required double smallSide,
    required double wideSide,
    required WidgetTester tester}) {
  tester.binding.window.devicePixelRatioTestValue = 1.0;
  switch (orientation) {
    case Orientation.portrait:
      tester.binding.window.physicalSizeTestValue = Size(smallSide, wideSide);
      break;
    case Orientation.landscape:
      tester.binding.window.physicalSizeTestValue = Size(wideSide, smallSide);
      break;
  }
}

void _changeDevice(TestDeviceMock mock, WidgetTester tester) {
  tester.binding.window.devicePixelRatioTestValue = 1.0;
  tester.binding.window.physicalSizeTestValue =
      Size(mock.portrait.breakpoint, mock.landscape.breakpoint);
}

Adaptix _getAdaptix(WidgetTester tester) =>
    tester.widget(find.byType(Adaptix)) as Adaptix;

void _changeConfigs(
    AdaptixConfigs newConfigs, GlobalKey<InitializerTestAppState> key) {
  key.currentState?.changeAdaptixConfigs(newConfigs);
}

void _setMockConfigs(GlobalKey<InitializerTestAppState> key) {
  _changeConfigs(
      AdaptixConfigs(
          breakpoints: TestDeviceModeMock.breakpoints,
          pixelScaleRules: TestDeviceModeMock.pixelScaleRules),
      key);
}

Size _getSquareSize(WidgetTester tester) {
  final square = find.byType(InitializerTestSquare);
  return tester.getSize(square);
}

void main() {
  testWidgets('Must change pixel scale on layout change', (tester) async {
    var device = TestDeviceMock.phone;
    _changeOrientation(
        orientation: Orientation.portrait,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    final appKey = GlobalKey<InitializerTestAppState>();
    await tester.pumpWidget(InitializerTestApp(
      key: appKey,
    ));
    _setMockConfigs(appKey);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.portrait.breakpointPixelScale);
    device = TestDeviceMock.tablet;
    _changeDevice(device, tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.portrait.breakpointPixelScale);
    device = TestDeviceMock.desktop;
    _changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.landscape.breakpointPixelScale);
    expect(_getAdaptix(tester).data.orientation, Orientation.landscape);
  });
  testWidgets('Must change pixel scale on orientation changed', (tester) async {
    const device = TestDeviceMock.phone;
    _changeOrientation(
        orientation: Orientation.portrait,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    final appKey = GlobalKey<InitializerTestAppState>();
    await tester.pumpWidget(InitializerTestApp(
      key: appKey,
    ));
    _setMockConfigs(appKey);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.portrait.breakpointPixelScale);
    expect(_getAdaptix(tester).data.orientation, Orientation.portrait);
    _changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.landscape.breakpointPixelScale);
    expect(_getAdaptix(tester).data.orientation, Orientation.landscape);
  });
  testWidgets(
      'Must change scale based on orientation and strategy change [shortest side]/ [original width]',
      (tester) async {
    const device = TestDeviceMock.phone;
    _changeOrientation(
        orientation: Orientation.portrait,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    final appKey = GlobalKey<InitializerTestAppState>();
    await tester.pumpWidget(InitializerTestApp(
      key: appKey,
    ));
    _changeConfigs(
        AdaptixConfigs(
            breakpoints: TestDeviceModeMock.breakpoints,
            pixelScaleRules: TestDeviceModeMock.pixelScaleRules,
            strategy: DeviceBreakpointDecisionStrategy.useShortestSide),
        appKey);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.portrait.breakpointPixelScale);
    expect(_getAdaptix(tester).data.orientation, Orientation.portrait);
    _changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.portrait.breakpointPixelScale);
    expect(_getAdaptix(tester).data.orientation, Orientation.landscape);
    _changeConfigs(
        AdaptixConfigs(
            breakpoints: TestDeviceModeMock.breakpoints,
            pixelScaleRules: TestDeviceModeMock.pixelScaleRules,
            strategy: DeviceBreakpointDecisionStrategy.useOriginalWidth),
        appKey);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.landscape.breakpointPixelScale);
    expect(_getAdaptix(tester).data.orientation, Orientation.landscape);
  });
}
