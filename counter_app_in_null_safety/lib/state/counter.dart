import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/counter.dart';

class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier() : super(initialValue);

  static const initialValue = Counter(count: 0);

  void increment() {
    state = Counter(count: (state.count + 1));
  }
}

final counterProvider =
    StateNotifierProvider<CounterNotifier>((ref) => CounterNotifier());
