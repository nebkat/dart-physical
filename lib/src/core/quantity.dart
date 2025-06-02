import 'dart:math' as math;
import 'dimensions.dart';
import 'unit.dart';

import 'exception.dart';

Quantity _numToScalar(dynamic value) {
  if (value is Quantity) return value;
  if (value is num) return Quantity(value, Unit.one);
  throw const QuantityException('Expected a num or Quantity object');
}

num _scalarToNum(dynamic value) {
  if (value is Quantity && value.isScalar) return value.valueSI;
  if (value is num) return value;
  throw const QuantityException('Expected a num or scalar Quantity object');
}

class Quantity implements Comparable<Quantity> {
  final num value;
  final Unit unit;

  const Quantity(this.value, this.unit);

  Dimensions get dimensions => unit.dimensions;

  bool get isScalar => dimensions.isScalar;
  num get valueSI => value * unit.scale;

  /// Converts this quantity to a different dimension, inverting if necessary.
  Quantity inDimensions(Dimensions dimensions) {
    if (this.dimensions == dimensions) return this;
    if (this.dimensions.inverse() == dimensions) return inverse();
    throw DimensionsException("Cannot convert quantity: $dimensions to ${this.dimensions}");
  }

  Quantity inUnits(Unit units) => Quantity(valueIn(units), units);
  Quantity to(Unit units) => inUnits(units);

  num valueIn(Unit other) {
    // Already in the requested units
    if (other == unit) return value;

    if (dimensions != other.dimensions) {
      throw DimensionsException("Cannot convert quantity to units with different dimensions:"
          "$dimensions ($unit) to ${other.dimensions} ($other)");
    }

    return value * unit.scale / other.scale;
  }

  Quantity operator +(dynamic addend) => Quantity(
        value + _numToScalar(addend).valueIn(unit),
        unit,
      );

  Quantity operator -(dynamic subtrahend) => Quantity(
        value - _numToScalar(subtrahend).valueIn(unit),
        unit,
      );

  Quantity operator *(dynamic multiplier) {
    multiplier = _numToScalar(multiplier);
    return Quantity(value * multiplier.value, unit * multiplier.unit);
  }

  Quantity operator /(dynamic divisor) {
    divisor = _numToScalar(divisor);
    return Quantity(value / divisor.value, unit / divisor.unit);
  }

  Quantity operator ^(dynamic exponent) {
    if (exponent == 1) return this;
    exponent = _scalarToNum(exponent);
    return Quantity(math.pow(value, exponent), unit ^ exponent);
  }

  Quantity operator -() => Quantity(-value, unit);
  Quantity inverse() => Quantity(1 / value, unit.inverse());
  Quantity abs() => value >= 0 ? this : -this;
  Quantity sqrt() => this ^ (0.5);

  Quantity truncate() => Quantity(value.truncate(), unit);
  Quantity round() => Quantity(value.round(), unit);
  Quantity floor() => Quantity(value.floor(), unit);
  Quantity ceil() => Quantity(value.ceil(), unit);

  bool operator <(Quantity other) => compareTo(other) < 0;
  bool operator <=(Quantity other) => compareTo(other) <= 0;
  bool operator >(Quantity other) => compareTo(other) > 0;
  bool operator >=(Quantity other) => compareTo(other) >= 0;

  num get sign => value.sign;
  bool get isNegative => value.isNegative;

  @override
  bool operator ==(Object other) {
    if (isScalar && (other is num)) return valueSI == other;
    return compareTo(other) == 0;
  }

  @override
  int get hashCode => Object.hashAll(<Object>[value, unit]);

  @override
  int compareTo(dynamic q2) => value.compareTo(_numToScalar(q2).valueIn(unit));

  @override
  String toString() => "$value${unit.symbolForQuantity}";
  String toStringAsFixed(int fractionDigits) => "${value.toStringAsFixed(fractionDigits)}${unit.symbolForQuantity}";

  num toJson() => value;
}

Quantity qty(num value, Unit unit) => Quantity(value, unit);

class QuantityOrigin {
  final Quantity quantity;
  const QuantityOrigin(this.quantity);

  Dimensions get dimensions => quantity.dimensions;

  // TODO: const?
  QuantityOrigin.zero(Dimensions dimensions) : quantity = Quantity(0, AnonymousUnit(dimensions: dimensions));

  QuantityPoint operator +(Quantity addend) => QuantityPoint(addend, this);
  QuantityPoint operator -(Quantity subtrahend) => QuantityPoint(-subtrahend, this);
}

class QuantityPoint implements Comparable<QuantityPoint> {
  final Quantity quantity;
  final QuantityOrigin origin;

  const QuantityPoint(this.quantity, this.origin);

  Quantity operator -(QuantityPoint other) => deltaFromZero - other.deltaFromZero;
  QuantityPoint operator +(Quantity other) => QuantityPoint(quantity + other, origin);

  QuantityPoint inUnits(Unit units) => QuantityPoint(quantity.to(units), origin);
  QuantityPoint to(Unit units) => inUnits(units);

  QuantityPoint withOrigin(QuantityOrigin origin) => QuantityPoint(deltaFrom(origin), origin);
  QuantityPoint withZeroOrigin() => QuantityPoint(deltaFromZero, QuantityOrigin.zero(origin.dimensions));

  Quantity deltaFrom(QuantityOrigin origin) => deltaFromZero - origin.quantity;
  Quantity get deltaFromOrigin => quantity;
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
