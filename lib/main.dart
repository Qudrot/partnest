import 'package:flutter/material.dart';
import 'package:partnest/core/theme/app_theme.dart';
import 'package:partnest/features/auth/presentation/pages/onboarding/welcome_role_selection_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Partnex MVP',
      theme: AppTheme.lightTheme,

      debugShowCheckedModeBanner: false,
      home: const WelcomeRoleSelectionPage(),
    );
  }
}
