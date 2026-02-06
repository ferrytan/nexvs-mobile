import 'package:dartz/dartz.dart';
import 'failures.dart';

/// Type alias for Result which can be either a Failure or a Success (Type T).
typedef Result<T> = Either<Failure, T>;

/// Extension on Result to provide convenient methods.
extension ResultX<T> on Result<T> {
  /// Returns true if the result is a success.
  bool get isSuccess => isRight();

  /// Returns true if the result is a failure.
  bool get isFailure => isLeft();

  /// Get the success value or null.
  T? get getOrNull => fold((_) => null, (data) => data);

  /// Get the failure or null.
  Failure? get failureOrNull => fold((failure) => failure, (_) => null);

  /// Execute [onSuccess] if result is success, otherwise return [orElse].
  T foldOrElse(T Function(Failure) orElse, T Function(T) onSuccess) {
    return fold(orElse, onSuccess);
  }

  /// Execute callback on success.
  Result<T> whenSuccess(void Function(T data) callback) {
    return fold((_) => this, (data) {
      callback(data);
      return this;
    });
  }

  /// Execute callback on failure.
  Result<T> whenFailure(void Function(Failure failure) callback) {
    return fold((failure) {
      callback(failure);
      return this;
    }, (_) => this);
  }
}
