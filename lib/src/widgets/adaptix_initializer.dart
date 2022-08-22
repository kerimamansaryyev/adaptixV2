import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/adaptix_constraints.dart';
import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:adaptix/src/utils/resizable_mixin.dart';
import 'package:adaptix/src/extensions/breakpoint.dart';
import 'package:adaptix/src/widgets/adaptix.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class AdaptixInitializer extends StatefulWidget with ArgsComparisonMixin {
  const AdaptixInitializer(
      {Key? key, required this.configs, required this.builder})
      : super(key: key);

  final AdaptixConfigs configs;
  final WidgetBuilder builder;

  @override
  State<AdaptixInitializer> createState() => _AdaptixInitializerState();

  @override
  bool isSameAs(ArgsComparisonMixin other) {
    return other is AdaptixInitializer && other.configs.isSameAs(configs);
  }
}

class _AdaptixInitializerState extends State<AdaptixInitializer>
    with WidgetsBindingObserver, ResizableMixin {
  late AdaptixConstraints _constraints;

  void _setConstraints({double? width, bool forceSet = false}) {
    ResponsiveBreakpoint breakpoint;
    if (width != null) {
      breakpoint = widget.configs.breakpoints.detectBreakpoint(width);
    } else {
      breakpoint = _constraints.breakpoint;
    }
    final newConstraints = AdaptixConstraints(
        configs: widget.configs,
        breakpoint: breakpoint,
        orientation: getOrientation());
    if (forceSet || !newConstraints.isSameAs(_constraints)) {
      _constraints = newConstraints;
      setState(() {});
    }
  }

  double _getBreakpointSide() {
    switch (widget.configs.strategy) {
      case DeviceBreakpointDecisionStrategy.useShortestSide:
        return math.min(getWidth(), getHeight());
      case DeviceBreakpointDecisionStrategy.useOriginalWidth:
        return getWidth();
    }
  }

  @override
  void didUpdateWidget(covariant AdaptixInitializer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.configs.isSameAs(widget.configs)) {
      _setConstraints(width: _getBreakpointSide());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setConstraints(width: _getBreakpointSide(), forceSet: true);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Adaptix(data: _constraints, child: Builder(builder: widget.builder));
  }

  @override
  void onConstraintsChanged(ResizableMixinConstraints constraints) {
    _setConstraints(width: _getBreakpointSide());
  }
}
