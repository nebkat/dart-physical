import 'dart:collection';

import '../format/script.dart';
import '../util.dart';
import 'exception.dart';
import 'quantity.dart';

/// Base physical dimensions.
///
/// The seven base dimensions defined in the International System of Units (SI)
/// are length, mass, time, electric current, temperature, amount of substance,
/// and luminous intensity.
///
/// In addition, this library tracks angle and solid angle
/// as dimensionless quantities that are often treated separately from other
/// dimensionless quantities.
enum Dimension {
  length('L'),
  mass('M'),
  time('T'),
  temperature('K'),
  electricCurrent('I'),
  luminousIntensity('J'),
  amountOfSubstance('N'),
  angle('A'),
  solidAngle('S');

  final String symbol;

  const Dimension(this.symbol);

  bool get isSI => this != Dimension.angle && this != Dimension.solidAngle;
}

/// Representation of the nature of a physical quantity, defined as a map of base [Dimension] to their exponents.
///
/// All [Dimensions] immutable and can be used as compile-time constants.
///
/// For example, velocity has dimensions of length divided by time, or length: +1, time: -1.
/// A scalar (dimensionless) quantity has no dimensions and is represented by an empty map.
///
/// [Dimensions] support natural arithmetic operations including multiplication, division,
/// and exponentiation. Thus new [Dimensions] objects can be created by combining existing
/// ones e.g. `acceleration = length / (time ^ 2)`.
class Dimensions {
  const Dimensions.empty() : _map = const {};

  /// Constructs a constant [Dimensions] object with a map of base dimensions to exponents.
  ///
  /// **Do not use this constructor in non-constant contexts.**
  const Dimensions.constant(Map<Dimension, num> map) : _map = map;

  /// Constructs a [Dimensions] object with a map of base dimension to exponents.
  ///
  /// A copy of [map] is taken and made unmodifiable.
  Dimensions(Map<Dimension, num> map)
      : assert(map.values.every((v) => v != 0)),
        _map = Map<Dimension, num>.unmodifiable(map);

  final Map<Dimension, num> _map;

  /// The dimensions map (base dimension key -> base dimension exponent)
  /// as an unmodifiable view.
  Map<Dimension, num> get map => UnmodifiableMapView(_map);

  /// Multiplies this object by [other], creating a new [Dimensions] object.
  ///
  /// Dimension multiplication (as occurs when two physical quantities are multiplied)
  /// is accomplished by adding component exponents.
  ///
  /// For example, a time (time +1) multiplied by a frequency (time -1) yields a scalar
  /// (1 + (-1) = 0).
  Dimensions operator *(Dimensions other) {
    if (other.isScalar) return this;

    final copy = {..._map};
    for (final entry in other._map.entries) {
      copy[entry.key] = ((copy[entry.key] ?? 0) + (entry.value)).toIntIfExact();
    }
    copy.removeWhere((key, value) => value == 0);
    return Dimensions(copy);
  }

  /// Divides this object by [other], creating a new [Dimensions] object.
  ///
  /// Dimension division (as occurs when two quantities are divided) is accomplished
  /// by subtracting the component dimensions of the divisor (bottom).
  ///
  /// For example, a volume (length: +3) divided by a length (length: +1) yields
  /// an area (length: +2) or (3 - (+1) = 2).
  Dimensions operator /(Dimensions other) {
    if (other.isScalar) return this;

    final copy = {..._map};
    for (final entry in other._map.entries) {
      copy[entry.key] = ((copy[entry.key] ?? 0) - (entry.value)).toIntIfExact();
    }
    copy.removeWhere((key, value) => value == 0);
    return Dimensions(copy);
  }

  /// Raises this object to the power of [exp], creating a new [Dimensions] object.
  ///
  /// Each base dimension component exponent is multiplied by [exp] to achieve
  /// the desired result.
  Dimensions operator ^(num exp) {
    if (exp == 0) return const Dimensions.empty();
    if (exp == 1) return this;

    final copy = {..._map};
    for (final entry in copy.entries) {
      copy[entry.key] = (entry.value * exp).toIntIfExact();
    }
    copy.removeWhere((key, value) => value == 0);
    return Dimensions(copy);
  }

  /// An inverted copy of this object.
  ///
  /// Dimension inversion occurs when a Quantity is divided into 1 and is
  /// accomplished by simply negating the sign of each dimension component.
  /// For example the inverse of frequency dimensions (time: -1) is duration
  /// (time: +1).
  Dimensions inverse() => Dimensions(_map.map((key, value) => MapEntry(key, -value)));

  /// Whether or not these are scalar dimensions, including having no angle or
  /// solid angle dimensions.
  ///
  /// Use [isScalarSI] to see if these [Dimensions] are scalar in the strict
  /// International System of Units (SI) sense, which allows non-zero angular and
  /// solid angular dimensions.
  bool get isScalar => _map.isEmpty;

  /// Whether or not these are scalar dimensions, in the strict International System
  /// of Units (SI) sense, which allows non-zero angle and solid angle dimensions.
  ///
  /// Use [isScalar] to see if these [Dimensions] are scalar including having no
  /// angle or solid angle dimensions.
  bool get isScalarSI {
    for (final key in Dimension.values) {
      if (!key.isSI) continue;
      if (_map[key] != 0) return false;
    }
    return true;
  }

  /// The exponent for the given base dimension, or 0 if not present.
  num operator [](Dimension dimension) {
    return _map[dimension] ?? 0;
  }

  /// Ensures that the dimensions of [quantity] match these dimensions.
  ///
  /// If they do, returns the quantity; if not, throws a [DimensionsException].
  Quantity checked(Quantity quantity) {
    if (quantity.dimensions != this) {
      throw DimensionsException.mismatch(
        expected: this,
        actual: quantity.dimensions,
        actualUnits: quantity.unit,
      );
    }
    return quantity;
  }

  /// Test whether the dimensions of this object are equal to the dimensions of [other].
  ///
  /// Objects are only equal if they have the same exponents for each dimension.
  bool equals(Dimensions other) {
    if (identical(this, other)) return true;

    for (final key in Dimension.values) {
      if (_map[key] != other._map[key]) return false;
    }

    return true;
  }

  /// Test whether the dimensions of this object are equal to the dimensions of [other],
  /// only considering the seven base SI quantities (that is, angle and solid
  /// angle components are ignored).
  ///
  /// Objects are only equal if they have the same exponents for each SI dimension.
  bool equalsSI(Dimensions other) {
    if (identical(this, other)) return true;

    for (final key in Dimension.values) {
      if (!key.isSI) continue;
      if (_map[key] != other._map[key]) return false;
    }

    return true;
  }

  /// Test whether the dimensions of this object are equal to the dimensions of [other].
  ///
  /// Objects are only equal if they have the same exponents for each dimension.
  @override
  bool operator ==(Object other) {
    if (other is! Dimensions) return false;
    return equals(other);
  }

  @override
  int get hashCode => Object.hashAll(Dimension.values.map((dimension) => _map[dimension]));

  /// A dimensional formula representation of these dimensions.
  ///
  /// Dimensionless (scalar) dimensions are represented as `1`.
  @override
  String toString() => _map.isEmpty
      ? '1'
      : _map.entries
          .map(
            (e) => '${e.key.symbol}${numToSuperscript(e.value.toString())}',
          )
          .join();
}
