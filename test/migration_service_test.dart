import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import '../lib/data/local/migration_service.dart';
import '../lib/data/local/boxes.dart';
import '../lib/data/models/assignment.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await setUpTestHive();
    if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(AssignmentAdapter());
    SharedPreferences.setMockInitialValues({});
    await Hive.openBox<Assignment>(AppBoxes.assignments);
  });

  tearDown(() async => await tearDownTestHive());

  test('Миграция v1 → v2 → v3: Проверка добавления полей и сохранности данных', () async {
    final box = Hive.box<Assignment>(AppBoxes.assignments);
    
    print('\n[ТЕСТ МИГРАЦИИ]');
    print('Шаг 1: Создаем "старую" запись (v1) без статуса и хеша результата...');
    final old = Assignment(
      id: 'A1',
      studentId: 'S1',
      startTaskId: 1,
      hashUsl: 'hash_original',
      createdAt: DateTime.now(),
    );
    await box.put(old.id, old);

    print('Шаг 2: Запускаем сервис миграции...');
    await MigrationService.rollback(1); // Эмулируем, что мы на v1
    await MigrationService.migrate();

    final migrated = box.get('A1');

    print('Шаг 3: Проверка версии v2 (поле status)...');
    expect(migrated!.status, 'pending');
    print('  Статус успешно установлен в "pending"');

    print('Шаг 4: Проверка версии v3 (поле hashRes)...');
    expect(migrated.hashRes, isNull);
    print('  Поле hashRes создано (значение null)');
    
    print('Шаг 5: Проверка целостности исходных данных...');
    expect(migrated.hashUsl, 'hash_original');
    print('  Исходные данные (hashUsl) не пострадали при миграции');
  });
}