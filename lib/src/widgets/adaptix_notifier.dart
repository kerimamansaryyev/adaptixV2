import 'package:adaptix/src/models/constraints.dart';
import 'package:adaptix/src/utils/assertions.dart';
import 'package:flutter/widgets.dart';

class Adaptix extends InheritedWidget {
  const Adaptix({required this.data, required super.child, super.key});

  final AdaptixConstraints data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is Adaptix && !oldWidget.data.isSameAs(data);
  }

  static AdaptixConstraints of(BuildContext context) {
    assert(debugCheckHasAdaptix(context));
    return context.dependOnInheritedWidgetOfExactType<Adaptix>()!.data;
  }

  static AdaptixConstraints? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Adaptix>()?.data;
  }
}
