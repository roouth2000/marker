import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // ── Brand ─────────────────────────────────────────────────────────────────
  static const Color primary      = Color(0xFF3B82F6); // vivid blue
  static const Color primaryDark  = Color(0xFF2563EB);
  static const Color navy         = Color(0xFF0F172A); // header bg
  static const Color darkBlue     = Color(0xFF1E3A8A); // secondary header

  // ── Semantics ─────────────────────────────────────────────────────────────
  static const Color success      = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color error        = Color(0xFFEF4444);
  static const Color errorLight   = Color(0xFFFEE2E2);
  static const Color warning      = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color info         = Color(0xFF3B82F6);
  static const Color infoLight    = Color(0xFFDBEAFE);

  // ── Surfaces ──────────────────────────────────────────────────────────────
  static const Color scaffold     = Color(0xFFF1F5F9);
  static const Color card         = Color(0xFFFFFFFF);
  static const Color surface      = Color(0xFFF8FAFC);
  static const Color surfaceLight = Color(0xFFF1F5F9);

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color textPrimary   = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted     = Color(0xFF94A3B8);
  static const Color textInverse   = Colors.white;

  // ── Borders ───────────────────────────────────────────────────────────────
  static const Color border       = Color(0xFFE2E8F0);
  static const Color borderLight  = Color(0xFFF1F5F9);

  // ── Gradients ─────────────────────────────────────────────────────────────
  static const LinearGradient headerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0F172A), Color(0xFF1E3A8A)],
  );

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [Color(0xFF10B981), Color(0xFF059669)],
  );
}

class AppTextStyles {
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textPrimary,
  );

  static TextStyle get displayMedium => GoogleFonts.inter(
    fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );

  static TextStyle get headingLarge => GoogleFonts.inter(
    fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary,
  );

  static TextStyle get headingMedium => GoogleFonts.inter(
    fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
  );

  static TextStyle get headingSmall => GoogleFonts.inter(
    fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textSecondary,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.textSecondary,
  );

  static TextStyle get labelBold => GoogleFonts.inter(
    fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted,
    letterSpacing: 0.8,
  );

  static TextStyle get caption => GoogleFonts.inter(
    fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.textMuted,
  );
}
