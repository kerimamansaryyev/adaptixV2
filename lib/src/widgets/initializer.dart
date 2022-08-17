import 'package:adaptix/src/extensions/detect_breakpoint_extension.dart';
import 'package:adaptix/src/models/configs.dart';
import 'package:adaptix/src/models/constraints.dart';
import 'package:adaptix/src/utils/comparable.dart';
import 'package:adaptix/src/widgets/adaptix_notifier.dart';
import 'package:flutter/material.dart';

class AdaptixInitializer extends StatefulWidget with StraighComparisonMixin {
  const AdaptixInitializer(
      {Key? key,
      this.configs = AdaptixConfigs.defaultConfigs,
      required this.builder})
      : super(key: key);

  final AdaptixConfigs configs;
  final WidgetBuilder builder;

  @override
  State<AdaptixInitializer> createState() => _AdaptixInitializerState();

  @override
  bool isSameAs(StraighComparisonMixin other) {
    return other is AdaptixInitializer && other.configs.isSameAs(configs);
  }
}

class _AdaptixInitializerState extends State<AdaptixInitializer>
    with WidgetsBindingObserver {
  late AdaptixConstraints _constraints;

  void _setConstraints({double? width, Orientation? orientation}) {
    double scale;
    if (width != null) {
      scale = widget.configs.breakpoints
          .detectPixelScale(width, widget.configs.defaultPixelScale);
    } else {
      scale = _constraints.pixelScale;
    }
    _constraints = AdaptixConstraints(
        configs: widget.configs,
        pixelScale: scale,
        orientation: orientation ?? _constraints.orientation);
  }

  double _getWidth() {
    final window = WidgetsBinding.instance.window;
    return (window.physicalSize / window.devicePixelRatio).width;
  }

  double _getHeight() {
    final window = WidgetsBinding.instance.window;
    return (window.physicalSize / window.devicePixelRatio).height;
  }

  Orientation _getOrientation() {
    final Orientation orientation = _getWidth() > _getHeight()
        ? Orientation.landscape
        : Orientation.portrait;
    return orientation;
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    _setConstraints(width: _getWidth());
  }

  @override
  void didUpdateWidget(covariant AdaptixInitializer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.configs.isSameAs(widget.configs)) {
      _setConstraints(width: _getWidth());
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setConstraints(width: _getWidth(), orientation: _getOrientation());
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
}
