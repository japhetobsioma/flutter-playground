import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/themeMode_provider.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    const tooltip = 'Random Theme';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose theme'),
      ),
      body: Column(
        children: [
          BuildRadioListTile(
            title: const Text('System'),
            value: ThemeMode.system,
          ),
          BuildRadioListTile(
            title: const Text('Light'),
            value: ThemeMode.light,
          ),
          BuildRadioListTile(
            title: const Text('Dark'),
            value: ThemeMode.dark,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.casino),
        onPressed: () {
          context.read(themeModeProvider).randomThemeMode();
        },
        tooltip: tooltip,
      ),
    );
  }
}

class BuildRadioListTile extends HookWidget {
  const BuildRadioListTile({
    this.title,
    this.value,
  });

  final Widget title;
  final ThemeMode value;

  @override
  Widget build(BuildContext context) {
    final themeModeModel = useProvider(themeModeProvider.state).data.value;

    return RadioListTile(
      title: title,
      value: value,
      groupValue: themeModeModel,
      onChanged: (value) {
        context.read(themeModeProvider).updateThemeMode(value);
      },
    );
  }
}
