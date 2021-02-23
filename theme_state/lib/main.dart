import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'providers/theme_mode_provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(
    ProviderScope(child: const MyApp()),
  );
}

class MyApp extends HookWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final themeMode = useProvider(themeModeProvider.state).themeMode;
    const title = 'Theme State';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode,
      title: title,
      home: const HomePage(),
    );
  }
}
