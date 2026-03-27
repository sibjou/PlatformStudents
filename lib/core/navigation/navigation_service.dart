import 'package:flutter/material.dart';

class NavigationService {
  // Специальный ключ, чтобы управлять навигацией без контекста (опционально, но круто)
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // 1. Перейти на экран
  static void navigateTo(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // 2. Вернуться назад
  static void navigateBack(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // 3. Перейти и очистить стек (например, при выходе из аккаунта, чтобы нельзя было вернуться назад)
  static void navigateAndClear(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }
}