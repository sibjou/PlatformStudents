import 'package:hive/hive.dart';

import '../models/assignment.dart';

class AssignmentRepository {
  final Box<Assignment> _box;

  // индекс в памяти (ускоряет поиск)
  final Map<String, List<Assignment>> _studentIndex = {};

  AssignmentRepository(this._box) {
    _buildIndex();
  }

  ///  строим индекс при старте
  void _buildIndex() {
    for (final assignment in _box.values) {
      _studentIndex.putIfAbsent(assignment.studentId, () => []);
      _studentIndex[assignment.studentId]!.add(assignment);
    }
  }

  Future<void> create(Assignment assignment) async {
    await _box.put(assignment.id, assignment);

    // обновляем индекс
    _studentIndex.putIfAbsent(assignment.studentId, () => []);
    _studentIndex[assignment.studentId]!.add(assignment);
  }

  Assignment? getById(String id) {
    return _box.get(id);
  }

  List<Assignment> getAll() {
    return _box.values.toList();
  }

  /// быстрый поиск через индекс
  List<Assignment> getByStudentId(String studentId) {
    return _studentIndex[studentId] ?? [];
  }

  Future<void> update(Assignment assignment) async {
    await _box.put(assignment.id, assignment);

    // обновляем индекс (просто пересобираем)
    _studentIndex.clear();
    _buildIndex();
  }

  Future<void> delete(String id) async {
    final assignment = _box.get(id);

    await _box.delete(id);

    if (assignment != null) {
      _studentIndex[assignment.studentId]?.removeWhere(
        (a) => a.id == id,
      );
    }
  }
}