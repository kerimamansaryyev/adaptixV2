import 'package:adaptix/src/extensions/generic_switch.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

@immutable
class GenericResponsiveSwitch<T> {
  final T defaultValue;
  final List<GenericResponsiveRule> rules;

  const GenericResponsiveSwitch._(
      {required this.defaultValue, required this.rules});

  factory GenericResponsiveSwitch(
          {required T defaultValue,
          List<GenericResponsiveRule> rules = const []}) =>
      GenericResponsiveSwitch._(defaultValue: defaultValue, rules: rules)
          ._sorted();

  GenericResponsiveSwitch<T> _sorted() => GenericResponsiveSwitch._(
      defaultValue: defaultValue, rules: rules.iterableRemoveSame().toList());
}

@immutable
class GenericResponsiveRule<T> with ArgsComparisonMixin {
  final String responsiveBreakpointKey;
  final T value;

  const GenericResponsiveRule(
      {required this.responsiveBreakpointKey, required this.value});

  @override
  bool isSameAs(ArgsComparisonMixin other) =>
      other is GenericResponsiveRule &&
      responsiveBreakpointKey == other.responsiveBreakpointKey;
}
