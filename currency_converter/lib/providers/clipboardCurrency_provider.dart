import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/clipboardCurrency_notifier.dart';

final clipboardCurrencyProvider =
    StateNotifierProvider((ref) => ClipboardCurrencyNotifier(ref: ref));
