import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:theme_state/providers/themeMode_provider.dart';

import 'screens/home.dart';

void main() {
  runApp(
    ProviderScope(child: const MyApp()),
  );
}

class MyApp extends HookWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final themeModeModel = useProvider(themeModeProvider.state);
    const title = 'Theme State';

    return themeModeModel.when(
      data: (value) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: value,
        title: title,
        home: HomeScreen(),
      ),
      loading: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
      error: (e, s) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: Text('Error: $e, Stacktrace: $s'),
          ),
        ),
      ),
    );
  }
}
