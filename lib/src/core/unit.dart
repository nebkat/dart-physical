import 'dart:math';

import '../format/script.dart';
import 'dimensions.dart';
import 'quantity.dart';

/// A unit is a particular physical quantity, defined and adopted by
/// convention, with which other particular quantities of the same kind
/// (dimensions) are compared to express their value.
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

  /// The origin of the unit, if it is implicit (e.g. 273.15K for degrees Celsius).
  final QuantityOrigin? implicitOrigin;

  /// The symbol of the unit, wrapped in square brackets if it is not a NamedUnit.
  String get safeSymbol => this is NamedUnit ? symbol : "[$symbol]";

  /// The singular name of the unit, wrapped in square brackets if it is not a NamedUnit.
  String get safeSingular => this is NamedUnit ? singular : "[$singular]";

  /// The plural name of the unit, wrapped in square brackets if it is not a NamedUnit.
  String get safePlural => this is NamedUnit ? plural : "[$plural]";

  const Unit({
    this.scale = 1,
    required this.dimensions,
    this.implicitOrigin,
    required this.symbol,
    required this.singular,
    required this.plural,
    this.spaceBeforeSymbol = true,
  });

  static const Unit one = RealUnit(
    dimensions: Dimensions.empty(),
    scale: 1,
    symbol: '1',
    singular: 'one',
    plural: 'one',
  );

  Quantity quantity(num value) => Quantity(value, this);

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

  Unit operator *(Unit other) {
    if (identical(this, one)) return other;
    if (identical(other, one)) return this;
    return DerivedUnit(
      dimensions: dimensions * other.dimensions,
      scale: scale * other.scale,
      // If the other unit is dimensionless we can preserve the implicit origin
      implicitOrigin: other.dimensions == Dimensions.empty() ? implicitOrigin : null,
      symbol: '$safeSymbol·${other.safeSymbol}',
      singular: '$safeSingular-${other.safeSingular}',
      plural: '$safeSingular-${other.safePlural}',
    );
  }

  Unit operator /(Unit other) {
    if (identical(this, one)) return other;
    if (identical(other, one)) return this;
    return DerivedUnit(
      dimensions: dimensions / other.dimensions,
      scale: scale / other.scale,
      // If the other unit is dimensionless we can preserve the implicit origin
      implicitOrigin: other.dimensions == Dimensions.empty() ? implicitOrigin : null,
      symbol: '$safeSymbol/${other.safeSymbol}',
      singular: '$safeSingular per ${other.safeSingular}',
      plural: '$safePlural per ${other.safeSingular}',
    );
  }

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

  DerivedUnit squared() => DerivedUnit(
        dimensions: dimensions ^ 2,
        scale: pow(scale, 2),
        symbol: '$safeSymbol²',
        singular: '$safeSingular squared',
        plural: '$safePlural squared',
      );

  DerivedUnit cubed() => DerivedUnit(
        dimensions: dimensions ^ 2,
        scale: pow(scale, 2),
        symbol: '$safeSymbol³',
        singular: '$safeSingular cubed',
        plural: '$safePlural cubed',
      );

  @override
  bool operator ==(Object other) {
    return other is Unit && scale == other.scale && dimensions == other.dimensions;
  }

  @override
  int get hashCode => Object.hashAll([symbol, dimensions, scale]);

  @override
  String toString() => symbol;

  get symbolWithSpace => spaceBeforeSymbol ? ' $symbol' : symbol;
  get symbolForQuantity => this == one ? '' : symbolWithSpace;
}

class AnonymousUnit extends Unit {
  const AnonymousUnit({
    required super.dimensions,
    super.scale = 1,
  }) : super(
          symbol: 'anonymous',
          singular: 'anonymous',
          plural: 'anonymous',
          spaceBeforeSymbol: false,
        );
}

abstract class NamedUnit extends Unit {
  const NamedUnit({
    required super.dimensions,
    super.scale = 1,
    required super.symbol,
    required super.singular,
    required super.plural,
    super.spaceBeforeSymbol = true,
    super.implicitOrigin,
  });
}

class RealUnit extends NamedUnit {
  const RealUnit({
    required super.dimensions,
    super.scale = 1,
    super.implicitOrigin,
    required super.symbol,
    required super.singular,
    required super.plural,
    super.spaceBeforeSymbol = true,
  });

  /// Returns the derived Units having the 10^24 prefix, yotta (Y).
  PrefixedRealUnit get yotta => PrefixedRealUnit.fromRealUnit(this, 'Y', 'yotta', 1.0e24);

  /// Returns the derived Units having the 10^21 prefix, zetta (Z).
  PrefixedRealUnit get zetta => PrefixedRealUnit.fromRealUnit(this, 'Z', 'zetta', 1.0e21);

  /// Returns the derived Units having the 10^18 prefix, exa (E).
  // ignore: prefer_int_literals
  PrefixedRealUnit get exa => PrefixedRealUnit.fromRealUnit(this, 'E', 'exa', 1.0e18);

  /// Returns the derived Units having the 10^15 prefix, peta (P).
  // ignore: prefer_int_literals
  PrefixedRealUnit get peta => PrefixedRealUnit.fromRealUnit(this, 'P', 'peta', 1.0e15);

  /// Returns the derived Units having the 10^12 prefix, tera (T).
  // ignore: prefer_int_literals
  PrefixedRealUnit get tera => PrefixedRealUnit.fromRealUnit(this, 'T', 'tera', 1.0e12);

