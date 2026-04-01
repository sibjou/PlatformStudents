import '../local/preferences_service.dart';

class SettingsRepository {
  static const String _teacherIdKey = 'teacher_id';
  static const String _recentHashesKey = 'recent_hashes';

  Future<void> setTeacherId(int teacherId) async {
    await PreferencesService.setInt(_teacherIdKey, teacherId);
  }

  int? getTeacherId() {
    return PreferencesService.getInt(_teacherIdKey);
  }

  Future<void> setRecentHashes(List<String> hashes) async {
    await PreferencesService.setStringList(_recentHashesKey, hashes);
  }

  List<String> getRecentHashes() {
    return PreferencesService.getStringList(_recentHashesKey) ?? [];
  }
}