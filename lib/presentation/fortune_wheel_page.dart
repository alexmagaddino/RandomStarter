import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:random_starter/common/dependency_injector.dart';
import 'package:random_starter/presentation/fortune_wheel_cubit.dart';
import 'package:random_starter/presentation/fortune_wheel_ui_state.dart';

class FortuneWheelPage extends StatelessWidget {
  const FortuneWheelPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FortuneWheelCubit>(
      create: (_) => injector.get(),
      child: const _FortuneWheelPage(),
    );
  }
}

class _FortuneWheelPage extends StatelessWidget {
  const _FortuneWheelPage();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FortuneWheelCubit>();
    cubit.getNames();
    return BlocBuilder<FortuneWheelCubit, FortuneWheelUiState>(
      builder: (_, state) => Scaffold(
        appBar: AppBar(
          title: const Text('Chi inizierà per primo oggi?'),
          backgroundColor: Theme.of(context).secondaryHeaderColor,
        ),
        body: Center(
          child: switch (state) {
            Loading _ => const CircularProgressIndicator(),
            UiStateError _ => const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.warning,
                    color: Colors.yellow,
                    size: 40,
                  ),
                  SizedBox(height: 16),
                  Text('Ops, c\'è stato un problema'),
                  Text(
                    'Controlla che in "~/.random_starter/names.json" '
                    'ci sia un array di stringhe',
                  ),
                ],
              ),
            UiStateSuccess _ => _FortuneWheel(state.names, cubit),
          },
        ),
      ),
    );
  }
}

class _FortuneWheel extends StatefulWidget {
  final List<String> _elements;
  final FortuneWheelCubit _cubit;

  const _FortuneWheel(this._elements, this._cubit);

  @override
  State<_FortuneWheel> createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<_FortuneWheel> {
  @override
  void dispose() {
    widget._cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: FortuneWheel(
            selected: widget._cubit.streamPosition.stream,
            items: [
              for (final element in widget._elements)
                FortuneItem(child: Text(element))
            ],
          ),
        ),
        Flexible(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                widget._cubit.getRandomPos();
              });
            },
            child: const Text('Roll'),
          ),
        ),
      ],
    );
  }
}
