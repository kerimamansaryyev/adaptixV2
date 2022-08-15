import 'package:adaptix/adaptix.dart';
import 'package:flutter_test/flutter_test.dart';

class TestSizeBreakPoint extends SizeBreakPoint {
  @override
  final double compareValue;

  @override
  Null get returnValue => null;

  const TestSizeBreakPoint(
      {required this.compareValue, required super.debugLabel})
      : super();
}

void main() {
  group('Testing breakpoints', () {
    test('Ascending sort', () {
      final breakPoints = <TestSizeBreakPoint>[
        const TestSizeBreakPoint(compareValue: 200, debugLabel: 'two'),
        const TestSizeBreakPoint(compareValue: 100, debugLabel: 'one'),
        const TestSizeBreakPoint(compareValue: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => b.compareTo(a));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['one', 'two', 'three']);
      breakPoints.sort((a, b) => a.compareTo(b));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['three', 'two', 'one']);
    });
    test('Descening sort', () {
      final breakPoints = <TestSizeBreakPoint>[
        const TestSizeBreakPoint(compareValue: 200, debugLabel: 'two'),
        const TestSizeBreakPoint(compareValue: 100, debugLabel: 'one'),
        const TestSizeBreakPoint(compareValue: 300, debugLabel: 'three'),
      ];
      breakPoints.sort((a, b) => a.compareTo(b));
      expect(breakPoints.map((e) => e.debugLabel).toList(),
          ['three', 'two', 'one']);
    });
    test('Equality', () {
      const a = TestSizeBreakPoint(compareValue: 2, debugLabel: 'a');
      const b = TestSizeBreakPoint(compareValue: 2, debugLabel: 'b');
      const c = TestSizeBreakPoint(compareValue: 3, debugLabel: 'c');
      expect(a == b, true);
      expect(a == c, false);
      ;
    });
  });
}
