import 'package:adaptix/src/models/adaptix_constraints.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:meta/meta.dart';

/// Exception is thrown when [AdaptixConstraints] was created with an empty list of the breakpoints
@visibleForTesting
class ResponsiveBreakpointsListEmptyException implements Exception {
  const ResponsiveBreakpointsListEmptyException();

  String get message =>
      'Iterable<$ResponsiveBreakpoint> can not be empty on device detection';
}
