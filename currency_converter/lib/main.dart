import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/themeMode_provider.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  await load(fileName: '.env');

  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends HookWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    final themeModeModel = useProvider(themeModeProvider.state);

    return themeModeModel.when(
      data: (value) => BuildMaterialApp(
        themeMode: value,
        home: HomeScreen(),
      ),
      loading: () => BuildMaterialApp(
        home: Scaffold(
          body: Center(
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
      error: (e, s) => BuildMaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error: $e, Stacktrace: $s'),
          ),
        ),
      ),
    );
  }
}

class BuildMaterialApp extends HookWidget {
  const BuildMaterialApp({
    this.themeMode = ThemeMode.system,
    this.home,
  });

  final ThemeMode themeMode;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    const title = 'Currency Converter';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      title: title,
      home: home,
    );
  }
}
