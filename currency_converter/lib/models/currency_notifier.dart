import 'package:flutter/services.dart' show rootBundle;

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'currency.dart';

class CurrencyNotifier extends StateNotifier<AsyncValue<Currency>> {
  CurrencyNotifier() : super(const AsyncValue.loading()) {
    loadCurrency();
  }

  Future<String> loadCurrencyAsset() async {
    return await rootBundle.loadString('assets/currency.json');
  }

  Future<void> loadCurrency() async {
    var jsonString = await loadCurrencyAsset();
    final jsonResponse = currencyFromJson(jsonString);
    state = AsyncValue.data(Currency.fromJson(jsonResponse.toJson()));
  }
}
