import 'package:flutter/foundation.dart';

import '../local/preferences_service.dart';

/// Репозиторий для сохранения и восстановления прогресса теста.
/// Прогресс хранится в SharedPreferences как список строк.
class TestProgressRepository {
  static const String _progressKey = 'test_progress';

  /// Сохранить текущий прогресс (список ответов в формате String).
  Future<void> saveProgress(List<String> answers) async {
    try {
      await PreferencesService.setStringList(_progressKey, answers);
    } catch (e) {
      // логирование ошибки, чтобы можно было найти её в консоли
      debugPrint('Ошибка записи прогресса: $e');
      // прокидываем понятное исключение в вызывающий код
      throw Exception('Не удалось сохранить прогресс теста');
    }
  }

  /// Вернуть сохранённый прогресс или null, если ничего нет.
  List<String>? getProgress() {
    try {
      return PreferencesService.getStringList(_progressKey);
    } catch (e) {
      debugPrint('Ошибка чтения прогресса: $e');
      return null;
    }
  }

  /// Очистить сохранённый прогресс (например, после завершения теста).
  Future<void> clearProgress() async {
    try {
      // SharedPreferences не умеет удалять списки через наш сервис, поэтому просто
      // перезаписываем пустым списком. Можно добавить метод remove() в PreferencesService,
      // если понадобится удалять ключ полностью.
      await PreferencesService.setStringList(_progressKey, <String>[]);
    } catch (e) {
      debugPrint('Ошибка очистки прогресса: $e');
      throw Exception('Не удалось очистить прогресс теста');
    }
  }
}