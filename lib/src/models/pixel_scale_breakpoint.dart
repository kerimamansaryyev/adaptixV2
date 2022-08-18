import 'package:adaptix/src/models/breakpoint.dart';
import 'package:meta/meta.dart';

class ResponsivePixelScaleBreakPoint extends SizeBreakPoint<double> {
  final double deviceWidth;
  final double pixelScale;

  const ResponsivePixelScaleBreakPoint(
      {required this.deviceWidth, required this.pixelScale, super.debugLabel});

  @protected
  @override
  double get compareValue => deviceWidth;

  @protected
  @override
  double get returnValue => pixelScale;

  @override
  int getHashCode() => deviceWidth.hashCode;
}
