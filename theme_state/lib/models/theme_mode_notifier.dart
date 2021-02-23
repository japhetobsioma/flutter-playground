import 'package:flutter/material.dart';
import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ThemeModeNotifier extends StateNotifier<ThemeModeModel> {
  ThemeModeNotifier() : super(initialValue);

  static const initialValue = ThemeModeModel(themeMode: ThemeMode.light);

  void changeThemeMode(ThemeMode themeMode) {
    state = ThemeModeModel(themeMode: themeMode);
  }

  void randomThemeMode() {
    final randomNumber = Random().nextInt(3);

    switch (randomNumber) {
      case 0:
        state = ThemeModeModel(themeMode: ThemeMode.light);
        break;
      case 1:
        state = ThemeModeModel(themeMode: ThemeMode.dark);
        break;
      case 2:
        state = ThemeModeModel(themeMode: ThemeMode.system);
        break;
    }
  }
}

class ThemeModeModel {
  const ThemeModeModel({this.themeMode});
  final ThemeMode themeMode;
}
