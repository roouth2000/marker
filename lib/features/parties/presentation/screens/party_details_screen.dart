import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../invoices/presentation/screens/invoice_details_screen.dart';

class PartyDetailsScreen extends StatelessWidget {
  final String partyName;
  final String dueAmount;

  const PartyDetailsScreen({
    super.key,
    required this.partyName,
    required this.dueAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: Stack(
        children: [
          // Header bg
          Container(height: 260, decoration: const BoxDecoration(gradient: AppColors.headerGradient)),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      children: [
                        _buildProfileCard(),
                        const SizedBox(height: 20),
                        _buildMetrics(),
                        const SizedBox(height: 20),
                        _buildActions(),
                        const SizedBox(height: 24),
                        _buildLedger(context),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 20),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              partyName,
              style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.picture_as_pdf_outlined, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: Text(
                  partyName[0],
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(partyName, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    Text('GSTIN: 29AAAPL1234C1Z5', style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 12),
          _infoRow(Icons.phone_outlined, '+91 99000 11122', Icons.email_outlined, 'anand@kirana.in'),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: AppColors.textMuted),
              const SizedBox(width: 6),
              Text('5/2 Jayanagar, Bengaluru', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(IconData i1, String t1, IconData i2, String t2) {
    return Row(
      children: [
        Icon(i1, size: 14, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(t1, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
        const SizedBox(width: 20),
        Icon(i2, size: 14, color: AppColors.textMuted),
        const SizedBox(width: 6),
        Text(t2, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
      ],
    );
  }

  Widget _buildMetrics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(child: _metricCard('OUTSTANDING', dueAmount, AppColors.error, AppColors.errorLight)),
          const SizedBox(width: 12),
          Expanded(child: _metricCard('TOTAL BILLED', dueAmount, AppColors.textPrimary, AppColors.surfaceLight)),
          const SizedBox(width: 12),
          Expanded(child: _metricCard('RECEIVED', '₹8,000', AppColors.success, AppColors.successLight)),
        ],
      ),
    );
  }

  Widget _metricCard(String label, String value, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label, style: GoogleFonts.inter(fontSize: 9, color: AppColors.textMuted, fontWeight: FontWeight.w700, letterSpacing: 0.5)),
          const SizedBox(height: 6),
          Text(value, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: color)),
        ],
      ),
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _primaryBtn(Icons.add_rounded, 'New Invoice'),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _outlinedBtn(Icons.receipt_outlined, 'Record Receipt'),
          ),
        ],
      ),
    );
  }

  Widget _primaryBtn(IconData icon, String label) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: Colors.white, size: 18),
        label: Text(label, style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 13)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget _outlinedBtn(IconData icon, String label) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, size: 18, color: AppColors.textPrimary),
        label: Text(label, style: GoogleFonts.inter(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 13)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
      ),
    );
  }

  Widget _buildLedger(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long_rounded, size: 18, color: AppColors.textPrimary),
              const SizedBox(width: 8),
              Text('Ledger', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Column(
              children: [
                _ledgerRow(context, 'Sales • INV-1042', '11 May 2026', '-$dueAmount', AppColors.error),
                const Divider(height: 1, indent: 16, endIndent: 16),
                _ledgerRow(context, 'Receipt • RC-219', '06 May 2026', '+₹8,000', AppColors.success),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ledgerRow(BuildContext context, String title, String date, String amount, Color color) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        final id = title.split('•').last.trim();
        Navigator.push(context, MaterialPageRoute(builder: (_) => InvoiceDetailsScreen(invoiceId: id)));
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                Text(date, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textMuted)),
              ],
            ),
            Row(
              children: [
                Text(amount, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: color)),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.picture_as_pdf_outlined, size: 15, color: AppColors.textMuted),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
