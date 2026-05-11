import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import '../../../inventory/presentation/screens/product_list_screen.dart';
import '../../../invoices/presentation/screens/create_invoice_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action('New Invoice', Icons.description_outlined, const Color(0xFF3B82F6), 'invoice'),
      _Action('Purchase', Icons.shopping_bag_outlined, const Color(0xFFF59E0B), null, filter: 'Purchase'),
      _Action('Receipt', Icons.file_download_outlined, const Color(0xFF10B981), null, filter: 'Receipt'),
      _Action('Payment', Icons.file_upload_outlined, const Color(0xFFEF4444), null, filter: 'Payment'),
      _Action('Parties', Icons.people_outline_rounded, const Color(0xFF8B5CF6), null, tab: 2),
      _Action('Stock', Icons.inventory_2_outlined, const Color(0xFF6366F1), 'stock'),
      _Action('Reports', Icons.bar_chart_rounded, const Color(0xFF14B8A6), null, tab: 3),
      _Action('Vouchers', Icons.receipt_long_outlined, const Color(0xFF78716C), null, filter: 'All'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
          child: Text(
            'Quick Actions',
            style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: actions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemBuilder: (context, i) => _ActionTile(action: actions[i]),
        ),
      ],
    );
  }
}

class _Action {
  final String label;
  final IconData icon;
  final Color color;
  final String? actionKey;
  final String? filter;
  final int? tab;

  const _Action(this.label, this.icon, this.color, this.actionKey, {this.filter, this.tab});
}

class _ActionTile extends StatelessWidget {
  final _Action action;

  const _ActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (action.filter != null) {
          context.read<DashboardBloc>().add(NavigateToVouchers(action.filter!));
        } else if (action.tab != null) {
          context.read<DashboardBloc>().add(TabChanged(action.tab!));
        } else if (action.actionKey == 'stock') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListScreen()));
        } else if (action.actionKey == 'invoice') {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateInvoiceScreen()));
        }
      },
      borderRadius: BorderRadius.circular(14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: action.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(action.icon, color: action.color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            action.label,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
