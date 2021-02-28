import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/currency_notifier.dart';

final currencyProvider = StateNotifierProvider((ref) => CurrencyNotifier());
