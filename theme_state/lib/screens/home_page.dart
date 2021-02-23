import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/theme_mode_provider.dart';

class HomePage extends HookWidget {
  const HomePage();
  static const fabTooltip = 'Random';

  @override
  Widget build(BuildContext context) {
    final themeModeModel = useProvider(themeModeProvider.state).themeMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose theme'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RadioListTile(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: themeModeModel,
            onChanged: (value) {
              context.read(themeModeProvider).changeThemeMode(value);
            },
          ),
          RadioListTile(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: themeModeModel,
            onChanged: (value) {
              context.read(themeModeProvider).changeThemeMode(value);
            },
          ),
          RadioListTile(
            title: const Text('System'),
            value: ThemeMode.system,
            groupValue: themeModeModel,
            onChanged: (value) {
              context.read(themeModeProvider).changeThemeMode(value);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read(themeModeProvider).randomThemeMode();
        },
        child: const Icon(Icons.casino),
        tooltip: fabTooltip,
      ),
    );
  }
}
