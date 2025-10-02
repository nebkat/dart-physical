import 'package:physical/core.dart';
import 'package:physical/dimensions.dart';
import 'package:physical/units/si.dart' as si;
import 'package:test/test.dart';

void main() {
  group('Unit', () {
    test('dimensions', () {
      final a = AnonymousUnit(scale: 1, dimensions: length);

      expect(a.dimensions, length);
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
      expect(a.inverse().dimensions, length.inverse());

      expect(((a * a) / a).dimensions, a.dimensions);
      expect(((a * a * a) / a / a).dimensions, a.dimensions);

      final b = AnonymousUnit(scale: 3, dimensions: time);
      expect((a * b).dimensions, length * time);
      expect((b * a).dimensions, length * time);
      expect((a / b).dimensions, length / time);
      expect((b / a).dimensions, time / length);
    });

    test('scale', () {
      final a = AnonymousUnit(scale: 4, dimensions: dimensionless);

      expect(a.scale, 4);
      expect((a ^ 3).scale, 64);
      expect((a ^ 2).scale, 16);
      expect((a ^ 0).scale, 1);
      expect((a ^ 0.5).scale, 2);
      expect((a ^ -0.5).scale, 1 / 2);
      expect((a ^ -1).scale, 1 / 4);
      expect((a ^ -2).scale, 1 / 16);
      expect((a ^ -3).scale, 1 / 64);
      expect(a.squared().scale, 16);
      expect(a.cubed().scale, 64);

      expect(((a * a) / a).scale, a.scale);
      expect(((a * a * a) / a / a).scale, a.scale);

      final b = AnonymousUnit(scale: 2, dimensions: dimensionless);
      expect((a * b).scale, 8);
      expect((b * a).scale, 8);
      expect((a / b).scale, 2);
      expect((b / a).scale, 0.5);
    });

    test('prefix', () {
      // TODO: More precise?
      const double epsilon = 1E-20;

      expect(si.metre.yotta.scale, closeTo(1.0e24, epsilon));
      expect(si.metre.zetta.scale, closeTo(1.0e21, epsilon));
      expect(si.metre.exa.scale, closeTo(1.0e18, epsilon));
      expect(si.metre.peta.scale, closeTo(1.0e15, epsilon));
      expect(si.metre.tera.scale, closeTo(1.0e12, epsilon));
      expect(si.metre.giga.scale, closeTo(1.0e9, epsilon));
      expect(si.metre.mega.scale, closeTo(1.0e6, epsilon));
      expect(si.metre.kilo.scale, closeTo(1.0e3, epsilon));
      expect(si.metre.hecto.scale, closeTo(1.0e2, epsilon));
      expect(si.metre.deca.scale, closeTo(1.0e1, epsilon));
      expect(si.metre.scale, closeTo(1.0e0, epsilon));
      expect(si.metre.deci.scale, closeTo(1.0e-1, epsilon));
      expect(si.metre.centi.scale, closeTo(1.0e-2, epsilon));
      expect(si.metre.milli.scale, closeTo(1.0e-3, epsilon));
      expect(si.metre.micro.scale, closeTo(1.0e-6, epsilon));
      expect(si.metre.nano.scale, closeTo(1.0e-9, epsilon));
      expect(si.metre.pico.scale, closeTo(1.0e-12, epsilon));
      expect(si.metre.femto.scale, closeTo(1.0e-15, epsilon));
      expect(si.metre.atto.scale, closeTo(1.0e-18, epsilon));
      expect(si.metre.zepto.scale, closeTo(1.0e-21, epsilon));
      expect(si.metre.yocto.scale, closeTo(1.0e-24, epsilon));

      expect(si.gram.yotta.scale, closeTo(1.0e21, epsilon));
      expect(si.gram.zetta.scale, closeTo(1.0e18, epsilon));
      expect(si.gram.exa.scale, closeTo(1.0e15, epsilon));
      expect(si.gram.peta.scale, closeTo(1.0e12, epsilon));
      expect(si.gram.tera.scale, closeTo(1.0e9, epsilon));
      expect(si.gram.giga.scale, closeTo(1.0e6, epsilon));
      expect(si.gram.mega.scale, closeTo(1.0e3, epsilon));
      expect(si.gram.kilo.scale, closeTo(1.0e0, epsilon));
      expect(si.gram.hecto.scale, closeTo(1.0e-1, epsilon));
      expect(si.gram.deca.scale, closeTo(1.0e-2, epsilon));
      expect(si.gram.scale, closeTo(1.0e-3, epsilon));
      expect(si.gram.deci.scale, closeTo(1.0e-4, epsilon));
      expect(si.gram.centi.scale, closeTo(1.0e-5, epsilon));
      expect(si.gram.milli.scale, closeTo(1.0e-6, epsilon));
      expect(si.gram.micro.scale, closeTo(1.0e-9, epsilon));
      expect(si.gram.nano.scale, closeTo(1.0e-12, epsilon));
      expect(si.gram.pico.scale, closeTo(1.0e-15, epsilon));
      expect(si.gram.femto.scale, closeTo(1.0e-18, epsilon));
      expect(si.gram.atto.scale, closeTo(1.0e-21, epsilon));
      expect(si.gram.zepto.scale, closeTo(1.0e-24, epsilon));
      expect(si.gram.yocto.scale, closeTo(1.0e-27, epsilon));
    });
  });
}
