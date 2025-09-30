import 'package:physical/system/international.dart';
import 'package:test/test.dart';

void main() {
  group('International', () {
    group('units', () {
      test('mass', () {
        expect(pound.scale, 16 * ounce.scale);
        expect(ounce.scale, 16 * dram.scale);
        expect(pound.scale, closeTo(7000 * grain.scale, 10e-10));
      });

      test('length', () {
        expect(mile.scale, 1760 * yard.scale);
        expect(yard.scale, closeTo(3 * foot.scale, 10e-10));
        expect(foot.scale, closeTo(12 * inch.scale, 10e-10));
      });
    });
  });
}
