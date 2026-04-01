import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../local/boxes.dart';
import '../models/assignment.dart';
import '../repositories/task_cache_repository.dart';

class BackupService {
  /// Создать резервную копию. Возвращает файл с JSON.
  static Future<File> createBackup() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName =
          'backup_${DateTime.now().toIso8601String().replaceAll(':', '-')}.json';
      final file = File('${dir.path}/$fileName');

      // Собираем данные из Hive
      final assignmentsBox = Hive.box<Assignment>(AppBoxes.assignments);
      final assignmentsList =
          assignmentsBox.values.map((e) => e.toMap()).toList();

      // Если есть другие боксы, например taskCache:
      final taskCacheBox = Hive.box(AppBoxes.taskCache);
      final taskCache = taskCacheBox.toMap();

      final data = {
        'assignments': assignmentsList,
        'taskCache': taskCache,
      };

      await file.writeAsString(jsonEncode(data));
      debugPrint('Бэкап создан: ${file.path}');
      return file;
    } catch (e) {
      debugPrint('Ошибка создания бэкапа: $e');
      throw Exception('Не удалось создать резервную копию');
    }
  }

  /// Восстановить данные из JSON‑файла.
  static Future<void> restoreBackup(File file) async {
    try {
      final content = await file.readAsString();
      final data = jsonDecode(content);

      // Восстанавливаем assignments
      final assignmentsBox = Hive.box<Assignment>(AppBoxes.assignments);
      await assignmentsBox.clear();
      for (final item in data['assignments'] as List) {
        final assignment = Assignment.fromMap(Map<String, dynamic>.from(item));
        await assignmentsBox.put(assignment.id, assignment);
      }

      // Восстанавливаем taskCache, если есть
      final taskCacheBox = Hive.box(AppBoxes.taskCache);
      await taskCacheBox.clear();
      final taskCacheData = Map<String, dynamic>.from(data['taskCache']);
      await taskCacheBox.putAll(taskCacheData);

      debugPrint('Бэкап успешно восстановлен');
    } catch (e) {
      debugPrint('Ошибка восстановления бэкапа: $e');
      throw Exception('Не удалось восстановить данные из резервной копии');
    }
  }
}