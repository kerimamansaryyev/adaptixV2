import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';

extension SizeFractionExtension on num {
  /// Gives a percent fraction of the device width
  double widthFraction(BuildContext context) =>
      Adaptix.of(context).size.width * (this / 100);

  /// Gives a percent fraction of the device height
  double heightFraction(BuildContext context) =>
      Adaptix.of(context).size.height * (this / 100);

  /// Gives a percent fraction of the device's shortest side
  double shortestSideFraction(BuildContext context) =>
      Adaptix.of(context).shortestSide * (this / 100);

  /// Gives a percent fraction of the device's longest side
  double longestSideFraction(BuildContext context) =>
      Adaptix.of(context).longestSide * (this / 100);
}
