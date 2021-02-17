import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moor_app/database/app_db.dart';

class AppDatabaseNotifier extends StateNotifier<AppDatabase> {
  AppDatabaseNotifier() : super(_initialValue);

  static final _initialValue = AppDatabase();
}
