import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/themeMode_provider.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final themeModeModel = useProvider(themeModeProvider.state).data.value;
    const tooltip = 'Random Theme';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose theme'),
      ),
      body: Column(
        children: [
          RadioListTile(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: themeModeModel,
            onChanged: (value) {
              context.read(themeModeProvider).updateThemeMode(value);
            },
          ),
          RadioListTile(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: themeModeModel,
            onChanged: (value) {
              context.read(themeModeProvider).updateThemeMode(value);
            },
          ),
          RadioListTile(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: themeModeModel,
            onChanged: (value) {
              context.read(themeModeProvider).updateThemeMode(value);
            },
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
