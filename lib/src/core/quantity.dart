import 'dart:math' as math;

import '../util.dart';
import 'dimensions.dart';
import 'exception.dart';
import 'unit.dart';

/// Converts raw [num] values to [Quantity] scalars, or passes through [Quantity] objects.
///
/// If [value] is neither a [num] nor a [Quantity], a [QuantityException] is thrown.
Quantity numToScalar(Object value) => switch (value) {
      Quantity q => q,
      num n => Quantity.of(n, Unit.one),
      _ => throw QuantityException("Expected a num or scalar Quantity object: got ${value.runtimeType}"),
    };

/// Converts scalar [Quantity] objects to raw [num] values, or passes through [num] values.
///
/// If [value] is a non-scalar [Quantity], a [DimensionsException] is thrown.
/// If [value] is neither a [num] nor a [Quantity], a [QuantityException] is thrown.
num scalarToNum(Object value) => switch (value) {
      Quantity q when q.isScalar => q.value,
      Quantity q => throw DimensionsException.mismatch(
          expected: Dimensions.empty(),
          actual: q.dimensions,
          actualUnits: q.unit,
        ),
      num n => n,
      _ => throw QuantityException("Expected a num or scalar Quantity object: got ${value.runtimeType}"),
    };

/// An immutable numerical quantity with an associated [Unit].
///
/// Supports arithmetic operations, unit conversions, and comparisons.
///
/// ```dart
/// final length = Quantity.of(30, meters);
/// final time   = Quantity.of(10, seconds);
/// final speed  = length / time; // 3 m/s
/// ```
class Quantity implements Comparable<Quantity> {
  final num value;
  final Unit unit;

  /// Creates a quantity with the given [value] and [unit].
  const Quantity.of(this.value, this.unit);

  /// Creates a zero-valued quantity with the given [unit].
  const Quantity.zero(this.unit) : value = 0;

  /// The dimensions of (the units of) this quantity.
  Dimensions get dimensions => unit.dimensions;

  /// The value of this quantity in SI base scaled units.
  num get valueSI => value * unit.scale;

  /// Converts this quantity to different dimensions, inverting if necessary.
  ///
  /// [other] must either be the same dimensions or the inverse dimensions.
  ///
  /// This is useful when dealing with quantities that are often expressed in
  /// both direct and inverse forms, such as frequency (Hz) and period (s) or
  /// speed (m/s) and pace (s/m).
  Quantity inDimensionsMaybeInverse(Dimensions other) {
    if (dimensions == other) return this;
    if (dimensions.inverse() == other) return inverse();
    throw DimensionsException.mismatch(
      expected: dimensions,
      expectedUnits: unit,
      actual: other,
    );
  }

  /// Converts this quantity to a different unit.
  ///
  /// [other] must have the same dimensions as this quantity.
  Quantity inUnits(Unit other) => Quantity.of(_valueInUnits(other), other);

  /// Converts this quantity to a different unit, inverting dimensions if necessary.
  ///
  /// Equivalent to `inDimensionsMaybeInverse(other.dimensions).inUnits(other)`.
  Quantity inUnitsMaybeInverse(Unit other) => inDimensionsMaybeInverse(other.dimensions).inUnits(other);

  /// Converts this quantity to a different unit.
  ///
  /// [other] must have the same dimensions as this quantity.
  Quantity operator [](Unit other) => inUnits(other);

  /// Adds two quantities, converting [addend] to the units of this quantity.
  ///
  /// [addend] must have the same dimensions as this quantity.
  Quantity operator +(Quantity addend) => Quantity.of(
        value + addend._valueInUnits(unit),
        unit,
      );

  /// Subtracts two quantities, converting [subtrahend] to the units of this quantity.
  ///
  /// [subtrahend] must have the same dimensions as this quantity.
  Quantity operator -(Quantity subtrahend) => Quantity.of(
        value - subtrahend._valueInUnits(unit),
        unit,
      );

  /// Multiplies two quantities, deriving a new unit.
  ///
  /// [multiplier] must be a [Quantity] or a [num].
  ///
  /// If multiplier is a [num], it is treated as a dimensionless scalar quantity.
  /// If multiplier is a [Quantity], it can have any dimensions.
  ///
  /// See also [Unit.operator *] and [scaled].
  Quantity operator *(Object multiplier) {
    final quantity = numToScalar(multiplier);
    return Quantity.of(value * quantity.value, unit * quantity.unit);
  }

