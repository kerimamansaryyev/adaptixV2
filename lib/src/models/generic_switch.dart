import 'package:adaptix/src/extensions/generic_switch.dart';
import 'package:adaptix/src/models/adaptix_constraints.dart';
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
          rules: CanonicalResponsiveBreakpoint.canonicalRulesRaw,
        );
}

/// An argument class for [GenericResponsiveSwitch.new] constructor
@immutable
class GenericResponsiveSwitchArgs<T> {
  final T defaultValue;
  final List<GenericResponsiveRule<T>> rules;

  const GenericResponsiveSwitchArgs({
    required this.defaultValue,
    this.rules = const [],
  });
}

@immutable
class GenericResponsiveSwitch<T> with ArgsComparisonMixin {
  @protected
  final Map<String, T> rules;
  final T defaultValue;

  factory GenericResponsiveSwitch(GenericResponsiveSwitchArgs<T> arguments) =>
      GenericResponsiveSwitch._(
        defaultValue: arguments.defaultValue,
        rules: <String, T>{
          for (var rule in arguments.rules
              .iterableRemoveSame()
              .cast<GenericResponsiveRule<T>>())
            rule.responsiveBreakpointKey: rule.value
        },
      );

  const GenericResponsiveSwitch._({
    required this.defaultValue,
    required this.rules,
  });

  @visibleForTesting
  Map<String, T> get rulesTest => rules;

  T getValueAccordingtoBreakpoint(ResponsiveBreakpoint breakpoint) {
    return rules[breakpoint.key] ?? defaultValue;
  }

  @override
  bool isSameAs(ArgsComparisonMixin other) =>
      other is GenericResponsiveSwitch &&
      rules.length == other.rules.length &&
      const collection.MapEquality().equals(rules, other.rules);
}

/// A class that is used as a relation between [ResponsiveBreakpoint] via its [ResponsiveBreakpoint.key]
/// and generic [value].
///
/// List of [GenericResponsiveRule] is passed to [GenericResponsiveSwitch] to create declarative mechanism of
/// selecting generic values according to [AdaptixConstraints]
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
