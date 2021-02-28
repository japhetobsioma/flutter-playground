import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../providers/insertedCurrency_provider.dart';
import '../providers/timeRequested_provider.dart';
import 'convert.dart';

class ConvertNotifier extends StateNotifier<AsyncValue<Convert>> {
  ConvertNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadConvert('MYR', 'PHP');
  }

  final ProviderReference ref;

  Future<void> loadConvert(String from_currency, String to_currency) async {
    final response =
        await http.get('https://free.currconv.com/api/v7/convert?q='
            '${from_currency}_${to_currency}'
            '&compact=ultra&apiKey=${env['CURRENCY_CONVERTER_API']}');
    log('API CALL');

    state = AsyncValue.data(
        convertFromJson(response.body, '$from_currency', '$to_currency'));

    ref.read(insertedCurrencyProvider).setToInitialValues();

    var now = DateTime.now();
    var formatter = DateFormat.yMMMMd().add_jm();
    var formattedDate = formatter.format(now);

    ref.read(timeRequestedProvider).setTimeRequestText(formattedDate);
  }

  Future<double> getConvert(
      String from_currency, String to_currency, double value) async {
    final response =
        await http.get('https://free.currconv.com/api/v7/convert?q='
            '${from_currency}_${to_currency}'
            '&compact=ultra&apiKey=${env['CURRENCY_CONVERTER_API']}');
    log('API CALL');

    var convertValue =
        convertFromJson(response.body, '$from_currency', '$to_currency');
    return (convertValue.from_to * value);
  }
}