  /// Divides two quantities, deriving a new unit.
  ///
  /// [divisor] must be a [Quantity] or a [num].
  ///
  /// If divisor is a [num], it is treated as a dimensionless scalar quantity.
  /// If divisor is a [Quantity], it can have any dimensions.
  ///
  /// See also [Unit.operator /] and [scaled].
  Quantity operator /(Object divisor) {
    final quantity = numToScalar(divisor);
    return Quantity.of(value / quantity.value, unit / quantity.unit);
  }

  /// Raises this quantity to a power, raising the unit to the same power.
  ///
  /// [exponent] must be a scalar [Quantity] or a [num].
  ///
  /// See also [Unit.operator ^].
  Quantity operator ^(Object exponent) {
    if (exponent == 1) return this;
    final n = scalarToNum(exponent);
    return Quantity.of(math.pow(value, n), unit ^ n);
  }

  /// A negated copy of this quantity.
  Quantity operator -() => Quantity.of(-value, unit);

  /// An inverted copy of this quantity, inverting both the value and unit.
  ///
  /// See also [Unit.inverse].
  Quantity inverse() => Quantity.of(1 / value, unit.inverse());

  /// An absolute value copy of this quantity.
  Quantity abs() => value >= 0 ? this : -this;

  /// A squared copy of this quantity.
  Quantity squared() => this ^ 2;

  /// A cubed copy of this quantity.
  Quantity cubed() => this ^ 3;

  /// A square rooted copy of this quantity.
  Quantity sqrt() => this ^ (0.5);

  /// A cube rooted copy of this quantity.
  Quantity cbrt() => this ^ (1 / 3);

  /// A truncated copy of this quantity.
  Quantity truncate() => Quantity.of(value.truncate(), unit);

  /// A rounded copy of this quantity.
  Quantity round() => Quantity.of(value.round(), unit);

  /// A floored copy of this quantity.
  Quantity floor() => Quantity.of(value.floor(), unit);

  /// A ceiled copy of this quantity.
  Quantity ceil() => Quantity.of(value.ceil(), unit);

  /// A copy of this quantity with its value rounded to [fractionDigits] decimal places.
  Quantity toPrecision(int fractionDigits) => Quantity.of(value.toPrecision(fractionDigits), unit);

  /// A copy of this quantity scaled by [scalar].
  ///
  /// [scalar] must be a scalar [Quantity] or a [num].
  ///
  /// See also [DimensionedQuantity.scaled].
  Quantity scaled(Object scalar) => this * Dimensions.empty().checked(numToScalar(scalar));

  /// Whether this quantity is numerically smaller than [other] in common units.
  bool operator <(Quantity other) => compareTo(other) < 0;

  /// Whether this quantity is numerically smaller than or equal to [other] in common units.
  bool operator <=(Quantity other) => compareTo(other) <= 0;

  /// Whether this quantity is numerically larger than [other] in common units.
  bool operator >(Quantity other) => compareTo(other) > 0;

  /// Whether this quantity is numerically larger than or equal to [other] in common units.
  bool operator >=(Quantity other) => compareTo(other) >= 0;

  /// The sign of the value stored in this quantity.
  num get sign => value.sign;

  /// Whether the value stored in this quantity is negative.
  bool get isNegative => value.isNegative;

  /// Whether this quantity is a scalar (dimensionless).
  ///
  /// See [Dimensions.isScalar].
  bool get isScalar => dimensions.isScalar;

  /// Whether this quantity is a scalar (dimensionless) in the strict SI sense.
  ///
  /// See [Dimensions.isScalarSI].
  bool get isScalarSI => dimensions.isScalarSI;

  /// Test whether this quantity is equal to [other].
  ///
  /// Quantities are only equal if they have the same dimensions and represent
  /// the same value after accounting for potential different unit scaling.
  @override
  bool operator ==(Object other) {
    if (isScalar && (other is num)) return valueSI == other;
    if (other is! Quantity) return false;
    return compareTo(other) == 0;
  }

  @override
  int get hashCode => Object.hashAll(<Object>[value, unit]);

