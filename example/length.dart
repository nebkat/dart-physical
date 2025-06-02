import 'package:physical/physical.dart';

void main() {
  print("=== Simple ===");
  final a = Length(3, metre);
  final b = Length.metres(4); // Convenience constructor
  print(a + b); // 7 m
  print(b - a); // 1 m

  print("\n=== Conversions ===");
  final c = Length(5000, metre.milli);
  print(c); // 5000 mm
  print(c.inUnits(foot).toStringAsFixed(4)); // 16.4042 ft

  print("\n=== Arithmetic ===");
  final hypotenuse = ((a ^ 2) + (b ^ 2)).sqrt();
  print(hypotenuse); // 5.0 [m²]⁰˙⁵
  print(hypotenuse.inUnits(metre)); // 5.0 m
  print(c == hypotenuse); // true! Units are automatically converter for comparison
}
