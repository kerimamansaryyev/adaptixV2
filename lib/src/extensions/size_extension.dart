import 'package:adaptix/src/widgets/adaptix_notifier.dart';
import 'package:flutter/widgets.dart';

extension SizeExtension on num {
  double adaptedPx(BuildContext context) =>
      Adaptix.of(context).pixelScale * this;
}
