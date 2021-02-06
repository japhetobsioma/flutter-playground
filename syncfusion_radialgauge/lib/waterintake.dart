import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaterIntakeNotifier extends StateNotifier<WaterIntakeModel> {
  WaterIntakeNotifier() : super(_initialValue);

  static const _initialValue = WaterIntakeModel(0);

  void increment() {
    state = WaterIntakeModel(state.intakeValue + 10);
  }

  void reset() {
    state = WaterIntakeModel(0);
  }
}

class WaterIntakeModel {
  const WaterIntakeModel(this.intakeValue);
  final int intakeValue;
}
