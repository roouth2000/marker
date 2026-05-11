import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/splash/splash_screen.dart';

void main() {
  runApp(const LedgerBookApp());
}

class LedgerBookApp extends StatelessWidget {
  const LedgerBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LedgerBook',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
