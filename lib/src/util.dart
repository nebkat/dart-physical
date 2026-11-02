import 'dart:math';

extension NumberExtension on num {
  /// Returns the number as an integer if it is an exact integer.
  ///
  /// For example:
  /// ```dart
  /// (5.0).toIntIfExact() == 5;
  /// (5.1).toIntIfExact() == 5.1;
  /// ```
  num toIntIfExact() => this != toInt() ? this : toInt();

  /// Returns the number rounded to a certain number of decimal places.
  double toPrecision(int fractionDigits) {
    final mod = pow(10, fractionDigits).toDouble();
    return (this * mod).round() / mod;
  }

  /// A decimal-point string-representation of this number, without the sign of a value
  /// that rounds to zero.
  ///
  /// See [num.toStringAsFixed].
  String toStringAsFixedNoNegativeZero(int fractionDigits) {
    final fixed = toStringAsFixed(fractionDigits);
    return fixed.startsWith('-') && !fixed.contains(RegExp('[1-9]')) ? fixed.substring(1) : fixed;
  }

  /// A decimal-point string-representation of this number without trailing zeros, or the
  /// sign of a value that rounds to zero.
  ///
  /// See [num.toStringAsFixed].
  String toStringAsFixedNoTrailing(int fractionDigits) =>
      toStringAsFixedNoNegativeZero(fractionDigits).replaceFirst(RegExp(r'(?:(?<=\.\d+)|\.)0+$'), '');
}
