/// Utility class to wrap result data
sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates a successful [Result], completed with the specified [error].
  const factory Result.error(T error) = Error._;
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Returned value in result
  final T value;

  @override
  String toString() {
    return "$value";
  }
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// Returned error in result
  final T error;

  @override
  String toString() {
    return "$error";
  }
}
