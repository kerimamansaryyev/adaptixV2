import 'package:adaptix/src/models/breakpoint.dart';

extension ResponsiveBreakpointIterableExtension
    on Iterable<ResponsiveBreakpoint> {
  ResponsiveBreakpoint? detectBreakpoint(double deviceWidth) {
    if (isEmpty) {
      return null;
    } else if (deviceWidth <= first.value) {
      return first;
    }

    for (int i = 1; i < length; i++) {
      if (deviceWidth <= elementAt(i).value) {
        return elementAt(i - 1);
      }
    }

    return last;
  }

  bool _containsBreakpoint(ResponsiveBreakpoint breakpoint) {
    for (var element in this) {
      if (element.isSameAs(breakpoint)) {
        return true;
      }
      continue;
    }
    return false;
  }

  Iterable<ResponsiveBreakpoint> iterableRemoveSame() sync* {
    final found = <ResponsiveBreakpoint>[];
    for (var element in this) {
      if (found._containsBreakpoint(element)) {
        continue;
      } else {
        found.add(element);
        yield element;
      }
    }
  }
}
