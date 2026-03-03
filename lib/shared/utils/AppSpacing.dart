import 'package:flutter/material.dart';

class AppSpacing {
  // Основные размеры
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;


  /// Горизонтальные отступы
  static EdgeInsets horizontal(double value) {
    return EdgeInsets.symmetric(horizontal: value);
  }

  /// Вертикальные отступы
  static EdgeInsets vertical(double value) {
    return EdgeInsets.symmetric(vertical: value);
  }

  /// Отступы со всех сторон
  static EdgeInsets all(double value) {
    return EdgeInsets.all(value);
  }

  /// Быстрые заготовки по размерам
  static EdgeInsets get xsAll => EdgeInsets.all(xs);
  static EdgeInsets get smAll => EdgeInsets.all(sm);
  static EdgeInsets get mdAll => EdgeInsets.all(md);
  static EdgeInsets get lgAll => EdgeInsets.all(lg);
  static EdgeInsets get xlAll => EdgeInsets.all(xl);

  static EdgeInsets get xsHorizontal => horizontal(xs);
  static EdgeInsets get smHorizontal => horizontal(sm);
  static EdgeInsets get mdHorizontal => horizontal(md);
  static EdgeInsets get lgHorizontal => horizontal(lg);
  static EdgeInsets get xlHorizontal => horizontal(xl);

  static EdgeInsets get xsVertical => vertical(xs);
  static EdgeInsets get smVertical => vertical(sm);
  static EdgeInsets get mdVertical => vertical(md);
  static EdgeInsets get lgVertical => vertical(lg);
  static EdgeInsets get xlVertical => vertical(xl);
}