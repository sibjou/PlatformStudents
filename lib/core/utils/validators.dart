import '../constants/constants.dart';

class Validators {
  // Проверка ID задачи (от 1 до 10000)
  static String? validateTaskId(int id) {
    if (id < AppConstants.minTaskId || id > 10000) {
      return "ID задачи должен быть в диапазоне от 1 до 10000";
    }
    return null; // Ошибок нет
  }

  // Проверка ID студента (например, не пустой и минимум 3 символа)
  static String? validateStudentId(String id) {
    if (id.isEmpty || id.length < 3) {
      return "Некорректный ID студента";
    }
    return null;
  }

  // Проверка формата хэша
  static String? validateHashUsl(String hash) {
    if (hash.length < AppConstants.minHashLength) {
      return "Хэш слишком короткий";
    }
    // Регулярное выражение: только латиница и цифры
    final regex = RegExp(r'^[a-zA-Z0-9_-]+$');
    if (!regex.hasMatch(hash)) {
      return "Хэш содержит недопустимые символы";
    }
    return null;
  }
}