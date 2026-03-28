import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:platform_students/shared/widgets/AppButton.dart';
import 'package:platform_students/shared/widgets/AppTextField.dart';
import 'package:platform_students/shared/theme/AppTheme.dart';

void main() {
  // Обёртка чтобы виджеты видели тему
  Widget buildTestApp(Widget child) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: Scaffold(body: child),
    );
  }

  group('AppButton Widget Tests', () {
    testWidgets('Отображает текст кнопки', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        AppButton(text: 'Тест', onPressed: () {}),
      ));
      expect(find.text('Тест'), findsOneWidget);
    });

    testWidgets('Вызывает onPressed при нажатии', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(buildTestApp(
        AppButton(text: 'Нажми', onPressed: () => pressed = true),
      ));
      await tester.tap(find.byType(AppButton));
      expect(pressed, isTrue);
    });

    testWidgets('Отображает иконку если передана', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        AppButton(text: 'С иконкой', icon: Icons.check, onPressed: () {}),
      ));
      expect(find.byIcon(Icons.check), findsOneWidget);
    });

    testWidgets('Кнопка неактивна когда onPressed = null',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        const AppButton(text: 'Неактивна', onPressed: null),
      ));
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('Secondary кнопка отображается', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        AppButton(text: 'Secondary', isSecondary: true, onPressed: () {}),
      ));
      expect(find.text('Secondary'), findsOneWidget);
    });
  });

  group('AppTextField Widget Tests', () {
    testWidgets('Отображает label', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        const AppTextField(label: 'Email'),
      ));
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('Отображает hint текст', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        const AppTextField(label: 'Email', hint: 'example@mail.com'),
      ));
      expect(find.text('example@mail.com'), findsOneWidget);
    });

    testWidgets('Отображает иконку если передана', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        const AppTextField(label: 'Email', icon: Icons.email),
      ));
      expect(find.byIcon(Icons.email), findsOneWidget);
    });

    testWidgets('Принимает ввод текста', (WidgetTester tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(buildTestApp(
        AppTextField(label: 'Поле', controller: controller),
      ));
      await tester.enterText(find.byType(TextField), 'привет');
      expect(controller.text, 'привет');
    });

    testWidgets('obscureText скрывает пароль', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp(
        const AppTextField(label: 'Пароль', obscureText: true),
      ));
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.obscureText, isTrue);
    });
  });
}
