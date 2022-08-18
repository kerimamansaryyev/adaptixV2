import 'package:adaptix/src/extensions/detect_breakpoint_extension.dart';
import 'package:adaptix/src/models/adaptix_configs.dart';
import 'package:adaptix/src/models/pixel_scale_configs.dart';
import 'package:adaptix/src/models/constraints.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:adaptix/src/utils/resizable_mixin.dart';
import 'package:adaptix/src/widgets/adaptix_notifier.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class AdaptixInitializer extends StatefulWidget with ArgsComparisonMixin {
  const AdaptixInitializer(
      {Key? key,
      this.configs = const AdaptixConfigs(
          pixelScaleConfigs: PixelScaleConfigs.defaultConfigs),
      required this.builder})
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

  void _setConstraints(
      {double? width, Orientation? orientation, bool forceSet = false}) {
    double scale;
    if (width != null) {
      scale = widget.configs.pixelScaleConfigs.breakpoints.detectPixelScale(
          width, widget.configs.pixelScaleConfigs.defaultPixelScale);
    } else {
      scale = _constraints.pixelScale;
    }
    final newConstraints = AdaptixConstraints(
        configs: widget.configs,
        pixelScale: scale,
        orientation: orientation ?? _constraints.orientation);
    if (forceSet || !newConstraints.isSameAs(_constraints)) {
      _constraints = newConstraints;
      setState(() {});
    }
  }

  double _getBreakpointSide() {
    switch (widget.configs.pixelScaleConfigs.deviceWidthSideStrategy) {
      case DeviceWidthSideStrategy.useShortestSide:
        return math.min(getWidth(), getHeight());
      case DeviceWidthSideStrategy.useOriginalWidth:
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
    _setConstraints(
        width: _getBreakpointSide(),
        orientation: getOrientation(),
        forceSet: true);
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
