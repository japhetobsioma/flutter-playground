import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/theme_mode_notifier.dart';

final themeModeProvider = StateNotifierProvider((ref) => ThemeModeNotifier());
