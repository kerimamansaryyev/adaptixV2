import 'package:adaptix/src/models/adaptix_constraints.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:flutter/widgets.dart';
import 'package:collection/collection.dart' as collection;

typedef GenericResponsiveRulesMap<T> = Map<String, T>;

@immutable
class CanonicPixelResponsiveScaleSwitch
    extends GenericResponsiveSwitch<double> {
  const CanonicPixelResponsiveScaleSwitch()
      : super._(
          defaultValue: 1.0,
          rules: CanonicalResponsiveBreakpoint.canonicalPixelScaleRules,
        );
}

/// An argument class for [GenericResponsiveSwitch.new] constructor
@immutable
class GenericResponsiveSwitchArgs<T> {
  final T defaultValue;
  final GenericResponsiveRulesMap<T> rules;

  const GenericResponsiveSwitchArgs({
    required this.defaultValue,
    this.rules = const {},
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
        rules: arguments.rules,
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
@Deprecated(
  'GenericResponsiveRule is deprecated to boost performance. Starting from, 0.1.0 pass Map<String, T> to GenericResponsiveSwitchArgs',
)
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
