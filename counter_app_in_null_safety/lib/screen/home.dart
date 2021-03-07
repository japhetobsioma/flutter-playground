import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/constants.dart';
import '../state/counter.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            BuildCounterText(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: tooltipText,
        onPressed: () => context.read(counterProvider).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BuildCounterText extends HookWidget {
  const BuildCounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = useProvider(counterProvider.state);

    return Text(
      '${counter.count}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
