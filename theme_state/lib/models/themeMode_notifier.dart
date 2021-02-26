import 'dart:math';

import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeModeNotifier extends StateNotifier<AsyncValue<ThemeMode>> {
  ThemeModeNotifier() : super(const AsyncValue.loading()) {
    readThemeMode();
  }

  static const sharedPreferencesKey = 'ThemeMode';

  Future<void> readThemeMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final intThemeMode = sharedPreferences.getInt(sharedPreferencesKey) ?? 0;

    final themeMode = ThemeMode.values[intThemeMode];

    state = AsyncValue.data(themeMode);
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final intThemeMode = themeMode.index;

    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(sharedPreferencesKey, intThemeMode);

    state = AsyncValue.data(themeMode);
  }

  Future<void> randomThemeMode() async {
    final randomNumber = Random().nextInt(3);

    await updateThemeMode(ThemeMode.values[randomNumber]);
  }
}
