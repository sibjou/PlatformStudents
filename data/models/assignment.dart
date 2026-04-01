import 'package:hive/hive.dart';

part 'assignment.g.dart';
// НЕЛЬЗЯ менять порядок
@HiveType(typeId: 0)
class Assignment extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String studentId;

  @HiveField(2)
  final int startTaskId;

  @HiveField(3)
  final String hashUsl;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final String status;

  @HiveField(6)
  final String? hashRes;

  Assignment({
    required this.id,
    required this.studentId,
    required this.startTaskId,
    required this.hashUsl,
    required this.createdAt,
    this.status = 'pending', // Значение по умолчанию
    this.hashRes,
  });
// Для Hive (toMap/fromMap)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'studentId': studentId,
      'startTaskId': startTaskId,
      'hashUsl': hashUsl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'status': status,
      'hashRes': hashRes,
    };
  }

  factory Assignment.fromMap(Map<dynamic, dynamic> map) {
    return Assignment(
      id: map['id'],
      studentId: map['studentId'],
      startTaskId: map['startTaskId'],
      hashUsl: map['hashUsl'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      status: map['status'] ?? 'pending',
      hashRes: map['hashRes'],
    );
  }
}