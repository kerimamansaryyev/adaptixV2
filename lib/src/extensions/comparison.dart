import 'package:adaptix/src/utils/comparable.dart';

extension ArgsComparisonIterableExtension on Iterable<ArgsComparisonMixin> {
  bool containsComparable<T extends ArgsComparisonMixin>(
      bool Function(T) decisionPredicate) {
    for (var element in this) {
      if (decisionPredicate(element as T)) {
        return true;
      }
      continue;
    }
    return false;
  }
}
