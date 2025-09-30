import 'dart:math';

import '../format/script.dart';
import 'dimensions.dart';
import 'quantity.dart';

/// Representation of a physical unit, including its underlying [Dimensions]
/// and a scale factor relative to the SI-MKS base units.
///
/// All [Unit]s are immutable and can be used as compile-time constants.
///
/// [Unit]s, like [Dimensions], support natural arithmetic operations including
/// multiplication, division and exponentiation. Thus new [Unit]s can be
/// created from existing [Unit]s.
abstract class Unit {
  /// The dimensions of the unit, e.g. length, time, mass.
  final Dimensions dimensions;

  /// The ratio of the unit to the base unit in SI-MKS.
  final num scale;

  /// The symbol of the unit, e.g. "m" for metre, "s" for second.
  final String symbol;

  /// The singular name of the unit, e.g. "metre", "second".
  final String singular;

  /// The plural name of the unit, e.g. "metres", "seconds".
  final String plural;

  /// Whether to put a space before the symbol when displaying it.
  final bool spaceBeforeSymbol;

  /// The symbol of the unit, wrapped in square brackets if it is not a [NamedUnit].
  String get safeSymbol => this is NamedUnit ? symbol : "[$symbol]";

  /// The singular name of the unit, wrapped in square brackets if it is not a [NamedUnit].
  String get safeSingular => this is NamedUnit ? singular : "[$singular]";

  /// The plural name of the unit, wrapped in square brackets if it is not a [NamedUnit].
  String get safePlural => this is NamedUnit ? plural : "[$plural]";

  /// Creates a new unit with the given [dimensions], [scale], [symbol], [singular] and [plural] names.
  ///
  /// By default, a space is added before the symbol when displaying it, but this can be
  /// disabled by setting [spaceBeforeSymbol] to false.
  const Unit({
    this.scale = 1,
    required this.dimensions,
    required this.symbol,
    required this.singular,
    required this.plural,
    this.spaceBeforeSymbol = true,
  });

  /// The dimensionless base unit "one".
  static const Unit one = NamedUnit(
    dimensions: Dimensions.empty(),
    scale: 1,
    symbol: '1',
    singular: 'one',
    plural: 'one',
  );

  /// An inverted copy of this unit, inverting both the dimensions and scale.
  ///
  /// If this unit is the dimensionless unit "one", it is returned unchanged.
  ///
  /// See also [Dimensions.inverse].
  Unit inverse() {
    if (identical(this, one)) return this;
    return DerivedUnit(
      dimensions: dimensions.inverse(),
      scale: 1 / scale,
      symbol: "1/$safeSymbol",
      singular: 'inverse $safeSingular',
      plural: 'inverse $safePlural',
    );
  }

  /// Multiplies this unit by [other], creating a new [DerivedUnit].
  ///
  /// If either unit is the dimensionless unit "one", the other unit is returned.
  ///
  /// Unit multiplication (as occurs when two physical quantities are multiplied)
  /// is accomplished by multiplying their dimensions and scales.
  ///
  /// See also [Dimensions.operator*].
  Unit operator *(Unit other) {
    if (identical(this, one)) return other;
    if (identical(other, one)) return this;
    return DerivedUnit(
      dimensions: dimensions * other.dimensions,
      scale: scale * other.scale,
      symbol: '$safeSymbol·${other.safeSymbol}',
      singular: '$safeSingular-${other.safeSingular}',
      plural: '$safeSingular-${other.safePlural}',
    );
  }

  /// Divides this unit by [other], creating a new [DerivedUnit].
  ///
  /// If either unit is the dimensionless unit "one", the other unit is returned.
  ///
  /// Unit division (as occurs when one physical quantity is divided by another)
  /// is accomplished by dividing their dimensions and scales.
  ///
  /// See also [Dimensions.operator/].
  Unit operator /(Unit other) {
    if (identical(this, one)) return other;
    if (identical(other, one)) return this;
    return DerivedUnit(
      dimensions: dimensions / other.dimensions,
      scale: scale / other.scale,
      symbol: '$safeSymbol/${other.safeSymbol}',
      singular: '$safeSingular per ${other.safeSingular}',
      plural: '$safePlural per ${other.safeSingular}',
    );
  }

  /// Raises this unit to the power of [exponent], creating a new [DerivedUnit].
  ///
  /// If the exponent is 1, the unit is returned unchanged.
  ///
  /// Unit exponentiation (as occurs when a physical quantity is raised to a power)
  /// is accomplished by raising its dimensions and scale to the power of [exponent].
  ///
  /// See also [Dimensions.operator^].
  Unit operator ^(num exponent) {
    if (exponent == 1) return this;
    return DerivedUnit(
      dimensions: dimensions ^ exponent,
      scale: pow(scale, exponent),
      symbol: '$safeSymbol${numToSuperscript(exponent.toString())}',
      singular: '$safeSingular${numToSuperscript(exponent.toString())}',
      plural: '$safePlural${numToSuperscript(exponent.toString())}',
    );
  }

