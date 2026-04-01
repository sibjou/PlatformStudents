import 'package:shared_preferences/shared_preferences.dart';

/// Сервис для работы с SharedPreferences.
class PreferencesService {
  static SharedPreferences? _prefs;

  /// Инициализация SharedPreferences. Вызывайте в main().
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get _instance {
    final prefs = _prefs;
    if (prefs == null) {
      throw StateError('PreferencesService не инициализирован');
    }
    return prefs;
  }

  // ----------- методы для строк -----------
  static Future<void> setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static String? getString(String key) {
    return _instance.getString(key);
  }

  // методы для целых 
  static Future<void> setInt(String key, int value) async {
    await _instance.setInt(key, value);
  }

  static int? getInt(String key) {
    return _instance.getInt(key);
  }

  /// Сохранение teacher_id
  static Future<void> setTeacherId(int value) => setInt('teacher_id', value);

  static int? getTeacherId() => getInt('teacher_id');

  /// Сохранение списка последних введённых хешей (hashUsl/hashRes)
  static Future<void> setRecentHashes(List<String> values) async {
    await _instance.setStringList('recent_hashes', values);
  }

  static List<String>? getRecentHashes() {
    return _instance.getStringList('recent_hashes');
  }
  static Future<void> setStringList(String key, List<String> values) async {
    await _instance.setStringList(key, values);
  }

  static List<String>? getStringList(String key) {
    return _instance.getStringList(key);
  }
}