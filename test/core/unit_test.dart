import 'package:physical/dimensions.dart';
import 'package:test/test.dart';
import 'package:physical/core.dart';

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
  });
}
