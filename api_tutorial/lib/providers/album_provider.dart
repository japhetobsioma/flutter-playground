import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/album_notifier.dart';

final albumProvider = StateNotifierProvider((ref) => AlbumNotifier());
