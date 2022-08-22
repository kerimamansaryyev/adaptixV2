import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/device_mock.dart';
import 'utils/initializer_test_app.dart';
import 'utils/utils.dart';

void _setMockConfigs(GlobalKey<InitializerTestAppState> key) {
  _changeConfigs(
      AdaptixConfigs(
          breakpoints: TestDeviceModeMock.breakpoints,
          pixelScaleRules: TestDeviceModeMock.pixelScaleRules),
      key);
}

void _changeConfigs(
    AdaptixConfigs newConfigs, GlobalKey<InitializerTestAppState> key) {
  key.currentState?.changeAdaptixConfigs(newConfigs);
}

Size _getSquareSize(WidgetTester tester) {
  final square = find.byType(InitializerTestSquare);
  return tester.getSize(square);
}

void main() {
  testWidgets('Must change pixel scale on layout change', (tester) async {
    var device = TestDeviceMock.phone;
    changeOrientation(
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
    changeDevice(device, tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.portrait.breakpointPixelScale);
    device = TestDeviceMock.desktop;
    changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.landscape.breakpointPixelScale);
    expect(getAdaptix(tester).data.orientation, Orientation.landscape);
  });
  testWidgets('Must change pixel scale on orientation changed', (tester) async {
    const device = TestDeviceMock.phone;
    changeOrientation(
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
    expect(getAdaptix(tester).data.orientation, Orientation.portrait);
    changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.landscape.breakpointPixelScale);
    expect(getAdaptix(tester).data.orientation, Orientation.landscape);
  });
  testWidgets(
      'Must change scale based on orientation and strategy change [shortest side]/ [original width]',
      (tester) async {
    const device = TestDeviceMock.phone;
    changeOrientation(
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
    expect(getAdaptix(tester).data.orientation, Orientation.portrait);
    changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpAndSettle();
    expect(
        _getSquareSize(tester).width,
        InitializerTestApp.squareSizeMultiplier *
            device.portrait.breakpointPixelScale);
    expect(getAdaptix(tester).data.orientation, Orientation.landscape);
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
    expect(getAdaptix(tester).data.orientation, Orientation.landscape);
  });
}
