extension NumberExtension on num {
  /// Returns the number as an integer if it is an exact integer.
  ///
  /// For example:
  /// ```dart
  /// (5.0).toIntIfExact() == 5;
  /// (5.1).toIntIfExact() == 5.1;
  /// ```
  num toIntIfExact() => this != toInt() ? this : toInt();
}
