import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../lib/data/local/preferences_service.dart';
import '../lib/data/repositories/settings_repository.dart';

void main() {
  group('ТЕСТ SETTINGS REPOSITORY', () {
    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      await PreferencesService.init();
    });

    test('Работа с настройками профиля и историей хешей', () async {
      final repo = SettingsRepository();

      print('\n[ШАГ 1] Привязываем приложение к ID учителя...');
      await repo.setTeacherId(555);
      print('>> Teacher ID 555 сохранен.');

      print('\n[ШАГ 2] Сохраняем историю последних использованных хешей...');
      final recentHashes = ['hash_1', 'hash_2', 'hash_3'];
      await repo.setRecentHashes(recentHashes);

      print('\n[ШАГ 3] Проверка считывания...');
      expect(repo.getTeacherId(), 555);
      expect(repo.getRecentHashes().length, 3);
      print('Все настройки корректно извлечены из памяти.');
    });
  });
}