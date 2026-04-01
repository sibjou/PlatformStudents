import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_test/hive_test.dart';
import '../lib/data/repositories/assignment_repository.dart';
import '../lib/data/local/boxes.dart';
import '../lib/data/models/assignment.dart';

void main() {
  group('ТЕСТ ASSIGNMENT REPOSITORY (СУБД HIVE)', () {
    setUp(() async {
      await setUpTestHive();
      if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(AssignmentAdapter());
      await Hive.openBox<Assignment>(AppBoxes.assignments);
    });

    tearDown(() async => await tearDownTestHive());

    test('Полный цикл CRUD и работа быстрого поиска по индексу', () async {
      final box = Hive.box<Assignment>(AppBoxes.assignments);
      final repository = AssignmentRepository(box);

      print('\n[ШАГ 1] Создание нового назначения (Assignment)...');
      final assignment = Assignment(
        id: 'A100',
        studentId: 'STUD-77',
        startTaskId: 101,
        hashUsl: 'hash_v1',
        createdAt: DateTime.now(),
      );
      await repository.create(assignment);
      print('>> Запись A100 сохранена в Hive.');

      print('\n[ШАГ 2] Проверка быстрого поиска (Memory Index)...');
      // Этот метод должен использовать Map в репозитории, а не перебор всей базы
      final byStudent = repository.getByStudentId('STUD-77');
      expect(byStudent.length, 1);
      print('Индекс сработал. Найдено заданий для студента: ${byStudent.length}');

      print('\n[ШАГ 3] Обновление статуса задания...');
      final updated = Assignment(
        id: 'A100',
        studentId: 'STUD-77',
        startTaskId: 101,
        hashUsl: 'hash_v1',
        createdAt: assignment.createdAt,
        status: 'completed',
      );
      await repository.update(updated);
      
      final fetched = repository.getById('A100');
      expect(fetched!.status, 'completed');
      print('Статус в БД изменен на "completed".');
    });
  });
}