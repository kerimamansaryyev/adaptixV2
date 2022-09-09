import 'package:adaptix/src/extensions/comparison.dart';
import 'package:adaptix/src/models/generic_switch.dart';

extension GenericRuleIterableExtension on Iterable<GenericResponsiveRule> {
  Iterable<GenericResponsiveRule> iterableRemoveSame() sync* {
    final found = <GenericResponsiveRule>[];
    for (var element in this) {
      if (found.containsComparable<GenericResponsiveRule>(
        (elementPred) => elementPred.isSameAs(element),
      )) {
        continue;
      } else {
        found.add(element);
        yield element;
      }
    }
  }
}
