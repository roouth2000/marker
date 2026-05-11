import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Force white status bar icons on dark header
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final h = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: h * 0.42,
      decoration: const BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(48),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(32, 60, 32, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo badge
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: const Icon(Icons.account_balance_wallet_rounded, color: Colors.white, size: 30),
          ),
          const Spacer(),
          Text(
            'LedgerBook',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Welcome back 👋',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sign in to manage your billing & accounts',
            style: GoogleFonts.inter(
              color: Colors.white.withOpacity(0.65),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
