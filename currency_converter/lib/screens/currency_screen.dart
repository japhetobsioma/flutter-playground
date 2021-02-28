import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../providers/clipboardCurrency_provider.dart';
import '../providers/selectedCurrency_provider.dart';
import '../providers/currency_provider.dart';
import '../providers/convert_provider.dart';
import '../models/currency.dart';

class CurrencyScreen extends HookWidget {
  const CurrencyScreen();

  @override
  Widget build(BuildContext context) {
    final previousDestination = ModalRoute.of(context).settings.arguments;
    final currencyModel = useProvider(currencyProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose currency'),
      ),
      body: currencyModel.when(
        data: (value) => BuildListView(value, previousDestination),
        loading: () => Center(
          child: const CircularProgressIndicator(),
        ),
        error: (error, _) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

class BuildListView extends HookWidget {
  const BuildListView(this.value, this.previousDestination);
  final Currency value;
  final Object previousDestination;

  @override
  Widget build(BuildContext context) {
    final selectedCurrencyModel = useProvider(selectedCurrencyProvider.state);

    return ListView.builder(
      itemCount: value.results.keys.length,
      itemBuilder: (context, index) {
        var keys = value.results.keys.toList();
        keys.sort((a, b) => a.toString().compareTo(b.toString()));
        var val = keys[index];

        return Card(
          child: ListTile(
            title: Text('${val}'
                ' - ${value.results[val].name}'),
            subtitle: Text('${value.results[val].currencyName}'
                ' - ${value.results[val].currencyId}'
                ' - ${value.results[val].currencySymbol}'),
            onTap: () {
              if (previousDestination == 'FromCurrency') {
                context.read(selectedCurrencyProvider).setFromCurrency(
                    '${value.results[val].currencyId}',
                    '${value.results[val].currencyName}');
                if (value.results[val].currencyId ==
                        selectedCurrencyModel.to_currencyId &&
                    value.results[val].currencyName ==
                        selectedCurrencyModel.to_currencyName) {
                  context.read(convertProvider).loadConvert(
                      selectedCurrencyModel.to_currencyId,
                      selectedCurrencyModel.from_currencyId);
                } else {
                  context.read(convertProvider).loadConvert(
                      value.results[val].currencyId,
                      selectedCurrencyModel.to_currencyId);
                }
              } else {
                context.read(selectedCurrencyProvider).setToCurrency(
                    '${value.results[val].currencyId}',
                    '${value.results[val].currencyName}');
                if (value.results[val].currencyId ==
                        selectedCurrencyModel.from_currencyId &&
                    value.results[val].currencyName ==
                        selectedCurrencyModel.from_currencyName) {
                  context.read(convertProvider).loadConvert(
                      selectedCurrencyModel.to_currencyId,
                      selectedCurrencyModel.from_currencyId);
                } else {
                  context.read(convertProvider).loadConvert(
                      selectedCurrencyModel.from_currencyId,
                      value.results[val].currencyId);
                }
              }

              context
                  .read(clipboardCurrencyProvider)
                  .setConversionStatus('FromTo');

              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}
