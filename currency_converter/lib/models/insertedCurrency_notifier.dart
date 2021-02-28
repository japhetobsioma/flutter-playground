import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class InsertedCurrencyNotifier extends StateNotifier<InsertedCurrency> {
  InsertedCurrencyNotifier() : super(initialValue);

  static final initialValue = InsertedCurrency(
    fromInput_controller: TextEditingController(text: '0'),
    toInput_controller: TextEditingController(text: '0'),
  );

  void setFromInputController(String fromInput) {
    state = InsertedCurrency(
      fromInput_controller: TextEditingController(text: fromInput),
      toInput_controller: state.toInput_controller,
    );
  }

  void setToInputController(String toInput) {
    state = InsertedCurrency(
      fromInput_controller: state.fromInput_controller,
      toInput_controller: TextEditingController(text: toInput),
    );
  }

  void setToInitialValues() {
    state = InsertedCurrency(
      fromInput_controller: TextEditingController(text: '0'),
      toInput_controller: TextEditingController(text: '0'),
    );
  }

  String getFromInputValue() {
    return state.fromInput_controller.text;
  }

  String getToInputValue() {
    return state.toInput_controller.text;
  }
}

class InsertedCurrency {
  InsertedCurrency({
    this.fromInput_controller,
    this.toInput_controller,
  });

  final TextEditingController fromInput_controller;
  final TextEditingController toInput_controller;
}
