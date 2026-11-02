import 'package:physical/core.dart';
import 'package:physical/dimensions.dart';
import 'package:physical/units/si.dart';
import 'package:test/test.dart';

void main() {
  group('Quantity', () {
    test('toStringAsFixedNoTrailing drops the sign of a value that rounds to zero', () {
      expect(Quantity.of(-0.0, metre).toStringAsFixedNoTrailing(2), '0 m');
      expect(Quantity.of(-0.004, metre).toStringAsFixedNoTrailing(2), '0 m');
      expect(Quantity.of(-0.4, metre).toStringAsFixedNoTrailing(0), '0 m');
      expect(Quantity.of(-0.005, metre).toStringAsFixedNoTrailing(2), '-0.01 m');
      expect(Quantity.of(-0.6, metre).toStringAsFixedNoTrailing(0), '-1 m');
      expect(Quantity.of(-10, metre).toStringAsFixedNoTrailing(1), '-10 m');
    });

    test('toStringAsFixed drops the sign of a value that rounds to zero', () {
      expect(Quantity.of(-0.004, metre).toStringAsFixed(2), '0.00 m');
      expect(Quantity.of(-0.4, metre).toStringAsFixed(0), '0 m');
      expect(Quantity.of(-0.005, metre).toStringAsFixed(2), '-0.01 m');
      expect(Quantity.of(-0.004, metre).toNameStringAsFixed(2), '0.00 metres');
      expect((zerothDegreeCelsius + Quantity.of(-0.04, degreeCelsius)).toStringAsFixed(1), '0.0°C');
    });

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

  group('Quantity equality', () {
    test('holds across units, in both directions', () {
      final metres = Quantity.of(1, metre);
      final millimetres = Quantity.of(1000, metre.milli);

      expect(metres, millimetres);
      expect(millimetres, metres);
      expect(metres.hashCode, millimetres.hashCode);
      expect({metres, millimetres}, hasLength(1));
    });

    test('a scalar is not equal to the num it represents', () {
      const Object five = 5;

      expect(Quantity.of(5, Unit.one) == five, isFalse);
      expect(five == Quantity.of(5, Unit.one), isFalse);

      expect(Scalar.one(5) < 6, isTrue);
      expect(Scalar.one(5).value, 5);
    });

    test('mismatched dimensions are unequal rather than an error', () {
      final metres = Quantity.of(1, metre);
      final seconds = Quantity.of(1, second);

      expect(metres, isNot(seconds));
      expect([metres].contains(seconds), isFalse);
      expect(() => metres.compareTo(seconds), throwsA(isA<DimensionsException>()));
      expect(() => metres < seconds, throwsA(isA<DimensionsException>()));
    });
  });

  group('QuantityOrigin', () {
    test('equality compares the distance from absolute zero', () {
      expect(QuantityOrigin(Quantity.of(273.15, kelvin)), zerothDegreeCelsius);
      expect(QuantityOrigin(Quantity.of(255.372, kelvin)), isNot(zerothDegreeCelsius));
    });

    test('isZero', () {
      expect(absoluteZeroKelvin.isZero, isTrue);
      expect(QuantityOrigin.zero(temperature).isZero, isTrue);
      expect(zerothDegreeCelsius.isZero, isFalse);
    });

    test('toString', () {
      expect(zerothDegreeCelsius.toString(), '273.15 K');
    });
  });

  group('QuantityPoint equality', () {
    test('holds across units and origins', () {
      final celsius = zerothDegreeCelsius + Quantity.of(20, degreeCelsius);
      final kelvins = absoluteZeroKelvin + Quantity.of(293.15, kelvin);

      expect(celsius, kelvins);
      expect(kelvins, celsius);
      expect(celsius.hashCode, kelvins.hashCode);
      expect({celsius, kelvins}, hasLength(1));
    });

    test('mismatched dimensions are unequal rather than an error', () {
      final degrees = zerothDegreeCelsius + Quantity.of(20, degreeCelsius);
      final distance = QuantityOrigin.zero(length) + Quantity.of(20, metre);

      expect(degrees, isNot(distance));
    });
  });

  group('QuantityPoint', () {
    test('toString omits an origin the unit implies', () {
      expect((zerothDegreeCelsius + Quantity.of(20, degreeCelsius)).toString(), '20°C');
      expect((absoluteZeroKelvin + Quantity.of(293.15, kelvin)).toString(), '293.15 K');
      expect((QuantityOrigin.zero(temperature) + Quantity.of(293.15, kelvin)).toString(), '293.15 K');
    });

    test('toString shows an origin the unit does not imply', () {
      final point = zerothDegreeCelsius + Quantity.of(20, degreeCelsius);

      expect(point.inUnits(kelvin).toString(), '20 K @ 273.15 K');
    });

    test('toStringAsFixed', () {
      final point = zerothDegreeCelsius + Quantity.of(20.456, degreeCelsius);

      expect(point.toStringAsFixed(1), '20.5°C');
      expect(point.toStringAsFixedNoTrailing(5), '20.456°C');
      expect(point.inUnits(kelvin).toStringAsFixed(0), '20 K @ 273 K');
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
