import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/party_list_item.dart';

class PartiesScreen extends StatelessWidget {
  const PartiesScreen({super.key});

  static const _parties = [
    ('Anand Kirana Stores', '+91 99000 11122', '₹12,450', true),
    ('Bharath Hardware', '+91 98801 23344', 'Settled', false),
    ('Citylight Electricals', '+91 90000 55667', '₹8,900', true),
    ('Devi Provision', '+91 96320 77889', '₹3,200', true),
    ('Everest Mart', '+91 99888 22110', '₹21,800', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(),
            _buildSummaryBanner(),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 120),
                physics: const BouncingScrollPhysics(),
                itemCount: _parties.length,
                itemBuilder: (context, i) {
                  final p = _parties[i];
                  return PartyListItem(
                    name: p.$1,
                    phone: p.$2,
                    amount: p.$3,
                    status: p.$4 ? 'due' : '',
                    initial: p.$1[0],
                    color: Colors.primaries[i * 2 % Colors.primaries.length],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
        label: Text(
          'Add Party',
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Parties',
                style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
              ),
              Text(
                '5 customers • ₹46,350 receivable',
                style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.infoLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.search_rounded, color: AppColors.primary, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBanner() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.headerGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL RECEIVABLE',
                style: GoogleFonts.inter(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.w700, letterSpacing: 1),
              ),
              const SizedBox(height: 6),
              Text(
                '₹46,350',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: const Icon(Icons.auto_graph_rounded, color: Colors.white, size: 28),
          ),
        ],
      ),
    );
  }
}
