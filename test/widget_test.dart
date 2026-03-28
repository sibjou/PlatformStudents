import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget wrap(Widget child) {
    return MaterialApp(home: Scaffold(body: child));
  }

  group('Button tests', () {
    testWidgets('Кнопка отображает текст', (tester) async {
      await tester.pumpWidget(wrap(
        ElevatedButton(onPressed: () {}, child: const Text('Тест')),
      ));
      expect(find.text('Тест'), findsOneWidget);
    });

    testWidgets('Кнопка реагирует на нажатие', (tester) async {
      bool pressed = false;
      await tester.pumpWidget(wrap(
        ElevatedButton(onPressed: () => pressed = true, child: const Text('OK')),
      ));
      await tester.tap(find.byType(ElevatedButton));
      expect(pressed, isTrue);
    });

    testWidgets('Неактивная кнопка не вызывает callback', (tester) async {
      await tester.pumpWidget(wrap(
        const ElevatedButton(onPressed: null, child: Text('Disabled')),
      ));
      final btn = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(btn.onPressed, isNull);
    });
  });

  group('TextField tests', () {
    testWidgets('Поле отображает label', (tester) async {
      await tester.pumpWidget(wrap(
        const TextField(decoration: InputDecoration(labelText: 'Email')),
      ));
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('Поле принимает ввод', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(wrap(TextField(controller: controller)));
      await tester.enterText(find.byType(TextField), 'test@mail.com');
      expect(controller.text, 'test@mail.com');
    });

    testWidgets('obscureText скрывает пароль', (tester) async {
      await tester.pumpWidget(wrap(
        const TextField(obscureText: true),
      ));
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.obscureText, isTrue);
    });
  });
}
