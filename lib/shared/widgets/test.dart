import 'package:flutter/material.dart';
import '../utils/AppSpacing.dart';
import 'AppButton.dart';
import 'AppTextField.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Kit Test'),
      ),
      body: Padding(
        padding: AppSpacing.mdAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppTextField(
              label: 'Email',
              hint: 'example@mail.com',
              icon: Icons.email,
            ),
            const AppTextField(
              label: 'Password',
              icon: Icons.lock,
              obscureText: true,
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              text: 'Primary Button',
              icon: Icons.check,
              onPressed: () {},
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              text: 'Secondary Button',
              icon: Icons.arrow_forward,
              isSecondary: true,
              onPressed: () {},
            ),
          
          const SizedBox(height: AppSpacing.md),

Text(
  'Акцентный текст (error / red)',
  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: Theme.of(context).colorScheme.error,
        fontWeight: FontWeight.w600,
      ),
),],
        
        ),
      ),
    );
  }
}