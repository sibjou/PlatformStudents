import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/assignment.dart';
import 'boxes.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(AssignmentAdapter());

    try {
      await Hive.openBox<Assignment>(AppBoxes.assignments);
      await Hive.openBox(AppBoxes.settings);
      await Hive.openBox(AppBoxes.taskCache);
    } on Exception catch (e) {
      debugPrint('Ошибка открытия боксов Hive: $e');
      rethrow;
    }
  }

  static Box<T> getBox<T>(String name) {
    return Hive.box<T>(name);
  }

  static Future<void> close() async {
    await Hive.close();
  }
}