import 'package:physical/units/international.dart' as intl;
import 'package:test/test.dart';

void main() {
  group('International', () {
    group('units', () {
      test('mass', () {
        expect(intl.pound.scale, 16 * intl.ounce.scale);
        expect(intl.ounce.scale, 16 * intl.dram.scale);
        expect(intl.pound.scale, closeTo(7000 * intl.grain.scale, 10e-10));
      });

      test('length', () {
        expect(intl.mile.scale, 1760 * intl.yard.scale);
        expect(intl.yard.scale, closeTo(3 * intl.foot.scale, 10e-10));
        expect(intl.foot.scale, closeTo(12 * intl.inch.scale, 10e-10));
      });
    });
  });
}
