import 'package:physical/core.dart';
import 'package:physical/quantities.dart';
import 'package:physical/system/si.dart' as si;
import 'package:physical/system/international.dart' as intl;
import 'package:physical/system/usc.dart' as usc;

void main() {
  construction();
  print("==============================");
  basicArithmetic();
  print("==============================");
  advancedArithmetic();
  print("==============================");
  conversions();
  print("==============================");
  temperature();
  print("==============================");
  properties();
}

void construction() {
  // Generic constructor
  final a = Quantity.of(3, si.metre);
  // Convenience function
  final b = qty(3, si.metre);
  // Explicit dimension
  final c = Length.of(3, si.metre);
  // Checked cast
  final d = Length(qty(3, si.metre));
  // Unchecked cast
  final e = qty(3, si.metre) as Length;

  print("Construction:");
  print("$a | $b | $c | $d | $e");
  print(a == b && b == c && c == d && d == e);
  print("${a.runtimeType} == ${c.runtimeType}");
}

void basicArithmetic() {
  final a = Length.of(3, si.metre);
  final b = Length.of(4, si.metre);

  print("Basic arithmetic:");
  print("$a + $b = ${a + b}"); // 3 m + 4 m = 7 m
  print("$b - $a = ${a - b}"); // 3 m - 4 m = -1 m
  print("$a * 2 = ${a * 2}"); // 3 m * 2 = 6 m
  print("$a / 2 = ${a / 2}"); // 3 m / 2 = 1.5 m
  print("($a)² + ($b)² = (${((a ^ 2) + (b ^ 2)).sqrt()[si.metre]})²"); // (3 m)² + (4 m)² = (5.0 m)²
}

void conversions() {
  final l = Length.of(1, intl.mile);
  for (final unit in [intl.inch, intl.foot, intl.yard, si.metre, si.metre.kilo, intl.nauticalMile]) {
    print("$l = ${l[unit]}");
  }
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
  print("($a)² / $b = $e");
}

void temperature() {
  final tc = si.zerothDegreeCelsius + qty(0, si.degreeCelsius);
  // or tc = Temperature.degreesCelsius(0);
  final tf = usc.zerothDegreeFahrenheit + qty(32, usc.degreeFahrenheit);
  // or tf = Temperature.degreesFahrenheit(32);
  print("Temperature:");
  print(tc.deltaFromZero); // 273.15°C
  print(tf.deltaFromZero); // 491.66999999999996°F
  print(tc.deltaFromOrigin); // 0°C
  print(tf.deltaFromOrigin); // 0°F
  print(tc == tf);

  final tk = Temperature.kelvins(300);
  print(tk.deltaFromZero); // 300 K
  print(tk[si.degreeCelsius].deltaFromOrigin); // 300°C
  print(tk[si.degreeCelsius]
      .withOrigin(
        si.zerothDegreeCelsius,
      )
      .deltaFromOrigin); // 26.85°C

  print(tk[si.degreeCelsius].deltaFrom(
    si.zerothDegreeCelsius,
  )); // 26.85°C

  print(tk[si.degreeCelsius] - si.zerothDegreeCelsius); // 26.85°C
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
