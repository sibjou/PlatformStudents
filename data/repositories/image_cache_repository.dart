import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class ImageCacheRepository {
  final Duration ttl; // время жизни файла
  final int maxCacheSizeBytes; // максимальный размер кэша

  ImageCacheRepository({
    this.ttl = const Duration(days: 7),
    this.maxCacheSizeBytes = 50 * 1024 * 1024, // 50 MB
  });

  /// Получаем папку кэша
  Future<Directory> _getCacheDir() async {
    final dir = await getApplicationDocumentsDirectory();
    final cacheDir = Directory('${dir.path}/image_cache');

    if (!await cacheDir.exists()) {
      await cacheDir.create(recursive: true);
    }

    return cacheDir;
  }
///«Хеширование используется в ImageCacheRepository.
///алгоритм MD5, превращает длинные и 
///сложные URL-адреса картинок в короткие уникальные имена файлов. 
///Это позволяет избежать проблем с запрещенными символами в названиях файлов и гарантирует, 
///что одной ссылке всегда соответствует один и тот же файл в кэше».

  /// Хэшируем URL в имя файла
  String _hashUrl(String url) {
    final bytes = utf8.encode(url);
    final digest = md5.convert(bytes);/////////////
    return digest.toString();
  }

  /// Сохранение изображения
  Future<File> saveImage(String url, Uint8List bytes) async {
    try {
      final dir = await _getCacheDir();
      final fileName = _hashUrl(url);
      final file = File('${dir.path}/$fileName');

      await file.writeAsBytes(bytes);

      // ВАЖНО: после сохранения проверяем размер кэша
      await _enforceCacheLimit();

      return file;
    } catch (e) {
      debugPrint('Ошибка сохранения изображения: $e');
      rethrow;
    }
  }

  /// Получение изображения
  Future<File?> getImage(String url) async {
    try {
      final dir = await _getCacheDir();
      final fileName = _hashUrl(url);
      final file = File('${dir.path}/$fileName');

      if (await file.exists()) {
        final stat = await file.stat();

        // проверка TTL
        final isExpired =
            DateTime.now().difference(stat.modified) > ttl;

        if (isExpired) {
          await file.delete();
          return null;
        }

        return file;
      }

      return null;
    } catch (e) {
      debugPrint('Ошибка чтения изображения: $e');
      return null;
    }
  }

  ///НОВОЕ: ограничение размера кэша
  Future<void> _enforceCacheLimit() async {
    final dir = await _getCacheDir();
    final entities = await dir.list().toList();
    final files = entities.where((e) => e is File).cast<File>().toList();

    int totalSize = 0;
    final fileStats = <File, FileStat>{};

    for (final file in files) {
      final stat = await file.stat();
      totalSize += stat.size.toInt();
      fileStats[file] = stat;
    }

    // если размер норм → ничего не делаем
    if (totalSize <= maxCacheSizeBytes) return;

    // сортируем файлы (старые → первые)
    final sorted = fileStats.entries.toList()
      ..sort((a, b) => a.value.modified.compareTo(b.value.modified));

    // удаляем старые пока не станет норм
    for (final entry in sorted) {
      await entry.key.delete();
      totalSize -= entry.value.size;

      if (totalSize <= maxCacheSizeBytes) break;
    }
  }

  /// Очистка всего кэша
  Future<void> clearCache() async {
    try {
      final dir = await _getCacheDir();
      if (await dir.exists()) {
        await dir.delete(recursive: true);
      }
    } catch (e) {
      debugPrint('Ошибка очистки кэша: $e');
      rethrow;
    }
  }
}