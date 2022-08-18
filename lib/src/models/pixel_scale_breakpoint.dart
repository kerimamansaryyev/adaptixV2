import 'package:adaptix/src/models/breakpoint.dart';
import 'package:meta/meta.dart';

class ResponsivePixelScaleBreakpoint extends SizeBreakpoint<double> {
  final double deviceWidth;
  final double pixelScale;

  const ResponsivePixelScaleBreakpoint(
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
