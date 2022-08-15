import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

@immutable
class SizeBreakPoint
    with Comparable<SizeBreakPoint>, ComparableOperatorsMixin<SizeBreakPoint> {
  final double value;
  final String? debugLabel;

  const SizeBreakPoint({required this.value, this.debugLabel});

  @override
  int compareTo(SizeBreakPoint other) {
    return other.value.compareTo(value);
  }

  @override
  int getHashCode() => hashCode;
}
