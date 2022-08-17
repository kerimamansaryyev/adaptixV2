// import 'package:flutter/widgets.dart';

import 'package:adaptix/src/widgets/adaptix_notifier.dart';
import 'package:flutter/widgets.dart';

bool debugCheckHasAdaptix(BuildContext context) {
  assert(() {
    if (context.getElementForInheritedWidgetOfExactType<Adaptix>() == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('No Adaptix widget ancestor found.'),
        ErrorHint(
          'No Adaptix ancestor could be found starting from the context '
          'that was passed to Adaptix.of(). This can happen because you '
          'did not wrap starting point of your context tree with AdaptixInitializer',
        ),
      ]);
    }
    return true;
  }());
  return true;
}
