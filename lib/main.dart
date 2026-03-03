import 'package:flutter/material.dart';
import 'shared/theme/AppTheme.dart';
import 'shared/utils/AppSpacing.dart';
import 'shared/widgets/test.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      // home: const Scaffold(),
      home: const TestScreen(),
    );
  }
}