  /// Compares this quantity to [other] in common units.
  ///
  /// See [num.compareTo].
  @override
  int compareTo(Quantity other) => value.compareTo(numToScalar(other)._valueInUnits(unit));

  /// The shortest string that correctly represents this quantity including its unit symbol.
  @override
  String toString() => "$value${unit.symbolForQuantity}";

  /// A decimal-point string representation of this quantity with its unit symbol.
  String toStringAsFixed(int fractionDigits) => "${value.toStringAsFixed(fractionDigits)}${unit.symbolForQuantity}";

  /// A decimal-point string representation of this quantity (without trailing zeros) with its unit symbol.
  String toStringAsFixedNoTrailing(int fractionDigits) =>
      "${value.toStringAsFixedNoTrailing(fractionDigits)}${unit.symbolForQuantity}";

  /// The shortest string that correctly represents this quantity including its unit name.
  String toNameString() => "$value ${unit.nameForValue(value)}";

  /// A decimal-point string representation of this quantity with its unit name.
  String toNameStringAsFixed(int fractionDigits) =>
      "${value.toStringAsFixed(fractionDigits)} ${unit.nameForValue(value)}";

  num _valueInUnits(Unit other) {
    // Already in the requested units
    if (other == unit) return value;

    if (dimensions != other.dimensions) {
      throw DimensionsException.mismatch(
        expected: dimensions,
        expectedUnits: unit,
        actual: other.dimensions,
        actualUnits: other,
      );
    }

    return value * unit.scale / other.scale;
  }
}

/// Convenience function for creating a [Quantity]
Quantity qty(num value, Unit unit) => Quantity.of(value, unit);

/// Common interface for [QuantityPoint] and [QuantityOrigin].
abstract interface class QuantityPointOrOrigin {
  Quantity get deltaFromZero;
}

/// An origin point for a [QuantityPoint], representing a [Quantity] away
/// from the absolute zero point.
///
/// For example, a temperature origin might be 273.15 K (0 °C).
class QuantityOrigin implements QuantityPointOrOrigin {
  final Quantity quantity;
  const QuantityOrigin(this.quantity);

  /// The dimensions of (the units of) this origin.
  Dimensions get dimensions => quantity.dimensions;

  /// The unit of this origin.
  Unit get unit => quantity.unit;

  // TODO: const?
  QuantityOrigin.zero(Dimensions dimensions) : quantity = Quantity.of(0, AnonymousUnit(dimensions: dimensions));

  /// The delta difference between this origin and absolute zero.
  @override
  Quantity get deltaFromZero => quantity;

  /// Creates a [QuantityPoint] by adding a [Quantity] to this origin.
  ///
  /// [addend] must have the same dimensions as this origin.
  QuantityPoint operator +(Quantity addend) => QuantityPoint(checked(addend), this);

  /// Creates a [QuantityPoint] by subtracting a [Quantity] from this origin.
  ///
  /// [subtrahend] must have the same dimensions as this origin.
  QuantityPoint operator -(Quantity subtrahend) => QuantityPoint(-checked(subtrahend), this);

  /// Ensures that [other] has the same dimensions as this origin's [quantity].
  Quantity checked(Quantity other) {
    if (other.dimensions != dimensions) {
      throw DimensionsException.mismatch(
        expected: dimensions,
        expectedUnits: unit,
        actual: other.dimensions,
        actualUnits: other.unit,
      );
    }
    return other;
  }
}

/// A immutable [Quantity] relative to a [QuantityOrigin].
///
/// For example, a temperature of 20°C with an origin of 0°C represents an
/// absolute temperature of 293.15 K.
class QuantityPoint implements QuantityPointOrOrigin, Comparable<QuantityPoint> {
  /// The quantity relative to the origin.
  final Quantity quantity;

  /// The origin point for this quantity.
  final QuantityOrigin origin;

  /// Creates a quantity point with the given [quantity] relative to [origin].
  const QuantityPoint(this.quantity, this.origin);

  /// The delta difference between this quantity point and [origin].
  ///
  /// Converts both this quantity point and [other] to quantities relative to
  /// absolute zero and then returns the difference. This ensures that subtracting
  /// two quantity points with different origins produces the correct result.
  ///
  /// For example, 20°C - 10°F == 293.15 K - 260.928 K == 32.222°C.
  Quantity operator -(QuantityPointOrOrigin other) => deltaFromZero - other.deltaFromZero;

