import 'package:equatable/equatable.dart';

sealed class FortuneWheelUiState implements Equatable {
  const FortuneWheelUiState();

  @override
  bool? get stringify => true;

  factory FortuneWheelUiState.loading() => Loading();

  factory FortuneWheelUiState.error({required String error}) =>
      UiStateError(error: error);

  factory FortuneWheelUiState.success({
    required List<String> names,
    required Stream<int> randomPosition,
  }) =>
      UiStateSuccess(names: names, streamPosition: randomPosition);
}

final class Loading extends FortuneWheelUiState {
  @override
  List<Object?> get props => [];
}

final class UiStateSuccess extends FortuneWheelUiState {
  final List<String> names;
  final Stream<int> streamPosition;

  const UiStateSuccess({required this.names, required this.streamPosition});

  UiStateSuccess copyWith({required Stream<int> randomPosition}) =>
      UiStateSuccess(
        names: names,
        streamPosition: randomPosition,
      );

  @override
  List<Object?> get props => [names];
}

final class UiStateError extends FortuneWheelUiState {
  final String error;

  const UiStateError({required this.error});

  @override
  List<Object?> get props => [];
}
