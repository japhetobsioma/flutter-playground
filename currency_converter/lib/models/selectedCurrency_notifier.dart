import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectedCurrencyNotifier extends StateNotifier<SelectedCurrency> {
  SelectedCurrencyNotifier() : super(initialValue);

  static final initialValue = SelectedCurrency(
    from_currencyId: 'MYR',
    from_currencyName: 'Malaysian ringgit',
    to_currencyId: 'PHP',
    to_currencyName: 'Philippine peso',
    from_controller: TextEditingController(text: 'Malaysian ringgit'),
    to_controller: TextEditingController(text: 'Philippine peso'),
  );

  void setFromCurrency(String from_currencyId, String from_currencyName) {
    if (from_currencyId == state.to_currencyId &&
        from_currencyName == state.to_currencyName) {
      state = SelectedCurrency(
        from_currencyId: state.to_currencyId,
        from_currencyName: state.to_currencyName,
        to_currencyId: state.from_currencyId,
        to_currencyName: state.from_currencyName,
        from_controller: state.to_controller,
        to_controller: TextEditingController(text: state.from_currencyName),
      );
    } else {
      state = SelectedCurrency(
        from_currencyId: from_currencyId,
        from_currencyName: from_currencyName,
        to_currencyId: state.to_currencyId,
        to_currencyName: state.to_currencyName,
        from_controller: TextEditingController(text: from_currencyName),
        to_controller: state.to_controller,
      );
    }
  }

  void setToCurrency(String to_currencyId, String to_currencyName) {
    if (to_currencyId == state.from_currencyId &&
        to_currencyName == state.from_currencyName) {
      state = SelectedCurrency(
        from_currencyId: state.to_currencyId,
        from_currencyName: state.to_currencyName,
        to_currencyId: state.from_currencyId,
        to_currencyName: state.from_currencyName,
        from_controller: TextEditingController(text: state.to_currencyName),
        to_controller: state.from_controller,
      );
    } else {
      state = SelectedCurrency(
        from_currencyId: state.from_currencyId,
        from_currencyName: state.from_currencyName,
        to_currencyId: to_currencyId,
        to_currencyName: to_currencyName,
        from_controller: state.from_controller,
        to_controller: TextEditingController(text: to_currencyName),
      );
    }
  }

  String getFromCurrencyName() {
    return state.from_currencyName;
  }

  String getToCurrencyName() {
    return state.to_currencyName;
  }
}

class SelectedCurrency {
  const SelectedCurrency({
    this.from_currencyId,
    this.to_currencyId,
    this.from_currencyName,
    this.to_currencyName,
    this.from_controller,
    this.to_controller,
  });

  final String from_currencyId;
  final String from_currencyName;
  final String to_currencyId;
  final String to_currencyName;
  final TextEditingController from_controller;
  final TextEditingController to_controller;
}
