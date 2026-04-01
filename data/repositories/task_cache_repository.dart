import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../local/hive_service.dart';
import '../local/boxes.dart';

/// Репозиторий для кэширования JSON-ответов от Task API.
class TaskCacheRepository {
  final Box _box;
  final Duration ttl;

  TaskCacheRepository({this.ttl = const Duration(hours: 2)})
      : _box = Hive.box(AppBoxes.taskCache); // объявите константу в boxes.dart

  Future<void> cacheTask(String key, String json) async {
    try {
      await _box.put(key, {
        'data': json,
        'ts': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Ошибка кэширования Task API: $e');
      throw Exception('Не удалось записать кэш');
    }
  }

  String? getCachedTask(String key) {
    try {
      final entry = _box.get(key);
      if (entry == null) return null;
      final ts = DateTime.parse(entry['ts']);
      if (DateTime.now().difference(ts) > ttl) {
        _box.delete(key); // устарел
        return null;
      }
      return entry['data'];
    } catch (e) {
      debugPrint('Ошибка чтения Task API кэша: $e');
      return null;
    }
  }

  Future<void> clearCache() async {
    await _box.clear();
  }
}