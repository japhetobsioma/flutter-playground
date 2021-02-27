import 'package:flutter/services.dart' show rootBundle;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'student.dart';

class StudentNotifier extends StateNotifier<AsyncValue<Student>> {
  StudentNotifier() : super(const AsyncValue.loading()) {
    loadStudent();
  }

  Future<String> loadStudentAsset() async {
    return await rootBundle.loadString('assets/student.json');
  }

  Future<void> loadStudent() async {
    var jsonString = await loadStudentAsset();
    final jsonResponse = studentFromJson(jsonString);
    state = AsyncValue.data(Student.fromJson(jsonResponse.toJson()));
  }
}
