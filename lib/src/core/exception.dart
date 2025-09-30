import 'dimensions.dart';
import 'unit.dart';

/// Base class for all exceptions thrown in relation to quantities.
class QuantityException implements Exception {
  const QuantityException([this.message]);

  final String? message;

  @override
  String toString() {
    if (message == null) return "QuantityException";
    return "QuantityException: $message";
  }
}

/// Thrown when an attempt is made to perform an operation on a [Quantity] with mismatched [Dimensions].
class DimensionsException extends QuantityException {
  DimensionsException([super.message]);

  DimensionsException.mismatch({
    required Dimensions expected,
    Unit? expectedUnits,
    required Dimensions actual,
    Unit? actualUnits,
  }) : super(
          "expected: $expected${expectedUnits == null ? '' : ' ($expectedUnits)'}, "
          "actual: $actual${actualUnits == null ? '' : ' ($actualUnits)'}",
        );

  @override
  String toString() {
    if (message == null) return "DimensionsException";
    return "DimensionsException: $message";
  }
}
