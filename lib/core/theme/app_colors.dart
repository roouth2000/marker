import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors
  static const Color primaryBlue = Color(0xFF3498DB);
  static const Color darkBlue = Color(0xFF1E272E);
  
  // Gradients
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF0F172A), // Very dark blue
      Color(0xFF1E3A8A), // Dark blue
    ],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF4FA8D1),
      Color(0xFF3498DB),
    ],
  );

  // Backgrounds
  static const Color scaffoldBackground = Color(0xFFF8FAFC);
  static const Color cardBackground = Colors.white;

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textLink = Color(0xFF3B82F6);

  // Border Colors
  static const Color borderLight = Color(0xFFE2E8F0);
}
