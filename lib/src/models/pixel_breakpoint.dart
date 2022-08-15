import 'package:adaptix/src/models/breakpoint.dart';
import 'package:meta/meta.dart';

class ResponsivePixelValueBreakPoint extends SizeBreakPoint<double> {
  final double deviceWidth;
  final double pixelScale;

  const ResponsivePixelValueBreakPoint(
      {required this.deviceWidth, required this.pixelScale});

  @protected
  @override
  double get compareValue => deviceWidth;

  @protected
  @override
  double get returnValue => pixelScale;
}
