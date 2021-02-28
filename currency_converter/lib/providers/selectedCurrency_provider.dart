import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/selectedCurrency_notifier.dart';

final selectedCurrencyProvider =
    StateNotifierProvider((ref) => SelectedCurrencyNotifier());