  /// A squared [DerivedUnit] copy of this unit.
  DerivedUnit squared() => DerivedUnit(
        dimensions: dimensions ^ 2,
        scale: pow(scale, 2),
        symbol: '$safeSymbol²',
        singular: '$safeSingular squared',
        plural: '$safePlural squared',
      );

  /// A cubed [DerivedUnit] copy of this unit.
  DerivedUnit cubed() => DerivedUnit(
        dimensions: dimensions ^ 3,
        scale: pow(scale, 3),
        symbol: '$safeSymbol³',
        singular: '$safeSingular cubed',
        plural: '$safePlural cubed',
      );

  /// The symbol of the unit, potentially prepended with a space based on [spaceBeforeSymbol].
  String get symbolWithSpace => spaceBeforeSymbol ? ' $symbol' : symbol;

  /// The symbol of the unit, or an empty string if the unit is the dimensionless unit "one".
  String get symbolForQuantity => this == one ? '' : symbolWithSpace;

  /// The appropriate name of the unit for the given [value], either [singular] or [plural].
  String nameForValue(num value) => (value == 1 || value == -1) ? singular : plural;

  /// Whether this unit is equal to [other], having the same [scale] and [dimensions].
  ///
  /// Symbols/names are not considered for equality.
  @override
  bool operator ==(Object other) {
    return other is Unit && scale == other.scale && dimensions == other.dimensions;
  }

  @override
  int get hashCode => Object.hashAll([symbol, dimensions, scale]);

  @override
  String toString() => symbol;
}

/// An anonymous [Unit] with no specific name or symbol.
///
/// Used in contexts where a unit is required but there is no meaningful name or symbol
/// associated with it (for example the absolute zero point used in a [QuantityOrigin]).
class AnonymousUnit extends Unit {
  const AnonymousUnit({
    required super.dimensions,
    super.scale = 1,
  }) : super(
          symbol: '?',
          singular: 'anonymous',
          plural: 'anonymous',
          spaceBeforeSymbol: true,
        );
}

/// A known [Unit] with a specific name and symbol.
///
/// Used for base units (e.g. metre, second), named derived units (e.g. newton, joule) and
/// prefixed units (e.g. kilometre, millisecond).
///
/// In practice the only difference between a [NamedUnit] and a [DerivedUnit] is with
/// [Unit.safeSymbol]/[Unit.safeSingular]/[Unit.safePlural], where [DerivedUnit]s are
/// wrapped in square brackets, while [NamedUnit]s are not. This ensures that further
/// derivations remain readable (e.g. \[m²\]⁰˙⁵).
class NamedUnit extends Unit {
  const NamedUnit({
    required super.dimensions,
    super.scale = 1,
    required super.symbol,
    required super.singular,
    required super.plural,
    super.spaceBeforeSymbol = true,
  });
}

/// A known [Unit] with a specific name and symbol that can be prefixed with SI prefixes.
///
/// Used for all SI (and some non-SI) units that can be prefixed with standard SI prefixes
/// (e.g. kilo, milli).
///
/// Should _not_ be used where a prefix would not make sense (e.g. hectopercent, Megamiles).
class SiNamedUnit extends NamedUnit {
  const SiNamedUnit({
    required super.dimensions,
    super.scale = 1,
    required super.symbol,
    required super.singular,
    required super.plural,
    super.spaceBeforeSymbol = true,
  });

  _withPrefix(
    String symbolPrefix,
    String namePrefix,
    double scale,
  ) =>
      NamedUnit(
        symbol: '$symbolPrefix$symbol',
        singular: '$namePrefix$singular',
        plural: '$namePrefix$plural',
        dimensions: dimensions,
        scale: scale * scale,
      );

  /// A derived unit having the 10^24 prefix, yotta (Y).
  NamedUnit get yotta => _withPrefix('Y', 'yotta', 1.0e24);

  /// A derived unit having the 10^21 prefix, zetta (Z).
  NamedUnit get zetta => _withPrefix('Z', 'zetta', 1.0e21);

  /// A derived unit having the 10^18 prefix, exa (E).
  // ignore: prefer_int_literals
  NamedUnit get exa => _withPrefix('E', 'exa', 1.0e18);

  /// A derived unit having the 10^15 prefix, peta (P).
  // ignore: prefer_int_literals
  NamedUnit get peta => _withPrefix('P', 'peta', 1.0e15);

  /// A derived unit having the 10^12 prefix, tera (T).
  // ignore: prefer_int_literals
  NamedUnit get tera => _withPrefix('T', 'tera', 1.0e12);

