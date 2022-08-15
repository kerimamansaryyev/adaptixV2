import 'package:adaptix/adaptix.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Testing breakpoints', () {
    test('Ascending sort', () {
      final breakPoints = <SizeBreakPoint>[
        const SizeBreakPoint(value: 200, debugLabel: 'two'),
        const SizeBreakPoint(value: 100, debugLabel: 'one'),
        const SizeBreakPoint(value: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => b.compareTo(a));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['one', 'two', 'three']);
      breakPoints.sort((a, b) => a.compareTo(b));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['three', 'two', 'one']);
    });
    test('Descening sort', () {
      final breakPoints = <SizeBreakPoint>[
        const SizeBreakPoint(value: 200, debugLabel: 'two'),
        const SizeBreakPoint(value: 100, debugLabel: 'one'),
        const SizeBreakPoint(value: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => a.compareTo(b));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['three', 'two', 'one']);
    });
    test('Equality', () {
      const a = SizeBreakPoint(value: 2, debugLabel: 'a');
      const b = SizeBreakPoint(value: 2, debugLabel: 'b');
      const c = SizeBreakPoint(value: 3, debugLabel: 'c');
      expect(a == b, true);
      expect(a == c, false);
      ;
    });
  });
}
