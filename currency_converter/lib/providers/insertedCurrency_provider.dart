import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/insertedCurrency_notifier.dart';

final insertedCurrencyProvider =
    StateNotifierProvider((ref) => InsertedCurrencyNotifier());
