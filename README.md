physical
========
A lightweight Dart library for dealing with physical quantities, units, and conversions.

Originally based on the [quantity](https://github.com/cooler-king/quantity) package by [cooler-king](https://github.com/cooler-king).

[![pub package](https://img.shields.io/pub/v/physical.svg)](https://pub.dev/packages/physical) [![package:physical](https://github.com/nebkat/dart-physical/actions/workflows/physical.yml/badge.svg)](https://github.com/nebkat/dart-physical/actions/workflows/physical.yml) [![Coverage Status](https://coveralls.io/repos/github/nebkat/dart-physical/badge.svg)](https://coveralls.io/github/nebkat/dart-physical)

- Unit conversions (e.g. millimetres to inches)
- Arithmetic operations (e.g. speed = distance / time)
- Optional compile-time type-safe quantities (e.g. `Length`, `Time`, `Speed`)
- Support for temperature conversions (i.e. Celsius, Fahrenheit, Kelvin)
- Text output with correct unit symbols
- Extensible with custom units and dimensions
- Easy to use, intuitive API
- Zero dependencies

The entire core library (excluding unit definitions) is under 1k LOC so the easiest way to learn is
to have a look at the [source code](https://github.com/nebkat/dart-physical).

# Usage

```bash
dart pub add physical
```

```dart
import 'package:physical/physical.dart';
import 'package:physical/system/si.dart' as si;

// ----- UNCHECKED -----

final length   = qty(100, si.metre);       // 100 m
final time     = qty(20, si.second);       // 20 s
final speed    = length / time;            // 5 m/s
final distance = speed * qty(2, si.hour);  // 36000 m

// ----- CHECKED -----

final length   = Length.of(100, si.metre); // 100 m
final time     = Time.of(20, si.second);   // 20 s
final speed    = Speed(length / time);     // 5 m/s
final distance = Length(speed * Time.of(2, si.hour)); // 36000 m

// ----- UNIT CONVERSION -----

print(s[si.metre.kilo / si.hour]); // 18.0 km/h
print(d[si.metre.kilo].value);     // 36.0

// ----- SAFETY -----

final invalid = l + t;        // 🚫 throws
final invalid = l[si.second]; // 🚫 throws
final invalid = Time(l);      // 🚫 throws
```

# Background
Representing physical quantities in code can be tricky, especially when it comes to unit conversions.
Hardcoding `const feetToMillimetres = 304.8;` only gets you so far and before you know it you've
accidentally divided a constant instead of multiplying. Best case scenario, your user sees the wrong
number - worst case your [$327.6 million spacecraft gets destroyed](https://en.wikipedia.org/wiki/Mars_Climate_Orbiter#Cause_of_failure).

On the other hand, quantity and unit safety shouldn't come at the cost of usability, readability or
performance. Many libraries have attempted to solve this problem with complex class hierarchies
defining every possible combination of quantity and unit, leading to bloated APIs that fall short
as soon as you find yourself outside of this predefined set of supported quantities.

`physical` aims to strike a balance between these two extremes by providing a simple yet powerful
API allowing you to define and manipulate physical quantities with ease, while still providing a
degree of safety through runtime checks.

# Core Concepts
- `Dimensions`: Represent the physical nature of a quantity (e.g. Length, Time, Speed).
- `Units`: Represent a specific measurement standard for a dimension (e.g. Metre, Second, Kilometre per Hour).
- `Quantity`: Represents a numerical value associated with a unit (and therefore a dimension).
- `QuantityPoint`: Represents a numerical value relative to an origin point (e.g. Temperature).

In short:
- Quantities are immutable objects combining a numerical value and a unit.
- Moving from raw numbers to quantities is as easy as wrapping them in a Quantity object:
  - `Quantity.of(value, unit)`
  - `qty(value, unit)` (helper function)
  - `Length.of(value, unit)`
  - `Length(quantity)`
- Quantities can be freely multiplied and divided by other quantities, creating derived units as necessary.
  - `qty(10, metre) / qty(2, second)` creates a `qty(5, metre / second)`
- Quantities can only be added and subtracted with other quantities of the same dimension .
  - `qty(10, metre) + qty(5, metre)` is valid
  - `qty(10, metre) + qty(5, second)` throws an error
- Quantities can only be converted to other units of the same dimension.
  - `qty(1000, metre)[metre.kilo]` is valid
  - `qty(1000, metre)[second]` throws an error
- Moving from quantities back to raw numbers should always be done with an explicit conversion:
  - `myFunction(metres: d[metre].value)`

## Dimensions
`Dimensions` represent the physical nature of a quantity, made up of a combination of the base dimensions, namely:

SI:
- Length (L)
- Mass (M)
- Time (T)
- Temperature (K)
- Electric Current (I)
- Luminous Intensity (J)
- Amount of Substance (N)

Non-SI:
- Angle (A)
- Solid Angle (S)

Most common dimensions are already provided by the library:
```dart
// Provided in 'package:physical/quantities.dart'
const dimensionless = Dimensions.empty();
const length = Dimensions.constant({Dimension.length: 1}); // L
const time = Dimensions.constant({Dimension.time: 1});     // T
const speed = Dimensions.constant({Dimension.length: 1, Dimension.time: -1}); // L T^-1
```

At runtime, dimensions can be derived by combining existing ones using natural arithmetic operators:
```dart
final acceleration = length / (time ^ 2); // L T^-2
```

Lastly, dimensions can be compared for equality - the key behind the quantity safety of the library:
```dart
assert(speed / acceleration == time); // true
```

## Units
`Unit`s represent a specific measurement standard for a dimension.

Each unit is associated with a `Dimension` and has a conversion factor to a base unit.

In addition to this, units hold information about their symbol and name for display purposes.

Many common units are already provided by the library:
```dart
// Provided in 'package:physical/system/si.dart'
// Or in       'package:physical/units.dart'
const second = SiNamedUnit(
  symbol: 's',
  singular: 'second',
  plural: 'seconds',
  dimensions: time,
  scale: 1,
);
const metre = SiNamedUnit(
  symbol: 'm',
  singular: 'metre',
  plural: 'metres',
  dimensions: length,
  scale: 1,
);
```

SI units provide commonly used prefixes as getters:
```dart
final kilometre   = metre.kilo;   // km
final millisecond = second.milli; // ms
```

Much like dimensions, units can be combined using natural arithmetic operators - creating derived
units with the correct dimension, scale factor and symbol/name:
```dart
final metrePerSecond   = metre / second;    // m/s
final kilometrePerHour = metre.kilo / hour; // km/h

assert(metrePerSecond.dimensions == speed); // true
assert(kilometrePerHour.scale == (1000 / 3600)); // true
```

## Quantities
`Quantity`s represent a numerical value associated with a unit (and therefore a dimension).

The value is always stored **as provided**, without any conversion to base units - thus a `Quantity`
should be seen as a contextual wrapper around a number, providing scaling information and safety.

#### Construction
```dart
final length = qty(100, metre.kilo);    // 100 km (helper)
final time   = Quantity.of(20, minute); // 20 min
```

#### Operations
Yet again much like dimensions and units, quantities can be combined using natural arithmetic
operators:
```dart
final doubleLength = length + length; // 200 km
final fiveLengths  = length * 5;      // 500 km
final speed        = length / time;   // 5.0 km/min
```

Furthermore, most functions defined on `num` are also available on `Quantity`:
```dart
final truncatedLength  = qty(123.456, metre).truncate();          // 123 m
final roundedGravity   = qty(9.81, metre / (second ^ 2)).round(); // 10 m/s²
final absoluteLatitude = qty(-23.5, degree).abs();                // 23.5 °
```

#### Conversion
Quantities can be converted to other units of the same dimension using the `[]` operator:
```dart
final distance = qty(1, metre.kilo);       // 1 km
myFunction(metres: distance[metre].value); // 1000.0
```

#### Safety
Additions, subtractions, comparisons and conversions to other units are only allowed between units
of the same dimension - otherwise an error is thrown:
```dart
final length  = qty(100, metre);
final time    = qty(20, second);
final invalid = length + time;  // 🚫 throws
final invalid = length[second]; // 🚫 throws
if (length > time) { ... }      // 🚫 throws
```

#### Text output
Quantities can be converted to strings using their unit's symbol:
```dart
final acceleration = qty(2, metre / (second ^ 2));
final speed        = qty(120, metre.kilo / hour);
final voltage      = qty(3 + 1/3, volt);

print(acceleration);                      // 2 m/[s²]
print(acceleration.toNameString());       // 2 metres per [second²]
print(speed[mile / hour].floor())     // 74 mi/h
print(voltage.toStringAsFixed(2)); // 3.33 V
```

## Dimensioned Quantities
For added safety and readability, `physical` provides **completely optional** dimension-specific
quantity types for the most common quantities, such as `Length`, `Time`, `Speed`, etc.

These provide a checked constructor that ensures that the provided `unit` matches the expected
dimension:
```dart
final length  = Length.of(100, metre);
final invalid = Length.of(100, second); // 🚫 throws

final speed   = Speed(qty(6, metre) / qty(3, second));
final invalid = Speed(qty(20, metre));  // 🚫 throws
```

Crucially, these types do not truly extend `Quantity` but rather are Dart [extension types](https://dart.dev/language/extension-types).
This enables robust checking of the types at compile-time that completely disappear at runtime i.e.
there are no instances of `Length` or `Time` - everything is a `Quantity` under the hood.

Note: Unlike the types themselves the dimension check is very much real and still gets performed
**at runtime**.

```dart
void myFunction(Length length);
myFunction(qty(100, metre));       // 🚫 The argument type 'Quantity' can't be assigned to the parameter type 'Length'.
myFunction(Length.of(100, metre)); // OK
```

If you know for certain that the provided quantity has the correct dimension, you can skip the check
by simply casting a `Quantity` to the desired type:
```dart
myFunction(qty(100, metre) as Length);
```

Type-specific addition, subtraction and conversion methods are also provided that carry the correct
return type. The dimension checks are always performed by `Quantity` itself, regardless of the
dimension-specific type - it is just a matter of type convenience as we can be certain adding two
`Length`s will always yield a length:
```dart
final Length doubleLength = length + length;    // 200 m
final Length lengthInKm   = length[metre.kilo]; // 0.1 km
```

Custom dimensioned quantities can be created by extending the `DimensionedQuantity` class:
```dart
extension type Longitude._(Quantity q) implements DimensionedQuantity<Longitude> {
  Longitude(this.q) : assert(q.dimensions == angle, "${q.dimensions} != $angle");
  Longitude.of(num value, Unit unit) : this(Quantity.of(value, unit));
}
```

## Quantity Points
`QuantityPoint`s represent a numerical value relative to an origin point, mainly used for Temperature.

They are constructed by combining a `QuantityOrigin` and a `Quantity` using the `+` operator:
```dart
const zerothDegreeCelsius = QuantityOrigin(Quantity.of(273.15, kelvin));

const temperature = zerothDegreeCelsius + qty(56.7, degreeCelsius);
```

Quantity points protect against unintentional arithmetic operations with a more restrictive API:
```dart
final QuantityPoint higherTemperature = temperature + qty(10, degreeCelsius);  // 66.7°C
final QuantityPoint lowerTemperature  = temperature + qty(-10, degreeCelsius); // 46.7°C
final Quantity      deltaTemperature  = higherTemperature - lowerTemperature;  // 20°C
final               invalid           = higherTemperature + lowerTemperature;  // 🚫 not permitted
final Quantity      deltaAbsoluteZero = temperature.deltaFromZero;             // 329.85 K
final QuantityPoint fahrenheitTemp    =
        temperature[degreeFahrenheit].withOrigin(zerothDegreeFahrenheit);      // 134.06°F
```
