import 'package:adaptix/src/exceptions/device_detection.dart';
import 'package:adaptix/src/extensions/comparison.dart';
import 'package:adaptix/src/models/breakpoint.dart';

extension ResponsiveBreakpointIterableExtension
    on Iterable<ResponsiveBreakpoint> {
  /// Detect a breakpoint according to [deviceWidth]
  ResponsiveBreakpoint detectBreakpoint(num deviceWidth) {
    if (isEmpty) {
      throw ResponsiveBreakpointsListEmptyException();
    } else if (deviceWidth < first.templateDeviceWidth) {
      return first;
    }

    for (int i = 1; i < length; i++) {
      if (deviceWidth < elementAt(i).templateDeviceWidth) {
        return elementAt(i - 1);
      }
    }

    return last;
  }

  /// Removes identical breakpoints from this iterable.
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
