import 'adaptix_configs_test.dart' as adaptix_configs_test;
import 'adaptix_constraints_test.dart' as adaptix_constraints_test;
import 'breakpoint_test.dart' as breakpoint_test;
import 'generic_switch/generic_switch_unit_test.dart'
    as generic_switch_unit_test;
import 'device_detection_test.dart' as device_detection_test;

void main() {
  adaptix_configs_test.main();
  adaptix_constraints_test.main();
  breakpoint_test.main();
  generic_switch_unit_test.main();
  device_detection_test.main();
}
