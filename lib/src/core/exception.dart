/// The base class for all exceptions thrown in relation to quantities.
class QuantityException implements Exception {
  /// Constructs a QuantityException with an optional message\
  const QuantityException([this.message]);

  /// The optional message to display.
  final String? message;

  @override
  String toString() {
    if (message == null) return ((QuantityException)).toString();
    return "${((QuantityException))}: $message";
  }
}


/// This Exception is thrown when an attempt is made to perform an
/// operation on a Quantity having unexpected or illegal dimensions.
class DimensionsException extends QuantityException {
  /// Constructs a DimensionsException with an optional message.
  DimensionsException([super.message]);

  @override
  String toString() {
    if (message == null) return ((DimensionsException)).toString();
    return "${((DimensionsException))}: $message";
  }
}