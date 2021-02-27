import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/currency.dart';
import '../providers/currency_provider.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final currencyModel = useProvider(currencyProvider.state);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parsing JSON'),
      ),
      body: currencyModel.when(
        data: (value) => BuildListView(value),
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

class BuildListView extends StatelessWidget {
  const BuildListView(this.value);
  final Currency value;

  @override
  Widget build(BuildContext context) {
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
                ' - ${value.results[val].currencySymbol}'),
            onTap: () {
              print('${value.results[val].currencyName}');
            },
          ),
        );
      },
    );
  }
}
