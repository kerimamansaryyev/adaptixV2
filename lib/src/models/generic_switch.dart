import 'package:adaptix/src/extensions/generic_switch.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart' as collection;

@immutable
class CanonicPixelResponsiveScaleSwitch
    extends GenericResponsiveSwitch<double> {
  const CanonicPixelResponsiveScaleSwitch()
      : super._(
            defaultValue: 1.0,
            rules: CanonicalResponsiveBreakpoint.canonicalRulesRaw);
}

@immutable
class GenericResponsiveSwitch<T> with ArgsComparisonMixin {
  final T defaultValue;

  @protected
  final Map<String, T> rules;

  @visibleForTesting
  Map<String, T> get rulesTest => rules;

  T getValueAccordingtoBreakpoint(ResponsiveBreakpoint breakpoint) {
    return rules[breakpoint.key] ?? defaultValue;
  }

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

  @override
  bool isSameAs(ArgsComparisonMixin other) =>
      other is GenericResponsiveSwitch &&
      rules.length == other.rules.length &&
      const collection.MapEquality().equals(rules, other.rules);
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
