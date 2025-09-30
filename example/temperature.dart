import 'package:physical/core.dart';
import 'package:physical/units.dart';
import 'package:physical/quantities.dart';

void main() {
  final tc = zerothDegreeCelsius + qty(0, degreeCelsius);
  // or tc = Temperature.degreesCelsius(0);
  final tf = zerothDegreeFahrenheit + qty(32, degreeFahrenheit);
  // or tf = Temperature.degreesFahrenheit(32);
  print(tc.deltaFromZero); // 273.15°C
  print(tf.deltaFromZero); // 491.66999999999996°F
  print(tc.deltaFromOrigin); // 0°C
  print(tf.deltaFromOrigin); // 0°F
  print(tc == tf);

  final tk = Temperature.kelvins(300);
  print(tk.deltaFromZero); // 300 K
  print(tk[degreeCelsius].deltaFromOrigin); // 300°C
  print(tk[degreeCelsius]
      .withOrigin(
        zerothDegreeCelsius,
      )
      .deltaFromOrigin); // 26.85°C

  print(tk[degreeCelsius].deltaFrom(
    zerothDegreeCelsius,
  ));

  print(tk[degreeCelsius] - zerothDegreeCelsius); // 26.85°C
}
