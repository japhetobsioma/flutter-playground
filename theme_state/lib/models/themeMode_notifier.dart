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
    final stringThemeMode =
        sharedPreferences.getString(sharedPreferencesKey) ?? '';

    ThemeMode themeMode;

    switch (stringThemeMode) {
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      case 'system':
        themeMode = ThemeMode.system;
        break;
      default:
        themeMode = ThemeMode.system;
        break;
    }

    state = AsyncValue.data(themeMode);
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    String stringThemeMode;

    switch (themeMode) {
      case ThemeMode.light:
        stringThemeMode = 'light';
        break;
      case ThemeMode.dark:
        stringThemeMode = 'dark';
        break;
      case ThemeMode.system:
        stringThemeMode = 'system';
        break;
    }

    final sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(sharedPreferencesKey, stringThemeMode);
    state = AsyncValue.data(themeMode);
  }

  Future<void> randomThemeMode() async {
    final randomNumber = Random().nextInt(3);

    switch (randomNumber) {
      case 0:
        await updateThemeMode(ThemeMode.light);
        break;
      case 1:
        await updateThemeMode(ThemeMode.dark);
        break;
      case 2:
        await updateThemeMode(ThemeMode.system);
        break;
    }
  }
}
