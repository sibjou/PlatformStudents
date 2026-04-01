import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive/hive.dart';

import '../local/boxes.dart';
import '../models/assignment.dart';

/// Сервис миграций. Вызывайте MigrationService.migrate()
/// в main() сразу после инициализации Hive и Preferences.
class MigrationService {
  static const int currentVersion = 3;

  /// Запустить миграции. Повторные вызовы просто пропускают миграции.
  static Future<void> migrate() async {
    final prefs = await SharedPreferences.getInstance();
    final oldVersion = prefs.getInt('db_version') ?? 1;

    if (oldVersion >= currentVersion) {
      return;
    }

    debugPrint('Запуск миграций: $oldVersion → $currentVersion');
    for (int version = oldVersion + 1; version <= currentVersion; version++) {
      await _migrateToVersion(version);
    }
    await prefs.setInt('db_version', currentVersion);
    debugPrint('Миграции завершены. Текущая версия: $currentVersion');
  }

  /// Откат до нужной версии (по желанию). Здесь просто меняем номер версии.
  static Future<void> rollback(int version) async {
    if (version >= currentVersion || version < 1) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('db_version', version);
    debugPrint('База откатана до версии $version');
  }

  /// Логика миграции для каждой версии.
  static Future<void> _migrateToVersion(int version) async {
    final assignmentsBox = Hive.box<Assignment>(AppBoxes.assignments);

    switch (version) {
      case 2:
        // v1 → v2: добавляем поле status со значением 'pending'
        // Создаём новые объекты, так как поля объявлены final.
        for (final old in assignmentsBox.values) {
          final updated = Assignment(
            id: old.id,
            studentId: old.studentId,
            startTaskId: old.startTaskId,
            hashUsl: old.hashUsl,
            createdAt: old.createdAt,
            status: old.status ?? 'pending', // проставляем, если null
            hashRes: old.hashRes,
          );
          await assignmentsBox.put(updated.id, updated);
        }
        break;

      case 3:
        // v2 → v3: добавляем поле hashRes (уже nullable, так что оставляем null).
        for (final old in assignmentsBox.values) {
          final updated = Assignment(
            id: old.id,
            studentId: old.studentId,
            startTaskId: old.startTaskId,
            hashUsl: old.hashUsl,
            createdAt: old.createdAt,
            status: old.status ?? 'pending',
            hashRes: old.hashRes, // null, если раньше не было
          );
          await assignmentsBox.put(updated.id, updated);
        }
        break;
    }
  }
}