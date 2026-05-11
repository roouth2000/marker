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
            floatingActionButton: Container(
              height: 64,
              width: 64,
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: const Color(0xFF3B82F6),
                elevation: 4,
                shape: const CircleBorder(),
                child: const Icon(Icons.add, color: Colors.white, size: 32),
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              height: 70,
              padding: EdgeInsets.zero,
              color: Colors.white,
              shape: const CircularNotchedRectangle(),
              notchMargin: 10,
              elevation: 20,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(context, 0, Icons.grid_view_rounded, 'Home', state.currentTabIndex),
                        _buildNavItem(context, 1, Icons.confirmation_number_outlined, 'Vouchers', state.currentTabIndex),
                      ],
                    ),
                  ),
                  const SizedBox(width: 80), // Increased space for the notched FAB
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(context, 2, Icons.people_outline, 'Parties', state.currentTabIndex),
                        _buildNavItem(context, 3, Icons.analytics_outlined, 'Reports', state.currentTabIndex),
                      ],
                    ),
                  ),
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.read<DashboardBloc>().add(TabChanged(index)),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected ? const Color(0xFF3B82F6) : const Color(0xFF94A3B8),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
