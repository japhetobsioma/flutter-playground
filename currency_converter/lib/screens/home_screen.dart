import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Currency Converter'),
      ),
      body: ListView(
        children: [
          const CurrencyInfoSection(),
          const GraphHistorySection(),
          const InputCurrencySection(),
          const FooterSection(),
        ],
      ),
    );
  }
}

class CurrencyInfoSection extends StatelessWidget {
  const CurrencyInfoSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1 Malaysian Ringgit equals',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Colors.grey),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              '12.03 Philippine peso',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.black,
                    fontSize: 36.0,
                  ),
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              '26 Feb, 6:56 pm UTC',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

class GraphHistorySection extends StatelessWidget {
  const GraphHistorySection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
      child: Container(
        child: const Placeholder(
          fallbackHeight: 170.0,
        ),
      ),
    );
  }
}

class InputCurrencySection extends StatelessWidget {
  const InputCurrencySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          children: [
            const BuildFromCurrency(),
            const BuildToCurrency(),
          ],
        ),
      ),
    );
  }
}

class BuildFromCurrency extends StatefulWidget {
  const BuildFromCurrency();

  @override
  _BuildFromCurrencyState createState() => _BuildFromCurrencyState();
}

class _BuildFromCurrencyState extends State<BuildFromCurrency> {
  static const _currency = [
    'Malaysian Ringgit',
    'Philippine peso',
  ];

  var _selectedCurrency = 'Malaysian Ringgit';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: '1',
                contentPadding: const EdgeInsets.fromLTRB(12, 26, 12, 19),
              ),
            ),
          ),
          const SizedBox(
            width: 18.0,
          ),
          Expanded(
            child: InputDecorator(
              decoration: InputDecoration(
                labelStyle: Theme.of(context)
                    .primaryTextTheme
                    .caption
                    .copyWith(color: Colors.black),
                border: const OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  isExpanded: true,
                  isDense: true,
                  value: _selectedCurrency,
                  items: _currency.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCurrency = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildToCurrency extends StatefulWidget {
  const BuildToCurrency();

  @override
  _BuildToCurrencyState createState() => _BuildToCurrencyState();
}

class _BuildToCurrencyState extends State<BuildToCurrency> {
  static const _currency = [
    'Malaysian Ringgit',
    'Philippine peso',
  ];

  var _selectedCurrency = 'Philippine peso';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '12.03',
              contentPadding: const EdgeInsets.fromLTRB(12, 26, 12, 19),
            ),
          ),
        ),
        const SizedBox(
          width: 18.0,
        ),
        Expanded(
          child: InputDecorator(
            decoration: InputDecoration(
              labelStyle: Theme.of(context)
                  .primaryTextTheme
                  .caption
                  .copyWith(color: Colors.black),
              border: const OutlineInputBorder(),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                isExpanded: true,
                isDense: true,
                value: _selectedCurrency,
                items: _currency.map((item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(item),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data provided by The Free Currency Converter API',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
