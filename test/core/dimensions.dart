import 'package:test/test.dart';
import 'package:physical/core.dart';

void main() {
  group('Dimensions', () {
    test('base dimensions', () {
      expect(Dimension.length.symbol, 'L');
      expect(Dimension.mass.symbol, 'M');
      expect(Dimension.time.symbol, 'T');
      expect(Dimension.temperature.symbol, 'K');
      expect(Dimension.electricCurrent.symbol, 'I');
      expect(Dimension.luminousIntensity.symbol, 'J');
      expect(Dimension.amountOfSubstance.symbol, 'N');
    });

    test('auxiliary base dimensions', () {
      expect(Dimension.angle.symbol, 'A');
      expect(Dimension.solidAngle.symbol, 'S');
    });

    test('constructors', () {
      const d1 = Dimensions.empty();
      expect(d1, isNotNull);

      const d2 = Dimensions.constant({Dimension.length: 2});
      expect(d2, isNotNull);
      expect(d2[Dimension.length], 2);

      final d3 = Dimensions({Dimension.time: -1});
      expect(d3, isNotNull);
      expect(d3[Dimension.time], -1);

      final d4 = Dimensions(d3.map);
      expect(d4, isNotNull);
      expect(d4[Dimension.time], -1);
    });

    test('equality', () {
      final d1 =
          Dimensions({Dimension.time: -1, Dimension.length: 1, Dimension.angle: 1, Dimension.amountOfSubstance: -2});

      final d2 =
          Dimensions({Dimension.angle: 1, Dimension.amountOfSubstance: -2, Dimension.time: -1, Dimension.length: 1});

      expect(d1 == d2, true);
      expect(d1 != d2, false);
      expect(d1 == d1, true);
      expect(d1 != d1, false);
    });

    test('equalsSI', () {
      final d1 =
          Dimensions({Dimension.time: -1, Dimension.length: 1, Dimension.angle: 1, Dimension.amountOfSubstance: -2});

      final d2 = Dimensions({Dimension.amountOfSubstance: -2, Dimension.time: -1, Dimension.length: 1});

      final d3 = Dimensions({
        Dimension.time: -1,
        Dimension.length: 1,
        Dimension.angle: 5,
        Dimension.amountOfSubstance: -2,
        Dimension.solidAngle: 3
      });

      expect(d1 == d2, false);
      expect(d1 == d3, false);
      expect(d2 == d3, false);
      expect(d1.equalsSI(d2), true);
      expect(d2.equalsSI(d1), true);
      expect(d1.equalsSI(d3), true);
      expect(d3.equalsSI(d1), true);
      expect(d2.equalsSI(d3), true);
      expect(d3.equalsSI(d2), true);
    });

    test('hashCode', () {
      final d1 =
          Dimensions({Dimension.time: -1, Dimension.length: 1, Dimension.angle: 1, Dimension.amountOfSubstance: -2});

      final d2 =
          Dimensions({Dimension.angle: 1, Dimension.amountOfSubstance: -2, Dimension.time: -1, Dimension.length: 1});

      final d3 = Dimensions({
        Dimension.time: -1,
        Dimension.length: 1,
        Dimension.angle: 5,
        Dimension.amountOfSubstance: -2,
        Dimension.solidAngle: 3
      });

      final testMap = <Dimensions, int>{};
      testMap[d1] = 1;
      testMap[d2] = 2;
      testMap[d3] = 3;

      expect(d1.hashCode == d2.hashCode, true);
      expect(d1.hashCode == d3.hashCode, false);
      expect(testMap.length, 2);
      expect(testMap[d1], 2);
    });

    test('operator *', () {
      final d1 =
          Dimensions({Dimension.time: -1, Dimension.length: 1, Dimension.angle: 1, Dimension.amountOfSubstance: -2});

      final d2 = Dimensions({Dimension.amountOfSubstance: 2, Dimension.time: -1, Dimension.length: 2});

      final d3 = Dimensions({Dimension.time: -2, Dimension.length: 3, Dimension.angle: 1});

      final d4 =
          Dimensions({Dimension.time: -2, Dimension.length: 2, Dimension.angle: 2, Dimension.amountOfSubstance: -4});

      final d5 = Dimensions.empty();

      expect(d1 * d2, d3);
      expect(d2 * d1, d3);
      expect(d1 * d1, d4);
      expect(d1 * d5, d1);
      expect(d5 * d1, d1);
    });

    test('operator /', () {
      final d1 =
          Dimensions({Dimension.time: -1, Dimension.length: 1, Dimension.angle: 1, Dimension.amountOfSubstance: -2});

      final d2 = Dimensions({Dimension.amountOfSubstance: 2, Dimension.time: -1, Dimension.length: 2});

      final d3 = Dimensions({Dimension.length: -1, Dimension.angle: 1, Dimension.amountOfSubstance: -4});

      final d4 = Dimensions({Dimension.length: 1, Dimension.angle: -1, Dimension.amountOfSubstance: 4});

      final d5 = Dimensions.empty();

      final d6 =
          Dimensions({Dimension.time: 1, Dimension.length: -1, Dimension.angle: -1, Dimension.amountOfSubstance: 2});

      expect(d1 / d2, d3);
      expect(d2 / d1, d4);
      expect(d1 / d1, d5);
      expect(d1 / d5, d1);
      expect(d5 / d1, d6);
    });

    test('operator ^', () {
      final d1 =
          Dimensions({Dimension.time: -1, Dimension.length: 1, Dimension.angle: 1, Dimension.amountOfSubstance: -2});

      final d2 = Dimensions({Dimension.amountOfSubstance: 2, Dimension.time: -1, Dimension.length: 2});

      final d3 = Dimensions({Dimension.length: -1, Dimension.angle: 1, Dimension.amountOfSubstance: -4});

      final d4 = Dimensions({Dimension.length: 1, Dimension.angle: -1, Dimension.amountOfSubstance: 4});

      final d5 = Dimensions.empty();

      final d6 =
          Dimensions({Dimension.time: 1, Dimension.length: -1, Dimension.angle: -1, Dimension.amountOfSubstance: 2});

      expect(d1 ^ 1, d1);
      expect(d1 ^ 0, d5);

      final d2Squared = d2 ^ 2;
      expect(d2Squared[Dimension.amountOfSubstance], 4);
      expect(d2Squared[Dimension.time], -2);
      expect(d2Squared[Dimension.length], 4);
      expect(d2Squared ^ 0.5, d2);

      final d3Inverse = d3 ^ -1;
      expect(d3Inverse[Dimension.length], 1);
      expect(d3Inverse[Dimension.angle], -1);
      expect(d3Inverse[Dimension.amountOfSubstance], 4);
      final d3InverseCubed = d3Inverse ^ 3;
      expect(d3InverseCubed[Dimension.length], 3);
      expect(d3InverseCubed[Dimension.angle], -3);
      expect(d3InverseCubed[Dimension.amountOfSubstance], 12);

      final d4Sqrt = d4 ^ 0.5;
      expect(d4Sqrt[Dimension.length], 0.5);
      expect(d4Sqrt[Dimension.angle], -0.5);
      expect(d4Sqrt[Dimension.amountOfSubstance], 2);
      expect(d4Sqrt ^ 2, d4);

      final d6Mod = d6 ^ -0.123;
      expect(d6Mod[Dimension.time], -0.123);
      expect(d6Mod[Dimension.length], 0.123);
      expect(d6Mod[Dimension.angle], 0.123);
      expect(d6Mod[Dimension.amountOfSubstance], -0.246);
    });

    test('inverse', () {
      final d1 = Dimensions({
        Dimension.time: 3,
        Dimension.length: 2,
        Dimension.angle: 1,
        Dimension.amountOfSubstance: 0,
        Dimension.temperature: -1,
        Dimension.mass: -2,
        Dimension.electricCurrent: -3,
        Dimension.luminousIntensity: -4,
        Dimension.solidAngle: -5
      });

      final d2 = Dimensions({
        Dimension.time: -3,
        Dimension.length: -2,
        Dimension.angle: -1,
        Dimension.amountOfSubstance: 0,
        Dimension.temperature: 1,
        Dimension.mass: 2,
        Dimension.electricCurrent: 3,
        Dimension.luminousIntensity: 4,
        Dimension.solidAngle: 5
      });

      final d3 = Dimensions.empty();

      expect(d1.inverse(), d2);
      expect(d2.inverse(), d1);
      expect(d3.inverse(), d3);
    });
  });
}
