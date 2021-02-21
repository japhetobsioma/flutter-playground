import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_statenotifier/model/weather_notifier.dart';

import 'weather_repository.dart';

final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => FakeWeatherRepository(),
);

final weatherNotiferProvider = StateNotifierProvider(
  (ref) => WeatherNotifier(ref.watch(weatherRepositoryProvider)),
);
