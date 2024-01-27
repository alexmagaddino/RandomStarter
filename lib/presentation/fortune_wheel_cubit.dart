import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:random_starter/common/result.dart';
import 'package:random_starter/domain/get_names_use_case.dart';
import 'package:random_starter/presentation/fortune_wheel_ui_state.dart';

class FortuneWheelCubit extends Cubit<FortuneWheelUiState> {
  final streamPosition = StreamController<int>();
  final GetNamesUseCase _getNamesUseCase;

  FortuneWheelCubit(this._getNamesUseCase)
      : super(FortuneWheelUiState.loading());

  Future getNames() async {
    final result = await _getNamesUseCase();

    final newState = switch (result) {
      Success success => FortuneWheelUiState.success(
          names: success.value,
          randomPosition: streamPosition.stream,
        ),
      Error e => FortuneWheelUiState.error(error: e.exception.toString()),
    };

    emit(newState);
  }

  void getRandomPos() {
    final currentState = state;
    if (currentState is UiStateSuccess) {
      final randomPos = Fortune.randomInt(0, currentState.names.length);
      streamPosition.add(randomPos);
    }
  }

  void dispose() {
    streamPosition.close();
  }
}
