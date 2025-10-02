import 'package:physical/core.dart';
import 'package:physical/dimensions.dart';
import 'package:physical/units/si.dart';
import 'package:test/test.dart';

void main() {
  group('Quantity', () {
    test('dimensions', () {
      final a = Quantity.of(1, metre);

      expect(a.dimensions, length);

      expect((a + a).dimensions, length);
      expect((a - a).dimensions, length);
      expect((a * 1).dimensions, length);
      expect((a * 2).dimensions, length);
      expect((a / 1).dimensions, length);
      expect((a / 2).dimensions, length);

      expect((a * a).dimensions, area);
      expect((a / a).dimensions, dimensionless);
      expect((a ^ 3).dimensions, volume);
      expect((a ^ 2).dimensions, area);
      expect((a ^ 1).dimensions, length);
      expect((a ^ 0.5).dimensions, length ^ 0.5);
      expect((a ^ 0).dimensions, dimensionless);
      expect((a ^ -0.5).dimensions, length ^ -0.5);
      expect((a ^ -1).dimensions, length.inverse());
      expect((a ^ -2).dimensions, area.inverse());
      expect((a ^ -3).dimensions, volume.inverse());
      expect(a.squared().dimensions, area);
      expect(a.cubed().dimensions, volume);
      expect(a.sqrt().dimensions, length ^ 0.5);
      expect(a.inverse().dimensions, length.inverse());

      expect(((a * a) / a).dimensions, a.dimensions);
      expect(((a * a * a) / a / a).dimensions, a.dimensions);

      final b = Quantity.of(1, second);
      expect((a * b).dimensions, length * time);
      expect((b * a).dimensions, length * time);
      expect((a / b).dimensions, length / time);
      expect((b / a).dimensions, time / length);
    });

    test('units', () {
      final a = Quantity.of(1, metre);

      expect(a.unit, metre);

      expect((a + a).unit, metre);
      expect((a - a).unit, metre);
      expect((a * 1).unit, metre);
      expect((a * 2).unit, metre);
      expect((a / 1).unit, metre);
      expect((a / 2).unit, metre);

      expect((a ^ 3).unit, metre ^ 3);
      expect((a ^ 2).unit, metre ^ 2);
      expect((a ^ 0).unit, metre ^ 0);
      expect((a ^ 0.5).unit, metre ^ 0.5);
      expect((a ^ -0.5).unit, metre ^ -0.5);
      expect((a ^ -1).unit, metre ^ -1);
      expect((a ^ -2).unit, metre ^ -2);
      expect((a ^ -3).unit, metre ^ -3);
      expect(a.squared().unit, metre.squared());
      expect(a.cubed().unit, metre.cubed());

      expect(((a * a) / a).unit, a.unit);
      expect(((a * a * a) / a / a).unit, a.unit);

      final b = Quantity.of(1, second);
      expect((a * b).unit, metre * second);
      expect((b * a).unit, metre * second);
      expect((a / b).unit, metre / second);
      expect((b / a).unit, second / metre);
    });
  });

  group('numToScalar', () {
    test('converts int and double to Scalar', () {
      final s1 = numToScalar(5);
      final s2 = numToScalar(3.14);

      expect(s1, isA<Scalar>());
      expect(s2, isA<Scalar>());
      expect(s1.value, 5);
      expect(s2.value, 3.14);
    });

    test('returns same Scalar if already Scalar', () {
      final s = Scalar.one(42);
      expect(numToScalar(s), same(s));
    });

    test('returns same Quantity if already Quantity', () {
      final q = Quantity.of(10, metre);
      expect(numToScalar(q), same(q));
    });

    test('throws on unsupported type', () {
      expect(() => numToScalar('string'), throwsA(isA<QuantityException>()));
      expect(() => numToScalar(true), throwsA(isA<QuantityException>()));
    });
  });

  group('scalarToNum', () {
    test('converts Scalar to num', () {
      final s1 = Scalar.one(5);
      final s2 = Scalar.one(3.14);

      expect(scalarToNum(s1), 5);
      expect(scalarToNum(s2), 3.14);
    });

    test('returns num as is', () {
      expect(scalarToNum(10), 10);
      expect(scalarToNum(2.71), 2.71);
    });

    test('throws on non-scalar Quantity', () {
      final q = Quantity.of(10, metre);
      expect(() => scalarToNum(q), throwsA(isA<DimensionsException>()));
    });

    test('throws on unsupported type', () {
      expect(() => scalarToNum('string'), throwsA(isA<QuantityException>()));
      expect(() => scalarToNum(true), throwsA(isA<QuantityException>()));
    });
  });
}
