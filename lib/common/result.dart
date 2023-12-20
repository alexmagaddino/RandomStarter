import 'package:equatable/equatable.dart';

sealed class Result<T> implements Equatable {
  const Result();

  @override
  bool? get stringify => true;

  factory Result.success(T value) => Success(value);

  factory Result.error(Exception exception) => Error(exception);
}

final class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  @override
  List<Object?> get props => [value];
}

final class Error<T> extends Result<T> {
  final Exception exception;

  const Error(this.exception);

  @override
  List<Object?> get props => [exception];
}
