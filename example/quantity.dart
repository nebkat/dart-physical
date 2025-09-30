import 'package:physical/core.dart';
import 'package:physical/quantities.dart';
import 'package:physical/system/si.dart' as si;

void main() {
  construction();
  print("");
  basicArithmetic();
  print("");
  advancedArithmetic();
  print("");
  properties();
}

void construction() {
  // Generic constructor
  final a = Quantity.of(3, si.metre);
  // Convenience function
  final b = qty(3, si.metre);
  // Explicit dimension
  final c = Length.of(3, si.metre);
  // Implicit dimension
  final d = qty(3, si.metre) as Length;

  print("Construction:");
  print("$a | $b | $c | $d");
  print(a == b && b == c && c == d);
  print("${a.runtimeType} == ${c.runtimeType}");
}

void basicArithmetic() {
  final a = Length.of(4, si.metre);
  final b = Length.of(3, si.metre);
  final c = a + b; // 7 m
  final d = a - b; // 1 m
  final e = a * 2; // 8 m
  final f = a / 2; // 2.0 m

  print("Basic arithmetic:");
  print("$a + $b = $c");
  print("$a - $b = $d");
  print("$a * 2 = $e");
  print("$a / 2 = $f");
}

void advancedArithmetic() {
  final a = Voltage.of(8, si.volt);
  final b = Resistance.of(2, si.ohm);
  final c = Current(a / b)[si.ampere]; // 4 A
  final d = Power(a * c)[si.watt]; // 32 W
  final e = Power((a ^ 2) / b)[si.watt]; // 32 W

  print("Advanced arithmetic:");
  print("$a / $b = $c");
  print("$a * $c = $d");
  print("($a)^2 / $b = $e");
}

void properties() {
  final a = Energy.of(5.672, si.wattHour);
  final b = a[si.joule];
  final c = Scalar.percent(-3);

  void printProperties(Quantity q, String name) {
    print("$name:");
    print(" dimensions = ${q.dimensions}");
    print(" unit = ${q.unit}");
    print(" value = ${q.value}");
    print(" isScalar = ${q.isScalar}");
    print(" sign = ${q.sign}");
    print(" inverse() = ${q.inverse()}");
    print(" abs() = ${q.abs()}");
    print(" round() = ${q.round()}");
  }

  print("Properties:");
  printProperties(a, 'a');
  printProperties(b, 'b');
  printProperties(c, 'c');
}
