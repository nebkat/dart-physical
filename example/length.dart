import 'package:physical/physical.dart';
import 'package:physical/system/si.dart' as si;
import 'package:physical/system/international.dart' as intl;

void main() {
  print("=== Simple ===");
  final a = Length.of(3, si.metre);
  final b = Length.of(4, si.metre); // Convenience constructor
  print(a + b); // 7 m
  print(b - a); // 1 m

  print("\n=== Conversions ===");
  final c = Length.of(5000, si.metre.milli);
  print(c); // 5000 mm
  print(c[intl.foot].toStringAsFixed(4)); // 16.4042 ft

  print("\n=== Arithmetic ===");
  final double = a * 11;
  print(double); // 33 m
  final hypotenuse = Length(((a ^ 2) + (b ^ 2)).sqrt());
  print(hypotenuse); // 5.0 [m²]⁰˙⁵
  print(hypotenuse[si.metre]); // 5.0 m
  print(c == hypotenuse); // true! Units are automatically converted for comparison
}