  /// Creates a new quantity point by adding a [other] to this quantity point.
  ///
  /// As [operator -] is reserved for subtracting two quantity points, this operator
  /// is used for both addition and subtraction of a [Quantity] to/from a [QuantityPoint].
  ///
  /// In order to subtract a [Quantity] from a [QuantityPoint], simply negate the [Quantity]
  /// before adding it: `point + (-quantity)`.
  QuantityPoint operator +(Quantity other) => QuantityPoint(quantity + other, origin);

  /// Converts this quantity point to a different unit, preserving the origin.
  QuantityPoint inUnits(Unit units) => QuantityPoint(quantity.inUnits(units), origin);

  /// Converts this quantity point to a different unit, preserving the origin.
  QuantityPoint operator [](Unit units) => inUnits(units);

  /// Converts this quantity point to a different origin, preserving value relative to absolute zero.
  ///
  /// The resulting quantity point will have the same [deltaFromZero] value i.e. 273.15 K with origin
  /// [zerothDegreeCelsius] is still 273.15 K, only [deltaFromOrigin] changes to 0°C.
  QuantityPoint withOrigin(QuantityOrigin origin) => QuantityPoint(deltaFrom(origin), origin);

  /// Converts this quantity point to a zero-origin quantity point, preserving value relative to absolute zero.
  ///
  /// The resulting quantity point will have the same [deltaFromZero] value i.e. 0°C with zero origin
  /// is still 273.15 K, only [deltaFromOrigin] changes to 273.15 K.
  QuantityPoint withZeroOrigin() => QuantityPoint(deltaFromZero, QuantityOrigin.zero(origin.dimensions));

  /// The delta difference between this quantity point and [origin].
  ///
  /// See [operator -].
  Quantity deltaFrom(QuantityPointOrOrigin origin) => this - origin;

  /// The delta difference between this quantity point and its own [origin].
  Quantity get deltaFromOrigin => quantity;

  /// The absolute quantity represented by this quantity point, relative to a zero origin.
  @override
  Quantity get deltaFromZero => quantity + origin.quantity;

  @override
  bool operator ==(Object other) {
    if (other is! QuantityPoint) return false;
    return compareTo(other) == 0;
  }

  @override
  int get hashCode => Object.hashAll(<Object>[quantity, origin]);

  @override
  int compareTo(QuantityPoint other) => deltaFromZero.compareTo(other.deltaFromZero);
}

/// An [extension type](https://dart.dev/language/extension-types) wrapper
/// for [Quantity] intended to model quantities with a specific dimension.
///
/// To define a custom dimensioned quantity, create an extension type:
/// ```dart
/// extension type Longitude._(Quantity q) implements DimensionedQuantity<Longitude> {
///   Longitude(Quantity q) : q = angle.checked(q);
///   Longitude.of(num value, Unit unit) : this._(Quantity.of(value, unit));
///   // Optional convenience constructors
///   const Longitude.zero() : q = const Quantity.of(0, radian);
///   Longitude.degrees(num value) : this._(Quantity.of(value, degree));
/// }
/// ```
///
/// Some operations are redefined in terms of [T], the specific dimensioned
/// quantity type, when we know that the result is guaranteed to also be
/// of type [T]. For example, adding two [Length]s always produces a [Length].
extension type DimensionedQuantity<T>._(Quantity q) implements Quantity {
  T inUnits(Unit unit) => q.inUnits(unit) as T;
  T operator [](Unit unit) => q[unit] as T;

  T operator +(Quantity addend) => q + addend as T;
  T operator -(Quantity subtrahend) => q - subtrahend as T;

  T operator -() => -q as T;

  T abs() => q.abs() as T;
  T truncate() => q.truncate() as T;
  T round() => q.round() as T;
  T floor() => q.floor() as T;
  T ceil() => q.ceil() as T;

  /// A copy of this quantity scaled by [scalar].
  ///
  /// [scalar] must be a scalar [Quantity] or a [num].
  ///
  /// Unlike [operator *], this operation is guaranteed to return the same type [T].
  T scaled(Object scalar) => q.scaled(scalar) as T;
}
