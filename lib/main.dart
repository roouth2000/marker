import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login/screens/login_screen.dart';

void main() {
  runApp(const TreetPayApp());
}

class TreetPayApp extends StatelessWidget {
  const TreetPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreetPay',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}
