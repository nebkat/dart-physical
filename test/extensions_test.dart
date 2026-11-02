import 'package:physical/extensions.dart';
import 'package:test/test.dart';

void main() {
  test('toStringAsFixedNoNegativeZero drops the sign of a value that rounds to zero', () {
    expect((-0.0).toStringAsFixedNoNegativeZero(0), '0');
    expect((-0.004).toStringAsFixedNoNegativeZero(2), '0.00');
    expect((-0.005).toStringAsFixedNoNegativeZero(2), '-0.01');
    expect((-10.0).toStringAsFixedNoNegativeZero(1), '-10.0');
  });

  test('toStringAsFixedNoTrailing drops the sign of a value that rounds to zero', () {
    expect((-0.004).toStringAsFixedNoTrailing(2), '0');
    expect((-0.0104).toStringAsFixedNoTrailing(3), '-0.01');
  });
}
