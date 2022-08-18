import 'package:adaptix/src/models/breakpoint.dart';

mixin DeviceDetectMixin<T extends SizeBreakpoint> {
  Iterable<T> get breakpoints;

  List<T> sortedBreakpoints() =>
      breakpoints.toSet().toList()..sort((a, b) => b.compareTo(a));

  DeviceDetectMixin sorted();
}
