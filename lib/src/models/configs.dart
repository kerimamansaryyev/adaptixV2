import 'package:adaptix/src/models/breakpoint.dart';
import 'package:adaptix/src/models/pixel_breakpoint.dart';
import 'package:meta/meta.dart';

@immutable
class AdaptixConfigs {
  final List<ResponsivePixelValueBreakPoint> widthBreakPoints;

  const AdaptixConfigs({required this.widthBreakPoints});
}
