import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/themeMode_notifier.dart';

final themeModeProvider = StateNotifierProvider((ref) => ThemeModeNotifier());
