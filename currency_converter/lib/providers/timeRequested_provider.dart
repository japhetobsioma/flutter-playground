import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/timeRequested_notifier.dart';

final timeRequestedProvider =
    StateNotifierProvider((ref) => TimeRequestedNotifier());
