import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import '../lib/data/local/boxes.dart';
import '../lib/data/repositories/task_cache_repository.dart';

void main() {
  group('ТЕСТ TASK CACHE (Кэширование API)', () {
    setUp(() async {
      await setUpTestHive();
      await Hive.openBox(AppBoxes.taskCache);
    });

    tearDown(() async => await tearDownTestHive());

    test('Проверка записи в кэш и автоматического удаления по TTL', () async {
      // Кэш живет всего 1 секунду для теста
      final repo = TaskCacheRepository(ttl: Duration(seconds: 1));
      const taskKey = 'api_v1_task_42';
      const jsonResponse = '{"id": 42, "title": "Math Test"}';

      print('\n[ШАГ 1] Кэшируем ответ от API...');
      await repo.cacheTask(taskKey, jsonResponse);
      
      print('[ШАГ 2] Проверяем мгновенное получение из кэша...');
      expect(repo.getCachedTask(taskKey), jsonResponse);
      print('Данные получены из локального хранилища (без запроса в сеть).');

      print('\n[ШАГ 3] Имитируем ожидание (1.1 сек), чтобы кэш устарел...');
      await Future.delayed(Duration(milliseconds: 1100));

      print('[ШАГ 4] Пытаемся получить данные снова...');
      final expiredData = repo.getCachedTask(taskKey);
      expect(expiredData, isNull);
      print('Репозиторий вернул null, так как данные устарели. Требуется обновление из API.');
    });
  });
}