import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:hooks_riverpod/all.dart';

import 'model/timer.dart';

final timerProvider =
    StateNotifierProvider<TimerNotifier>((ref) => TimerNotifier());

final _buttonState = Provider<ButtonState>((ref) {
  return ref.watch(timerProvider.state).buttonState;
});

final buttonProvider = Provider<ButtonState>((ref) {
  return ref.watch(_buttonState);
});

final _timeLeftProvider = Provider<String>((ref) {
  return ref.watch(timerProvider.state).timeLeft;
});

final timeLeftProvider = Provider<String>((ref) {
  return ref.watch(_timeLeftProvider);
});

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();

  @override
  Widget build(BuildContext context) {
    print('Building MyHomePage');
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TimerTextWidget(),
            SizedBox(
              height: 20.0,
            ),
            ButtonsContainer(),
          ],
        ),
      ),
    );
  }
}

class TimerTextWidget extends HookWidget {
  const TimerTextWidget();

  @override
  Widget build(BuildContext context) {
    final timeLeft = useProvider(timeLeftProvider);

    print('Building TimerTextWidget $timeLeft');

    return Text(
      timeLeft,
      style: Theme.of(context).textTheme.headline2,
    );
  }
}

class ButtonsContainer extends HookWidget {
  const ButtonsContainer();

  @override
  Widget build(BuildContext context) {
    final state = useProvider(buttonProvider);

    print('Building ButtonsContainer');

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state == ButtonState.initial) ...[
          StartButton(),
        ],
        if (state == ButtonState.started) ...[
          PauseButton(),
          SizedBox(
            width: 20,
          ),
          ResetButton(),
        ],
        if (state == ButtonState.paused) ...[
          StartButton(),
          SizedBox(
            width: 20,
          ),
          ResetButton(),
        ],
        if (state == ButtonState.finished) ...[
          ResetButton(),
        ]
      ],
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read(timerProvider).start();
      },
      child: Icon(
        Icons.play_arrow,
      ),
    );
  }
}

class PauseButton extends StatelessWidget {
  const PauseButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read(timerProvider).pause();
      },
      child: Icon(
        Icons.pause,
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.read(timerProvider).reset();
      },
      child: Icon(
        Icons.replay,
      ),
    );
  }
}
