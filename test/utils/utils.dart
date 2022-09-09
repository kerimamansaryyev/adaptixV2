import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mocks/device_mock.dart';

void changeDevice(TestDeviceMock mock, WidgetTester tester) {
  tester.binding.window.devicePixelRatioTestValue = 1.0;
  tester.binding.window.physicalSizeTestValue =
      Size(mock.portrait.breakpoint, mock.landscape.breakpoint);
}

Adaptix getAdaptix(WidgetTester tester) =>
    tester.widget(find.byType(Adaptix)) as Adaptix;

void changeOrientation({
  required Orientation orientation,
  required double smallSide,
  required double wideSide,
  required WidgetTester tester,
}) {
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
