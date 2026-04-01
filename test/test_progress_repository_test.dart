import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/data/local/preferences_service.dart';
import '../lib/data/repositories/test_progress_repository.dart';

void main() {
  group('ТЕСТ ПРОГРЕССА ТЕСТИРОВАНИЯ', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      await PreferencesService.init();
    });

    test('Сохранение и восстановление ответов студента', () async {
      final repo = TestProgressRepository();
      final currentAnswers = ['A', 'B', 'C', 'D'];

      print('\n[ШАГ 1] Студент ответил на 4 вопроса. Сохраняем прогресс...');
      await repo.saveProgress(currentAnswers);
      print('>> Данные записаны в SharedPreferences.');

      print('\n[ШАГ 2] Имитируем перезапуск приложения (читаем данные)...');
      final restored = repo.getProgress();
      expect(restored, equals(currentAnswers));
      print('Список ответов совпадает: $restored');

      print('\n[ШАГ 3] Очистка прогресса после завершения теста...');
      await repo.clearProgress();
      final empty = repo.getProgress();
      expect(empty, isEmpty);
      print('Хранилище очищено.');
    });
  });
}