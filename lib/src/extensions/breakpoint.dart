import 'package:adaptix/src/exceptions/device_detection.dart';
import 'package:adaptix/src/extensions/comparison.dart';
import 'package:adaptix/src/models/breakpoint.dart';

extension ResponsiveBreakpointIterableExtension
    on Iterable<ResponsiveBreakpoint> {
  ResponsiveBreakpoint detectBreakpoint(num deviceWidth) {
    if (isEmpty) {
      throw ResponsiveBreakpointsListEmptyException();
    } else if (deviceWidth < first.value) {
      return first;
    }

    for (int i = 1; i < length; i++) {
      if (deviceWidth < elementAt(i).value) {
        return elementAt(i - 1);
      }
    }

    return last;
  }

  Iterable<ResponsiveBreakpoint> iterableRemoveSame() sync* {
    final found = <ResponsiveBreakpoint>[];
    for (var element in this) {
      if (found.containsComparable<ResponsiveBreakpoint>(
        (elementPred) =>
            elementPred.isSameAs(element) ||
            elementPred.hasSameValueAs(element),
      )) {
        continue;
      } else {
        found.add(element);
        yield element;
      }
    }
  }
}
