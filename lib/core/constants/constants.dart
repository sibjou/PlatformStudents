class AppConstants {
  // API
  static const String baseUrl = 'https://api.example.com/v1';
  static const String tasksEndpoint = '/tasks';

  // Hive Boxes (названия таблиц в БД)
  static const String taskBox = 'task_box';
  static const String assignmentBox = 'assignment_box';

  // SharedPreferences Keys
  static const String keyAuthToken = 'auth_token';
  static const String keyIsFirstRun = 'is_first_run';

  // Validation
  static const int minTaskId = 1;
  static const int maxTaskId = 9999;
  static const int minHashLength = 8;
  // Teacher Student
  static const String routeTeacher = '/teacher';
  static const String routeStudent = '/student';
}