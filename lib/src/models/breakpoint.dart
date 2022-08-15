import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SizeBreakPoint<T>
    with
        StraighComparisonMixin,
        Comparable<SizeBreakPoint>,
        ComparableOperatorsMixin<SizeBreakPoint> {
  final String? debugLabel;

  const SizeBreakPoint({this.debugLabel});

  T get returnValue;
  double get compareValue;

  @override
  bool isSameAs(StraighComparisonMixin other) {
    return other is SizeBreakPoint && other == this;
  }

  @override
  int compareTo(SizeBreakPoint other) {
    return other.compareValue.compareTo(compareValue);
  }

  @override
  int getHashCode() => hashCode;
}
