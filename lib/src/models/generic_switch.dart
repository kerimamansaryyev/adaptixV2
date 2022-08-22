import 'package:adaptix/src/extensions/generic_switch.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

@immutable
class GenericResponsiveSwitch<T> {
  final T defaultValue;

  @protected
  final Map<String, T> rules;

  const GenericResponsiveSwitch._(
      {required this.defaultValue, required this.rules});

  factory GenericResponsiveSwitch(
          {required T defaultValue,
          List<GenericResponsiveRule> rules = const []}) =>
      GenericResponsiveSwitch._(defaultValue: defaultValue, rules: <String, T>{
        for (var rule
            in rules.iterableRemoveSame().cast<GenericResponsiveRule<T>>())
          rule.responsiveBreakpointKey: rule.value
      });
}

@immutable
class GenericResponsiveRule<T> with ArgsComparisonMixin {
  final String responsiveBreakpointKey;
  final T value;

  const GenericResponsiveRule(this.responsiveBreakpointKey, this.value);

  @override
  bool isSameAs(ArgsComparisonMixin other) =>
      other is GenericResponsiveRule &&
      responsiveBreakpointKey == other.responsiveBreakpointKey;
}
