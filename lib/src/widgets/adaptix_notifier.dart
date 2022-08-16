import 'package:adaptix/src/models/data.dart';
import 'package:flutter/widgets.dart';

class Adaptix extends InheritedWidget {
  const Adaptix({required this.data, required super.child, super.key});

  final AdaptixConstraints data;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is Adaptix && !oldWidget.data.isSameAs(data);
  }
}
