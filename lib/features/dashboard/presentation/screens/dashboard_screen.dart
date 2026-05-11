import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import '../../bloc/dashboard_state.dart';
import 'home_tab.dart';
import '../../../vouchers/presentation/screens/vouchers_screen.dart';
import '../../../parties/presentation/screens/parties_screen.dart';
import '../../../reports/presentation/screens/reports_screen.dart';
import '../../../invoices/presentation/screens/create_invoice_screen.dart';
import '../../../inventory/presentation/screens/product_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _tabs = [
    const HomeTab(),
    const VouchersScreen(),
    const PartiesScreen(),
    const ReportsScreen(),
  ];

  void _showFabMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => const _FabMenuSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.scaffold,
            extendBody: true,
            body: IndexedStack(
              index: state.currentTabIndex,
              children: _tabs,
            ),
            floatingActionButton: _buildFAB(context),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: _buildBottomBar(context, state),
          );
        },
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () => _showFabMenu(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 30),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, DashboardState state) {
    return BottomAppBar(
      height: 72,
      padding: EdgeInsets.zero,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      elevation: 24,
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(context, 0, Icons.grid_view_rounded, Icons.grid_view, 'Home', state.currentTabIndex),
                _navItem(context, 1, Icons.receipt_long_rounded, Icons.receipt_long_outlined, 'Vouchers', state.currentTabIndex),
              ],
            ),
          ),
          const SizedBox(width: 80),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _navItem(context, 2, Icons.people_rounded, Icons.people_outline_rounded, 'Parties', state.currentTabIndex),
                _navItem(context, 3, Icons.bar_chart_rounded, Icons.bar_chart_outlined, 'Reports', state.currentTabIndex),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(
    BuildContext context,
    int index,
    IconData activeIcon,
    IconData inactiveIcon,
    String label,
    int current,
  ) {
    final isActive = index == current;
    return InkWell(
      onTap: () => context.read<DashboardBloc>().add(TabChanged(index)),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isActive ? activeIcon : inactiveIcon,
                color: isActive ? AppColors.primary : AppColors.textMuted,
                size: 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── FAB Action Menu ────────────────────────────────────────────────────────────
class _FabMenuSheet extends StatelessWidget {
  const _FabMenuSheet();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _FabAction(
        icon: Icons.description_outlined,
        label: 'New Invoice',
        subtitle: 'Create a sales bill',
        color: AppColors.primary,
        bg: AppColors.infoLight,
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const CreateInvoiceScreen()));
        },
      ),
      _FabAction(
        icon: Icons.shopping_bag_outlined,
        label: 'New Purchase',
        subtitle: 'Record a purchase entry',
        color: AppColors.warning,
        bg: AppColors.warningLight,
        onTap: () {
          Navigator.pop(context);
          context.read<DashboardBloc>().add(NavigateToVouchers('Purchase'));
        },
      ),
      _FabAction(
        icon: Icons.file_download_outlined,
        label: 'Record Receipt',
        subtitle: 'Money received from customer',
        color: AppColors.success,
        bg: AppColors.successLight,
        onTap: () {
          Navigator.pop(context);
          context.read<DashboardBloc>().add(NavigateToVouchers('Receipt'));
        },
      ),
      _FabAction(
        icon: Icons.file_upload_outlined,
        label: 'Record Payment',
        subtitle: 'Money paid to supplier',
        color: AppColors.error,
        bg: AppColors.errorLight,
        onTap: () {
          Navigator.pop(context);
          context.read<DashboardBloc>().add(NavigateToVouchers('Payment'));
        },
      ),
      _FabAction(
        icon: Icons.inventory_2_outlined,
        label: 'Add Product',
        subtitle: 'Manage your inventory',
        color: const Color(0xFF6366F1),
        bg: const Color(0xFFEDE9FE),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (_) => const ProductListScreen()));
        },
      ),
    ];

    return Container(
      padding: const EdgeInsets.only(bottom: 28),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.border, borderRadius: BorderRadius.circular(2))),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Create New', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.close_rounded, size: 18, color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...actions.map((a) => _actionTile(a)),
        ],
      ),
    );
  }

  Widget _actionTile(_FabAction a) {
    return Builder(builder: (context) {
      return InkWell(
        onTap: a.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: a.bg, borderRadius: BorderRadius.circular(16)),
                child: Icon(a.icon, color: a.color, size: 22),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(a.label, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    Text(a.subtitle, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
            ],
          ),
        ),
      );
    });
  }
}

class _FabAction {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final Color bg;
  final VoidCallback onTap;

  const _FabAction({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.bg,
    required this.onTap,
  });
}
