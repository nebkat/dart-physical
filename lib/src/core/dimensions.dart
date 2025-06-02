import 'dart:collection';

import 'package:physical/src/util.dart';

import '../format/script.dart';

/// The Dimension enum represents the base dimensions of physical quantities.
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

/// The dimensions of a physical quantity.
///
/// ## The Seven Base Quantities
/// In the International System of Units (SI) all quantities are considered
/// to be either one of the seven base quantities (length, mass, time interval,
/// temperature, current, intensity and amount of substance) or derived from
/// those base quantities through combinations and/or arbitrary exponents.
/// The [Dimensions] of a quantity capture which combination applies for that
/// particular quantity.  Any combination of these base quantities is possible;
/// in practice less than 100 derived quantities are in common use.
/// The Dimensions of a quantity determine its type and directly relate to that
/// quantity's significance and meaning in the real world.
///
/// ## The Dimensions class also tracks angle and solid angle
/// The dimensions that are tracked include the seven base SI quantities and
/// also the angle and solid angle dimensionless quantities.  Angular
/// quantities are often distinguished from their non-angular counterparts
/// even if the SI base dimensions are equal.  Consequently, in order
/// to support such differentiation, [Dimension.angle] and [Dimension.solidAngle]
/// dimensions are stored alongside the base seven dimensions and used to
/// distinguish between dimensions and determine quantity types.  To test
/// whether two Dimensions objects are equal strictly in terms of the base SI
/// dimensions, the [equalsSI] method may be used.
class Dimensions {
  const Dimensions.empty() : _map = const {};

  /// Constructs a constant [Dimensions] object with a map of base dimensions to exponents.
  ///
  /// Do not use this constructor in non-constant contexts.
  const Dimensions.constant(Map<Dimension, num> map) : _map = map;

  /// Constructs a [Dimensions] object with a map of base dimension to exponents.
  Dimensions(Map<Dimension, num> map)
      : assert(map.values.every((v) => v != 0)),
        _map = Map<Dimension, num>.unmodifiable(map);

  final Map<Dimension, num> _map;

  /// The dimensions map (base dimension key -> base dimension exponent)
  /// as an unmodifiable view.
  Map<Dimension, num> get map => UnmodifiableMapView(_map);

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

  /// Test whether the dimensions of this object are equal to the dimensions of [other].
  ///
  /// Objects are only equal if they have the same exponents for each dimension.
  bool equals(Dimensions other) {
    if (identical(this, other)) return true;

    for (final key in Dimension.values) {
      if (this[key] != other[key]) return false;
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
      if (this[key] != other[key]) return false;
    }

    return true;
  }

  /// Whether or not these are scalar dimensions, including having no angle or
  /// solid angle dimensions.
  ///
  /// Use [isScalarSI] to see if these [Dimensions] are scalar in the strict
  /// International System of Units (SI) sense, which allows non-zero angular and
  /// solid angular dimensions.
  bool get isScalar => _map.isEmpty;

  /// Whether or not these are scalar dimensions, in the strict
  /// International System of Units (SI) sense, which allows non-zero angle and
  /// solid angle dimensions.
  ///
  /// Use [isScalar] to see if these [Dimensions] are scalar including having no
  /// angle or solid angle dimensions.
  bool get isScalarSI {
    for (final key in Dimension.values) {
      if (!key.isSI) continue;
      if (this[key] != 0) return false;
    }
    return true;
  }

  /// Returns the product of this Dimensions object and [other] Dimensions.
  ///
  /// Dimension multiplication (as occurs when two physical quantities are
  /// multiplied) is accomplished by adding component exponents.  For example,
  /// a time (time +1) multiplied by a frequency (time -1) yields a scalar
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

  /// Divides this Dimension by [other] Dimensions, creating a Dimensions
  /// object.
  ///
  /// Dimension division (as occurs when two quantities are
  /// divided) is accomplished by subtracting the component dimensions of the
  /// divisor (bottom).  For example, a volume (length: +3) divided by a length
  /// (length: +1) yields an area (length: +2) or (3 - (+1) = 2).
  Dimensions operator /(Dimensions other) {
    if (other.isScalar) return this;

    final copy = {..._map};
    for (final entry in other._map.entries) {
      copy[entry.key] = ((copy[entry.key] ?? 0) - (entry.value)).toIntIfExact();
    }
    copy.removeWhere((key, value) => value == 0);
    return Dimensions(copy);
  }

  /// Determines the inverse of the dimensions represented by this object,
  /// creating a Dimension object.  This object is not modified.
  ///
  /// Dimension inversion occurs when a Quantity is divided into 1 and is
  /// accomplished by simply negating the sign of each dimension component.
  /// For example the inverse of frequency dimensions (time: -1) is duration
  /// (time: +1).
  Dimensions inverse() => Dimensions(_map.map((key, value) => MapEntry(key, -value)));

  /// Calculates these Dimensions raised to the power specified by [exp]
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

  /// Returns the exponent for the given dimension, or 0 if not present.
  num operator [](Dimension dimension) {
    return _map[dimension] ?? 0;
  }

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
