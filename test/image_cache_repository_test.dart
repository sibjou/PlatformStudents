import 'dart:typed_data';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart';
import '../lib/data/repositories/image_cache_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // Этот блок критически важен для работы path_provider в тестах
  const MethodChannel channel = MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return '.'; // Эмулируем путь к папке
  });

test('Оптимизация кэша: удаление старых файлов при переполнении', () async {
    print('\n[ТЕСТ КЭША]');
    // Ставим лимит 100 байт для наглядности
    final repo = ImageCacheRepository(maxCacheSizeBytes: 100);
    
    print('Шаг 1: Сохраняем две картинки по 60 байт (итого 120, что > лимита 100)');
    await repo.saveImage('url_1', Uint8List(60));
    // Небольшая задержка, чтобы у файлов было разное время модификации
    await Future.delayed(Duration(milliseconds: 100));
    await repo.saveImage('url_2', Uint8List(60));

    print('Шаг 2: Проверяем, что кэш удалил самую старую картинку...');
    final img1 = await repo.getImage('url_1');
    final img2 = await repo.getImage('url_2');

    expect(img1, isNull); 
    expect(img2, isNotNull);
    print(' Старый файл (url_1) удален');
    print(' Новый файл (url_2) сохранен');
  });
}