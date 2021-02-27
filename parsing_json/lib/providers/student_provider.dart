import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/student_notifier.dart';

final studentProvider = StateNotifierProvider((ref) => StudentNotifier());