  /// A derived unit having the 10^9 prefix, giga (G).
  // ignore: prefer_int_literals
  NamedUnit get giga => _withPrefix('G', 'giga', 1.0e9);

  /// A derived unit having the 10^6 prefix, mega (M).
  // ignore: prefer_int_literals
  NamedUnit get mega => _withPrefix('M', 'mega', 1.0e6);

  /// A derived unit having the 10^3 (i.e., 1000) prefix, kilo (k).
  NamedUnit get kilo => _withPrefix('k', 'kilo', 1000);

  ///  A derived unit having the 10^2 (i.e., 100) prefix, hecto (h).
  NamedUnit get hecto => _withPrefix('h', 'hecto', 100);

  /// A derived unit having the 10^1 (i.e. 10) prefix, deca (da).
  NamedUnit get deca => _withPrefix('da', 'deca', 10);

  /// A derived unit having the 10^-1 (i.e., 0.1) prefix, deci (d).
  NamedUnit get deci => _withPrefix('d', 'deci', 0.1);

  /// A derived unit having the 10^-2 (i.e., 0.01) prefix, centi (c).
  NamedUnit get centi => _withPrefix('c', 'centi', 0.01);

  /// A derived unit having the 10^-3 (i.e., 0.001) prefix, milli (m).
  NamedUnit get milli => _withPrefix('m', 'milli', 0.001);

  /// A derived unit having the 10^-6 prefix, micro (the symbol mu).
  NamedUnit get micro => _withPrefix('\u00b5', 'micro', 1.0e-6);

  /// A derived unit having the 10^-9 prefix, nano (n).
  NamedUnit get nano => _withPrefix('n', 'nano', 1.0e-9);

  /// A derived unit having the 10^-12 prefix, pico (p).
  NamedUnit get pico => _withPrefix('p', 'pico', 1.0e-12);

  /// A derived unit having the 10^-15 prefix, femto (f).
  NamedUnit get femto => _withPrefix('f', 'femto', 1.0e-15);

  /// A derived unit having the 10^-18 prefix, atto (a).
  NamedUnit get atto => _withPrefix('a', 'atto', 1.0e-18);

  /// A derived unit having the 10^-21 prefix, zepto (z).
  NamedUnit get zepto => _withPrefix('z', 'zepto', 1.0e-21);

  /// A derived unit having the 10^-24 prefix, yocto (y).
  NamedUnit get yocto => _withPrefix('y', 'yocto', 1.0e-24);
}

/// A [Unit] derived from some combination of other units.
class DerivedUnit extends Unit {
  const DerivedUnit({
    required super.symbol,
    required super.singular,
    required super.plural,
    required super.dimensions,
    required super.scale,
    super.spaceBeforeSymbol = true,
  });

  /// Creates a copy of this [DerivedUnit] as a [NamedUnit] with the given [symbol],
  /// [singular] and [plural] names.
  ///
  /// Can be used in cases where a derived unit has a known name/symbol but is awkward
  /// to compute without performing the underlying unit arithmetic.
  ///
  /// For example,
  /// ```dart
  /// final horsepower = ((Magnitude(550) * foot * poundForce) / second).named({
  ///     symbol: 'hp',
  ///     singular: 'horsepower',
  ///     plural: 'horsepower',
  /// });
  /// ```
  NamedUnit named({
    required String symbol,
    required String singular,
    required String plural,
    bool? spaceBeforeSymbol,
  }) =>
      NamedUnit(
        dimensions: dimensions,
        scale: scale,
        symbol: symbol,
        singular: singular,
        plural: plural,
        spaceBeforeSymbol: spaceBeforeSymbol ?? this.spaceBeforeSymbol,
      );
}

/// A [Unit] representing a pure numerical/dimensionless magnitude.
///
/// Primarily used to construct arbitrary scales of existing units.
///
/// For example `Magnitude.power(2, -32) * Magnitude(360) * degree` can be used
/// to represent a 32-bit fraction of a full revolution in degrees.
class Magnitude extends Unit {
  const Magnitude._({required super.scale, required super.symbol})
      : super(
          singular: symbol,
          plural: symbol,
          dimensions: const Dimensions.empty(),
          spaceBeforeSymbol: false,
        );

  /// Creates a [Magnitude] with the given raw [magnitude].
  const Magnitude(num magnitude)
      : this._(
          scale: magnitude,
          symbol: "$magnitude",
        );

  /// Creates a [Magnitude] representing the ratio of [numerator] to [denominator].
  Magnitude.ratio(num numerator, num denominator)
      : this._(
          scale: numerator / denominator,
          symbol: ratioToScript(numerator.toString(), denominator.toString()),
        );

  /// Creates a [Magnitude] representing [base] raised to the power of [exponent].
  Magnitude.power(num base, num exponent)
      : this._(
          scale: pow(base, exponent),
          symbol: "$base${numToSuperscript(exponent.toString())}",
        );
}
