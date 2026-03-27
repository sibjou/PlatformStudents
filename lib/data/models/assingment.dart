class Assignment {
  final String id;
  final String studentId;
  final int startTaskId;
  final String hashUsl;
  final DateTime createdAt;
  final String status;
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