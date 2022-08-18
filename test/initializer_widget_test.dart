import 'package:adaptix/adaptix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utils/initializer_testing_page.dart';

void main() {
  group('AdaptixInitializer tests', () {
    testWidgets('Must change scale on orientation changed', (tester) async {
      const smallSide = 400.0;
      const wideSide = 800.0;
      // Portrait
      tester.binding.window.devicePixelRatioTestValue = 1.0;
      tester.binding.window.physicalSizeTestValue =
          const Size(smallSide, wideSide);
      await tester.pumpWidget(const InitializerTestApp());
      final square = find.byType(InitializerTestSquare);
      expect(square, findsOneWidget);
      final baseSizePortrait = tester.getSize(square);
      expect(baseSizePortrait.width,
          equals(InitializerTestApp.squareSizeMultiplier * 1));
      expect(baseSizePortrait.height,
          equals(InitializerTestApp.squareSizeMultiplier * 1));
      final adaptixPortrait = tester.widget(find.byType(Adaptix)) as Adaptix;
      expect(adaptixPortrait.data.orientation, Orientation.portrait);
      // Landscape
      tester.binding.window.physicalSizeTestValue =
          const Size(wideSide, smallSide);
      await tester.pumpAndSettle();
      final baseSizeLandscape = tester.getSize(square);
      expect(baseSizeLandscape.width,
          equals(InitializerTestApp.squareSizeMultiplier * 1.2));
      expect(baseSizeLandscape.height,
          equals(InitializerTestApp.squareSizeMultiplier * 1.2));
      final adaptixLandscape = tester.widget(find.byType(Adaptix)) as Adaptix;
      expect(adaptixLandscape.data.orientation, Orientation.portrait);
    });
  });
  testWidgets(
      'Must change scale based on orientation and strategy change [shortest side]/ [original width]',
      (tester) async {
    const smallSide = 400.0;
    const wideSide = 800.0;
    // Portrait
    tester.binding.window.devicePixelRatioTestValue = 1.0;
    tester.binding.window.physicalSizeTestValue =
        const Size(smallSide, wideSide);
    final appKey = GlobalKey<InitializerTestAppState>();
    await tester.pumpWidget(InitializerTestApp(key: appKey));
    await tester.pumpAndSettle();
    final appState = appKey.currentState!;
    final square = find.byType(InitializerTestSquare);
    expect(square, findsOneWidget);
    var baseSizePortrait = tester.getSize(square);

    expect(baseSizePortrait.width,
        equals(InitializerTestApp.squareSizeMultiplier * 1));
    expect(baseSizePortrait.height,
        equals(InitializerTestApp.squareSizeMultiplier * 1));

    // Changing strategy
    appState.setShortSideStrategy();
    await tester.pumpAndSettle();
    baseSizePortrait = tester.getSize(square);

    expect(baseSizePortrait.width,
        equals(InitializerTestApp.squareSizeMultiplier * 1));
    expect(baseSizePortrait.height,
        equals(InitializerTestApp.squareSizeMultiplier * 1));

    final adaptixPortrait = tester.widget(find.byType(Adaptix)) as Adaptix;
    expect(adaptixPortrait.data.orientation, Orientation.portrait);
    expect(
        adaptixPortrait.data.configs.pixelScaleConfigs.deviceWidthSideStrategy,
        DeviceWidthSideStrategy.useShortestSide);

    // Tear down to the default strategy
    appState.setOriginalWidthStrategy();
    await tester.pumpAndSettle();

    // Landscape
    tester.binding.window.physicalSizeTestValue =
        const Size(wideSide, smallSide);
    await tester.pumpAndSettle();
    var baseSizeLandscape = tester.getSize(square);

    expect(baseSizeLandscape.width,
        equals(InitializerTestApp.squareSizeMultiplier * 1.2));
    expect(baseSizeLandscape.height,
        equals(InitializerTestApp.squareSizeMultiplier * 1.2));

    // Changing strategy
    appState.setShortSideStrategy();
    await tester.pumpAndSettle();
    baseSizeLandscape = tester.getSize(square);

    expect(baseSizeLandscape.width,
        equals(InitializerTestApp.squareSizeMultiplier));
    expect(baseSizeLandscape.height,
        equals(InitializerTestApp.squareSizeMultiplier));

    final adaptixLandscape = tester.widget(find.byType(Adaptix)) as Adaptix;
    expect(adaptixLandscape.data.orientation, Orientation.portrait);
    expect(
        adaptixLandscape.data.configs.pixelScaleConfigs.deviceWidthSideStrategy,
        DeviceWidthSideStrategy.useShortestSide);
  });
}
