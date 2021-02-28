import 'package:hooks_riverpod/hooks_riverpod.dart';

class TimeRequestedNotifier extends StateNotifier<TimeRequested> {
  TimeRequestedNotifier() : super(initialValue);

  static final initialValue = TimeRequested(timeRequestedText: '');

  void setTimeRequestText(String timeRequestedText) {
    state = TimeRequested(timeRequestedText: timeRequestedText);
  }
}

class TimeRequested {
  const TimeRequested({this.timeRequestedText});
  final String timeRequestedText;
}
