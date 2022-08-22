import 'package:adaptix/src/utils/comparable.dart';
import 'package:meta/meta.dart';

enum CanonicalResponsiveBreakpoints implements ResponsiveBreakpoint {
  xSmall(380),
  small(414),
  medium(600),
  tablet(800),
  desktop(1100);

  @override
  final double value;

  @override
  String get key => name;

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is ResponsiveBreakpoint &&
        other.value == value &&
        other.key == key;
  }

  @override
  bool hasSameValueAs(ResponsiveBreakpoint other) => other.value == value;

  @override
  String get debugLabel => name;

  const CanonicalResponsiveBreakpoints(this.value);
}

@immutable
class ResponsiveBreakpoint with ArgsComparisonMixin {
  final double value;
  final String? debugLabel;
  final String key;

  const ResponsiveBreakpoint(
      {required this.value, required this.key, this.debugLabel});

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is ResponsiveBreakpoint &&
        other.value == value &&
        other.key == key;
  }

  @override
  bool operator ==(other) =>
      other is ResponsiveBreakpoint && hashCode == other.hashCode;

  @override
  int get hashCode => Object.hashAll([value.hashCode, key.hashCode]);

  bool hasSameValueAs(ResponsiveBreakpoint other) => other.value == value;
}
