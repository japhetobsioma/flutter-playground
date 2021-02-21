import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statenotifier/model/weather_notifier.dart';

import '../model/weather.dart';
import '../model/providers.dart';

class WeatherSearchPage extends StatefulWidget {
  const WeatherSearchPage();

  @override
  _WeatherSearchPageState createState() => _WeatherSearchPageState();
}

class _WeatherSearchPageState extends State<WeatherSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather Search'),
      ),
      body: ProviderListener(
        provider: weatherNotiferProvider.state,
        onChange: (context, state) {
          if (state is WeatherError) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          child: Consumer(
            builder: (context, watch, child) {
              final state = watch(weatherNotiferProvider.state);

              if (state is WeatherInitial) {
                return buildInitialInput();
              } else if (state is WeatherLoading) {
                return buildLoading();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(state.weather);
              } else {
                return buildInitialInput();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return Center(
      child: CityInputField(),
    );
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Weather weather) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          weather.cityName,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          // Display the temperature with 1 decimal place
          '${weather.temperatureCelsius.toStringAsFixed(1)} °C',
          style: TextStyle(fontSize: 80),
        ),
        CityInputField(),
      ],
    );
  }
}

class CityInputField extends StatelessWidget {
  const CityInputField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: TextField(
        onSubmitted: (value) => submitCityName(context, value),
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Enter a city',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          suffixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  void submitCityName(BuildContext context, String cityName) {
    context.read(weatherNotiferProvider).getWeather(cityName);
  }
}
