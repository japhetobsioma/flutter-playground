import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/convert_notifier.dart';

final convertProvider = StateNotifierProvider((ref) => ConvertNotifier(ref));
