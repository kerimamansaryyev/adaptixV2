import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SizeBreakpoint<T>
    with
        ArgsComparisonMixin,
        Comparable<SizeBreakpoint>,
        ComparableOperatorsMixin<SizeBreakpoint> {
  final String? debugLabel;

  const SizeBreakpoint({this.debugLabel});

  T get returnValue;
  double get compareValue;

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is SizeBreakpoint && other == this;
  }

  @override
  int compareTo(SizeBreakpoint other) {
    return other.compareValue.compareTo(compareValue);
  }

  @override
  int getHashCode();
}
