import 'package:flutter/widgets.dart';

@immutable
class ResizableMixinConstraints {
  final double width;
  final double height;
  final Orientation orientation;

  const ResizableMixinConstraints({
    required this.height,
    required this.width,
    required this.orientation,
  });
}

mixin ResizableMixin<T extends StatefulWidget> on WidgetsBindingObserver {
  @protected
  Size getSize() {
    final window = WidgetsBinding.instance.window;
    return window.physicalSize / window.devicePixelRatio;
  }

  @protected
  double getWidth() => getSize().width;

  @protected
  double getHeight() => getSize().height;

  @protected
  Orientation getOrientation() {
    return getWidth() > getHeight()
        ? Orientation.landscape
        : Orientation.portrait;
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    onConstraintsChanged(
      ResizableMixinConstraints(
        height: getHeight(),
        width: getWidth(),
        orientation: getOrientation(),
      ),
    );
  }

  @protected
  void onConstraintsChanged(ResizableMixinConstraints constraints);
}
