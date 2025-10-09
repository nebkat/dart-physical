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

  /// A decimal-point string-representation of this number without trailing zeros.
  ///
  /// See [num.toStringAsFixed].
  String toStringAsFixedNoTrailing(int fractionDigits) =>
      toStringAsFixed(fractionDigits).replaceFirst(RegExp(r'(?:(?<=\.\d+)|\.)0+$'), '');
}
