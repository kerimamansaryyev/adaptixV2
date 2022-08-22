import 'package:adaptix/src/models/breakpoint.dart';
import 'package:meta/meta.dart';

@visibleForTesting
class ResponsiveBreakpointsListEmptyException implements Exception {
  String get message =>
      'Iterable<$ResponsiveBreakpoint> can not be empty on device detection';
}
