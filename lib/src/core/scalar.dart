import '../units/scalar.dart';
import 'dimensions.dart';
import 'quantity.dart';
import 'unit.dart';

/// A dimensionless scalar [Quantity].
///
/// Specialization of [Quantity] that provides stronger typing on many operations
/// that are guaranteed to return a scalar result.
///
/// Allows interaction with raw [num] values in addition, subtraction and comparison.
extension type Scalar._(Quantity q) implements DimensionedQuantity<Scalar> {
  Scalar(Quantity q) : q = Dimensions.empty().checked(q);
  const Scalar.zero() : q = const Quantity.of(0, one);
  const Scalar.identity() : q = const Quantity.of(1, one);
  Scalar.of(num value, Unit unit) : this(Quantity.of(value, unit));
  Scalar.one(num value) : this._(qty(value, one));
  Scalar.percent(num value) : this._(qty(value, percent));
  Scalar.perMille(num value) : this._(qty(value, perMille));
  Scalar.partsPerMillion(num value) : this._(qty(value, partsPerMillion));
  Scalar.partsPerBillion(num value) : this._(qty(value, partsPerBillion));

  /// Adds two scalars, converting the addend to the units of this scalar.
  ///
  /// [addend] may be a [Quantity] or a raw [num].
  Scalar operator +(Object addend) => q + numToScalar(addend) as Scalar;

  /// Subtracts two scalars, converting the subtrahend to the units of this scalar.
  ///
  /// [subtrahend] may be a [Quantity] or a raw [num].
  Scalar operator -(Object subtrahend) => q - numToScalar(subtrahend) as Scalar;

  Scalar operator ^(Object exponent) => q ^ exponent as Scalar;

  Scalar inverse() => q.inverse() as Scalar;
  Scalar squared() => this ^ 2;
  Scalar cubed() => this ^ 3;
  Scalar sqrt() => this ^ (0.5);
  Scalar cbrt() => this ^ (1 / 3);

  /// Whether this scalar is numerically smaller than [other] in common units.
  ///
  /// [other] may be a [Quantity] or a raw [num].
  bool operator <(Object other) => q < numToScalar(other);

  /// Whether this scalar is numerically smaller than or equal to [other] in common units.
  ///
  /// [other] may be a [Quantity] or a raw [num].
  bool operator <=(Object other) => q <= numToScalar(other);

  /// Whether this scalar is numerically larger than [other] in common units.
  ///
  /// [other] may be a [Quantity] or a raw [num].
  bool operator >(Object other) => q > numToScalar(other);

  /// Whether this scalar is numerically larger than or equal to [other] in common units.
  ///
  /// [other] may be a [Quantity] or a raw [num].
  bool operator >=(Object other) => q >= numToScalar(other);
}
