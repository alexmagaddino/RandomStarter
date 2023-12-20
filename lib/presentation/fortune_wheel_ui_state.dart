import 'package:equatable/equatable.dart';

sealed class FortuneWheelUiState implements Equatable {
  const FortuneWheelUiState();

  @override
  bool? get stringify => true;

  factory FortuneWheelUiState.loading() => Loading();

  factory FortuneWheelUiState.error({required String error}) =>
      UiStateError(error: error);

  factory FortuneWheelUiState.success({required List<String> names}) =>
      UiStateSuccess(names: names);
}

final class Loading extends FortuneWheelUiState {
  @override
  List<Object?> get props => [];
}

final class UiStateSuccess extends FortuneWheelUiState {
  final List<String> names;

  const UiStateSuccess({required this.names});

  @override
  List<Object?> get props => [names];
}

final class UiStateError extends FortuneWheelUiState {
  final String error;

  const UiStateError({required this.error});

  @override
  List<Object?> get props => [];
}
