import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import '../../bloc/dashboard_state.dart';
import 'home_tab.dart';
import '../../../vouchers/presentation/screens/vouchers_screen.dart';
import '../../../parties/presentation/screens/parties_screen.dart';
import '../../../reports/presentation/screens/reports_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            body: IndexedStack(
              index: state.currentTabIndex,
              children: _tabs,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              backgroundColor: const Color(0xFF3B82F6),
              shape: const CircleBorder(),
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              notchMargin: 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(context, 0, Icons.grid_view_rounded, 'Home', state.currentTabIndex),
                  _buildNavItem(context, 1, Icons.confirmation_number_outlined, 'Vouchers', state.currentTabIndex),
                  const SizedBox(width: 40), // Space for FAB
                  _buildNavItem(context, 2, Icons.people_outline, 'Parties', state.currentTabIndex),
                  _buildNavItem(context, 3, Icons.analytics_outlined, 'Reports', state.currentTabIndex),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label, int currentIndex) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => context.read<DashboardBloc>().add(TabChanged(index)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF64748B),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
