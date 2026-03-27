import 'package:flutter/material.dart';
import 'core/navigation/navigation_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Architect App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/teacher': (context) => Scaffold(appBar: AppBar(title: Text('Teacher Page'))),
        '/student': (context) => Scaffold(appBar: AppBar(title: Text('Student Page'))),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => NavigationService.navigateTo(context, '/teacher'),
              child: const Text('Go to Teacher'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => NavigationService.navigateTo(context, '/student'),
              child: const Text('Go to Student'),
            ),
          ],
        ),
      ),
    );
  }
}