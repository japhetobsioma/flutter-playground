import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../providers/clipboardCurrency_provider.dart';
import '../providers/insertedCurrency_provider.dart';
import '../providers/timeRequested_provider.dart';
import '../providers/selectedCurrency_provider.dart';
import '../providers/convert_provider.dart';
import 'changeTheme_screen.dart';
import 'currency_screen.dart';

class HomeScreen extends HookWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    final clipboardCurrencyModel = useProvider(clipboardCurrencyProvider.state);
    final selectedCurrencyModel = useProvider(selectedCurrencyProvider.state);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Currency Converter'),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'About this':
                    showAboutDialog(
                      context: context,
                      applicationName: 'Currency Converter',
                      applicationVersion: '0.2.0',
                      applicationIcon: Icon(
                        Icons.request_quote,
                        size: 65.0,
                        color: Theme.of(context).accentColor,
                      ),
                      applicationLegalese: '© 2021',
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Yet another currency converter. '
                          'For my mobile application assignment.'
                          '\n\nAuthor\nJaphet Mert Catilo Obsioma',
                        ),
                        const Text('\nGithub'),
                        InkWell(
                          onTap: () async {
                            const url = 'https://github.com/japhetobsioma';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'github.com/japhetobsioma',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        const Text('\nData provided by'),
                        InkWell(
                          onTap: () async {
                            const url = 'https://www.currencyconverterapi.com/';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              throw 'Could not launch $url';
                            }
                          },
                          child: Text(
                            'Currency Converter API',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    );
                    break;
                  case 'Change theme':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangeThemeScreen(),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return {'About this', 'Change theme'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              const CurrencyInfoSection(),
              // const GraphHistorySection(),
              const InputCurrencySection(),
              const FooterSection(),
            ],
          ),
        ),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return SpeedDial(
              icon: Icons.content_copy,
              activeIcon: Icons.close,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              visible: true,
              curve: Curves.bounceIn,
              children: [
                clipboardCurrencyModel.conversionStatus == 'ToFrom'
                    ? SpeedDialChild(
                        child: Icon(Icons.content_copy),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        onTap: () {
                          final clipboardText = context
                              .read(clipboardCurrencyProvider)
                              .getClipboardToFrom();
                          Clipboard.setData(
                            ClipboardData(text: clipboardText),
                          );
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied to clipboard'),
                            ),
                          );
                        },
                        label: '${selectedCurrencyModel.to_currencyName}'
                            ' to ${selectedCurrencyModel.from_currencyName}',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 16.0),
                        labelBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      )
                    : SpeedDialChild(
                        child: Icon(Icons.content_copy),
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onSecondary,
                        onTap: () {
                          final clipboardText = context
                              .read(clipboardCurrencyProvider)
                              .getClipboardFromTo();
                          Clipboard.setData(
                            ClipboardData(text: clipboardText),
                          );
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Copied to clipboard'),
                            ),
                          );
                        },
                        label: '${selectedCurrencyModel.from_currencyName}'
                            ' to ${selectedCurrencyModel.to_currencyName}',
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 16.0),
                        labelBackgroundColor:
                            Theme.of(context).colorScheme.secondary,
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CurrencyInfoSection extends HookWidget {
  const CurrencyInfoSection();

  @override
  Widget build(BuildContext context) {
    final convertModel = useProvider(convertProvider.state);
    final selectedCurrencyModel = useProvider(selectedCurrencyProvider.state);
    final timeRequestedModel = useProvider(timeRequestedProvider.state);

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: convertModel.when(
            data: (value) => [
              Text('1 ${selectedCurrencyModel.from_currencyName} equals',
                  style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(
                height: 4.0,
              ),
              Text(
                '${value.from_to} ${selectedCurrencyModel.to_currencyName}',
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontSize: 36.0,
                    ),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Text(timeRequestedModel.timeRequestedText,
                  style: Theme.of(context).textTheme.caption)
            ],
            loading: () => [
              const CircularProgressIndicator(),
            ],
            error: (error, _) => [
              Text(
                'Error: Please check your internet connection or you'
                ' already exceed the limit of 100 API request per hour',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* class GraphHistorySection extends StatelessWidget {
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
} */

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

class BuildFromCurrency extends HookWidget {
  const BuildFromCurrency();

  @override
  Widget build(BuildContext context) {
    final selectedCurrencyModel = useProvider(selectedCurrencyProvider.state);
    final insertedCurrencyModel = useProvider(insertedCurrencyProvider.state);
    const previousDestination = 'FromCurrency';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: insertedCurrencyModel.fromInput_controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (value) async {
                if (value.isNotEmpty && value != '0') {
                  final convertedValue =
                      await context.read(convertProvider).getConvert(
                            selectedCurrencyModel.from_currencyId,
                            selectedCurrencyModel.to_currencyId,
                            double.parse(value),
                          );
                  context
                      .read(insertedCurrencyProvider)
                      .setToInputController(convertedValue.toString());
                  context
                      .read(clipboardCurrencyProvider)
                      .setConversionStatus('FromTo');
                } else {
                  context
                      .read(insertedCurrencyProvider)
                      .setToInputController(value);
                }
                FocusScope.of(context).unfocus();
              },
              onTap: () {
                insertedCurrencyModel.fromInput_controller.selection =
                    TextSelection(
                        baseOffset: 0,
                        extentOffset: insertedCurrencyModel
                            .fromInput_controller.value.text.length);
              },
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          const SizedBox(
            width: 18.0,
          ),
          Expanded(
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CurrencyScreen(),
                    settings: RouteSettings(
                      arguments: previousDestination,
                    ),
                  ),
                );
              },
              child: IgnorePointer(
                child: TextField(
                  controller: selectedCurrencyModel.from_controller,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildToCurrency extends HookWidget {
  const BuildToCurrency();

  @override
  Widget build(BuildContext context) {
    final selectedCurrencyModel = useProvider(selectedCurrencyProvider.state);
    final insertedCurrencyModel = useProvider(insertedCurrencyProvider.state);
    const previousDestination = 'ToCurrency';

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: insertedCurrencyModel.toInput_controller,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
            onSubmitted: (value) async {
              if (value.isNotEmpty && value != '0') {
                final convertedValue =
                    await context.read(convertProvider).getConvert(
                          selectedCurrencyModel.to_currencyId,
                          selectedCurrencyModel.from_currencyId,
                          double.parse(value),
                        );
                context
                    .read(insertedCurrencyProvider)
                    .setFromInputController(convertedValue.toString());
                context
                    .read(clipboardCurrencyProvider)
                    .setConversionStatus('ToFrom');
              } else {
                context
                    .read(insertedCurrencyProvider)
                    .setFromInputController(value);
              }
              FocusScope.of(context).unfocus();
            },
            onTap: () {
              insertedCurrencyModel.toInput_controller.selection =
                  TextSelection(
                      baseOffset: 0,
                      extentOffset: insertedCurrencyModel
                          .toInput_controller.value.text.length);
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ),
        const SizedBox(
          width: 18.0,
        ),
        Expanded(
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CurrencyScreen(),
                  settings: RouteSettings(
                    arguments: previousDestination,
                  ),
                ),
              );
            },
            child: IgnorePointer(
              child: TextField(
                controller: selectedCurrencyModel.to_controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                ),
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
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data provided by the Currency Converter API',
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
