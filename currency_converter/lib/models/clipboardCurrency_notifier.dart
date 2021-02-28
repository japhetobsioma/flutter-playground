import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/insertedCurrency_provider.dart';
import '../providers/selectedCurrency_provider.dart';

class ClipboardCurrencyNotifier extends StateNotifier<ClipboardCurrency> {
  ClipboardCurrencyNotifier({this.ref}) : super(initialValue);

  final ProviderReference ref;

  static final initialValue = ClipboardCurrency(
    clipboardCurrencyText: '',
    conversionStatus: 'FromTo',
  );

  String getClipboardFromTo() {
    final fromValue = ref.read(insertedCurrencyProvider).getFromInputValue();
    final fromCurrencyName =
        ref.read(selectedCurrencyProvider).getFromCurrencyName();
    final toValue = ref.read(insertedCurrencyProvider).getToInputValue();
    final toCurrencyName =
        ref.read(selectedCurrencyProvider).getToCurrencyName();

    return '$fromValue $fromCurrencyName equals $toValue $toCurrencyName';
  }

  String getClipboardToFrom() {
    final fromValue = ref.read(insertedCurrencyProvider).getFromInputValue();
    final fromCurrencyName =
        ref.read(selectedCurrencyProvider).getFromCurrencyName();
    final toValue = ref.read(insertedCurrencyProvider).getToInputValue();
    final toCurrencyName =
        ref.read(selectedCurrencyProvider).getToCurrencyName();

    return '$toValue $toCurrencyName equals $fromValue $fromCurrencyName';
  }

  void setConversionStatus(String conversionStatus) {
    state = ClipboardCurrency(
      clipboardCurrencyText: state.clipboardCurrencyText,
      conversionStatus: conversionStatus,
    );
  }
}

class ClipboardCurrency {
  const ClipboardCurrency({this.clipboardCurrencyText, this.conversionStatus});
  final String clipboardCurrencyText;
  final String conversionStatus;
}
