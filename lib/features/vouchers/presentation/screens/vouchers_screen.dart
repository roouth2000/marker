import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../dashboard/bloc/dashboard_bloc.dart';
import '../../../dashboard/bloc/dashboard_event.dart';
import '../../../dashboard/bloc/dashboard_state.dart';
import '../widgets/voucher_list_item.dart';

class VouchersScreen extends StatelessWidget {
  const VouchersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.scaffold,
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, state),
                const SizedBox(height: 16),
                _buildFilterChips(context, state),
                const SizedBox(height: 10),
                Expanded(child: _buildVoucherList(state.vouchersFilter)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, DashboardState state) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vouchers',
                    style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary),
                  ),
                  Text(
                    'All transactions, day-wise',
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
                child: const Icon(Icons.tune_rounded, color: AppColors.primary, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            style: GoogleFonts.inter(fontSize: 14, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search party or voucher #',
              hintStyle: GoogleFonts.inter(color: AppColors.textMuted, fontSize: 14),
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted, size: 20),
              contentPadding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(BuildContext context, DashboardState state) {
    final filters = ['All', 'Sales', 'Purchase', 'Receipt', 'Payment'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: filters.map((f) {
          final active = state.vouchersFilter == f;
          return GestureDetector(
            onTap: () => context.read<DashboardBloc>().add(NavigateToVouchers(f)),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
              decoration: BoxDecoration(
                gradient: active ? AppColors.primaryGradient : null,
                color: active ? null : Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: active ? Colors.transparent : AppColors.border),
                boxShadow: active
                    ? [BoxShadow(color: AppColors.primary.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 3))]
                    : [],
              ),
              child: Text(
                f,
                style: GoogleFonts.inter(
                  color: active ? Colors.white : AppColors.textSecondary,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                  fontSize: 13,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildVoucherList(String filter) {
    final showSales = filter == 'All' || filter == 'Sales';
    final showPurchase = filter == 'All' || filter == 'Purchase';
    final showReceipt = filter == 'All' || filter == 'Receipt';
    final showPayment = filter == 'All' || filter == 'Payment';

    return ListView(
      padding: const EdgeInsets.only(bottom: 120),
      physics: const BouncingScrollPhysics(),
      children: [
        if (showSales || showReceipt) ...[
          _dateHeader('11 MAY 2026', '₹17,850'),
          if (showSales)
            const VoucherListItem(
              title: 'Anand Kirana Stores',
              subtitle: 'INV-1042 • Sales',
              amount: '₹12,450',
              status: 'DUE',
              icon: Icons.receipt_long_outlined,
              iconColor: AppColors.success,
              isNegative: false,
            ),
          if (showSales)
            const VoucherListItem(
              title: 'Bharath Hardware',
              subtitle: 'INV-1041 • Sales',
              amount: '₹5,400',
              status: 'PAID',
              icon: Icons.receipt_long_outlined,
              iconColor: AppColors.success,
              isNegative: false,
            ),
        ],
        if (showPurchase || showReceipt || showPayment) ...[
          _dateHeader('10 MAY 2026', '₹32,900'),
          if (showReceipt)
            const VoucherListItem(
              title: 'Citylight Electricals',
              subtitle: 'RC-220 • Receipt',
              amount: '₹4,500',
              status: 'PAID',
              icon: Icons.file_download_outlined,
              iconColor: AppColors.primary,
              isNegative: false,
            ),
          if (showPurchase)
            const VoucherListItem(
              title: 'Sunrise Distributors',
              subtitle: 'PUR-318 • Purchase',
              amount: '₹28,400',
              status: 'DUE',
              icon: Icons.shopping_bag_outlined,
              iconColor: AppColors.warning,
              isNegative: true,
            ),
        ],
        if (showPayment) ...[
          _dateHeader('07 MAY 2026', '₹15,000'),
          const VoucherListItem(
            title: 'Krishna Wholesale',
            subtitle: 'PAY-305 • Payment',
            amount: '₹15,000',
            status: 'PAID',
            icon: Icons.file_upload_outlined,
            iconColor: AppColors.error,
            isNegative: true,
          ),
        ],
      ],
    );
  }

  Widget _dateHeader(String date, String total) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: GoogleFonts.inter(
              color: AppColors.textMuted,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          Text(
            total,
            style: GoogleFonts.inter(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
