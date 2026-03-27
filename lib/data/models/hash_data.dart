// Данные для кодирования условий
class HashUslData {
  final String teacherId;
  final String studentId;
  final int startTaskId;
  final int seed;
  final int timestamp;

  HashUslData({
    required this.teacherId,
    required this.studentId,
    required this.startTaskId,
    required this.seed,
    required this.timestamp,
  });
}

// Результат одной задачи
class TaskResult {
  final int taskId;
  final dynamic answer;
  final bool isCorrect;

  TaskResult({required this.taskId, required this.answer, required this.isCorrect});
}

// Итоговый хэш результата
class HashResData {
  final String hashUsl;
  final List<TaskResult> chain;

  HashResData({required this.hashUsl, required this.chain});
}