  /// Returns the derived Units having the 10^9 prefix, giga (G).
  // ignore: prefer_int_literals
  PrefixedRealUnit get giga => PrefixedRealUnit.fromRealUnit(this, 'G', 'giga', 1.0e9);

  /// Returns the derived Units having the 10^6 prefix, mega (M).
  // ignore: prefer_int_literals
  PrefixedRealUnit get mega => PrefixedRealUnit.fromRealUnit(this, 'M', 'mega', 1.0e6);

  /// Returns the derived Units having the 10^3 (i.e., 1000) prefix, kilo (k).
  PrefixedRealUnit get kilo => PrefixedRealUnit.fromRealUnit(this, 'k', 'kilo', 1000);

  ///  Returns the derived Units having the 10^2 (i.e., 100) prefix, hecto (h).
  PrefixedRealUnit get hecto => PrefixedRealUnit.fromRealUnit(this, 'h', 'hecto', 100);

  /// Returns the derived Units having the 10^1 (i.e. 10) prefix, deca (da).
  PrefixedRealUnit get deca => PrefixedRealUnit.fromRealUnit(this, 'da', 'deca', 10);

  /// Returns the derived Units having the 10^-1 (i.e., 0.1) prefix, deci (d).
  PrefixedRealUnit get deci => PrefixedRealUnit.fromRealUnit(this, 'd', 'deci', 0.1);

  /// Returns the derived Units having the 10^-2 (i.e., 0.01) prefix, centi (c).
  PrefixedRealUnit get centi => PrefixedRealUnit.fromRealUnit(this, 'c', 'centi', 0.01);

  /// Returns the derived Units having the 10^-3 (i.e., 0.001) prefix, milli (m).
  PrefixedRealUnit get milli => PrefixedRealUnit.fromRealUnit(this, 'm', 'milli', 0.001);

  /// Returns the derived Units having the 10^-6 prefix, micro (the symbol mu).
  PrefixedRealUnit get micro => PrefixedRealUnit.fromRealUnit(this, '\u00b5', 'micro', 1.0e-6);

  /// Returns the derived Units having the 10^-9 prefix, nano (n).
  PrefixedRealUnit get nano => PrefixedRealUnit.fromRealUnit(this, 'n', 'nano', 1.0e-9);

  /// Returns the derived Units having the 10^-12 prefix, pico (p).
  PrefixedRealUnit get pico => PrefixedRealUnit.fromRealUnit(this, 'p', 'pico', 1.0e-12);

  /// Returns the derived Units having the 10^-15 prefix, femto (f).
  PrefixedRealUnit get femto => PrefixedRealUnit.fromRealUnit(this, 'f', 'femto', 1.0e-15);

  /// Returns the derived Units having the 10^-18 prefix, atto (a).
  PrefixedRealUnit get atto => PrefixedRealUnit.fromRealUnit(this, 'a', 'atto', 1.0e-18);

  /// Returns the derived Units having the 10^-21 prefix, zepto (z).
  PrefixedRealUnit get zepto => PrefixedRealUnit.fromRealUnit(this, 'z', 'zepto', 1.0e-21);

  /// Returns the derived Units having the 10^-24 prefix, yocto (y).
  PrefixedRealUnit get yocto => PrefixedRealUnit.fromRealUnit(this, 'y', 'yocto', 1.0e-24);
}

class PrefixedRealUnit extends NamedUnit {
  const PrefixedRealUnit({
    required super.symbol,
    required super.singular,
    required super.plural,
    required super.dimensions,
    super.scale = 1,
    super.spaceBeforeSymbol = true,
    super.implicitOrigin,
  });

  PrefixedRealUnit.fromRealUnit(RealUnit realUnit, String symbolPrefix, String namePrefix, double scale)
      : super(
          symbol: '$symbolPrefix${realUnit.symbol}',
          singular: '$namePrefix${realUnit.singular}',
          plural: '$namePrefix${realUnit.plural}',
          dimensions: realUnit.dimensions,
          scale: realUnit.scale * scale,
        );
}

typedef UnprefixableRealUnit = PrefixedRealUnit;

class DerivedUnit extends Unit {
  const DerivedUnit({
    required super.symbol,
    required super.singular,
    required super.plural,
    required super.dimensions,
    required super.scale,
    super.spaceBeforeSymbol = true,
    super.implicitOrigin,
  });

  DerivedUnit renamed({
    String? symbol,
    String? singular,
    String? plural,
    bool? spaceBeforeSymbol,
  }) =>
      DerivedUnit(
        dimensions: dimensions,
        scale: scale,
        implicitOrigin: implicitOrigin,
        symbol: symbol ?? this.symbol,
        singular: singular ?? this.singular,
        plural: plural ?? this.plural,
        spaceBeforeSymbol: spaceBeforeSymbol ?? this.spaceBeforeSymbol,
      );
}

class Magnitude extends Unit {
  const Magnitude._({required super.scale, required super.symbol})
      : super(
          singular: symbol,
          plural: symbol,
          dimensions: const Dimensions.empty(),
          spaceBeforeSymbol: false,
        );
  const Magnitude(num magnitude)
      : this._(
          scale: magnitude,
          symbol: "$magnitude",
        );
  Magnitude.ratio(num numerator, num denominator)
      : this._(
          scale: numerator / denominator,
          symbol: ratioToScript(numerator.toString(), denominator.toString()),
        );
  Magnitude.power(num base, num exponent)
      : this._(
          scale: pow(base, exponent),
          symbol: "$base${numToSuperscript(exponent.toString())}",
        );
}
