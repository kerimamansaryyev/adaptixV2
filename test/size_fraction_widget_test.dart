import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'mocks/device_mock.dart';
import 'utils/size_fraction_widget_sample.dart';
import 'utils/utils.dart';

Size _getSquare1(WidgetTester tester) {
  final square = find.byType(TestSizeFractionSquareWidget);
  return tester.getSize(square);
}

Size _getSquare2(WidgetTester tester) {
  final square = find.byType(TestLongestShortestSideWidget);
  return tester.getSize(square);
}

void main() {
  testWidgets(
      '.widthFraction and .heightFraction must return fractions of full width or height respectively',
      (tester) async {
    var device = TestDeviceMock.phone;
    changeOrientation(
        orientation: Orientation.portrait,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpWidget(const TestSizeFractionWidget());
    expect(_getSquare1(tester).width, 0.5 * device.portrait.breakpoint);
    expect(_getSquare1(tester).height, 0.5 * device.landscape.breakpoint);
    await tester.pumpWidget(const TestSizeFractionWidget());
    changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpWidget(const TestSizeFractionWidget());
    expect(_getSquare1(tester).width, 0.5 * device.landscape.breakpoint);
    expect(_getSquare1(tester).height, 0.5 * device.portrait.breakpoint);
  });
  testWidgets(
      '.shortestSideFraction and .longestSideFraction must return fractions of shortest or longest side respectively',
      (tester) async {
    var device = TestDeviceMock.phone;
    changeOrientation(
        orientation: Orientation.portrait,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpWidget(const TestSizeFractionWidget());
    expect(_getSquare2(tester).width, 0.5 * device.portrait.breakpoint);
    expect(_getSquare2(tester).height, 0.5 * device.landscape.breakpoint);
    await tester.pumpWidget(const TestSizeFractionWidget());
    changeOrientation(
        orientation: Orientation.landscape,
        smallSide: device.smallestSide,
        wideSide: device.biggestSide,
        tester: tester);
    await tester.pumpWidget(const TestSizeFractionWidget());
    expect(_getSquare2(tester).width, 0.5 * device.portrait.breakpoint);
    expect(_getSquare2(tester).height, 0.5 * device.landscape.breakpoint);
  });
}
