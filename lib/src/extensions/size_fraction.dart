import 'package:adaptix/src/widgets/adaptix.dart';
import 'package:flutter/widgets.dart';

extension SizeFractionExtension on num {
  double widthFraction(BuildContext context) =>
      Adaptix.of(context).size.width * (this / 100);

  double heightFraction(BuildContext context) =>
      Adaptix.of(context).size.height * (this / 100);

  double shortestSideFraction(BuildContext context) =>
      Adaptix.of(context).shortestSide * (this / 100);

  double longestSideFraction(BuildContext context) =>
      Adaptix.of(context).longestSide * (this / 100);
}
