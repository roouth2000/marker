import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/quick_actions.dart';
import '../widgets/recent_list_item.dart';
import '../widgets/stats_grid.dart';
import '../widgets/summary_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import '../../bloc/dashboard_state.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 390,
                    decoration: const BoxDecoration(
                      gradient: AppColors.headerGradient,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Column(
                      children: [
                        const DashboardHeader(),
                        const SummaryCard(),
                        const SizedBox(height: 10),
                        TimeFilterRow(
                          selectedFilter: state.filter,
                          onFilterChanged: (filter) {
                            context.read<DashboardBloc>().add(FilterChanged(filter));
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              StatsGrid(
                sales: state.data.sales,
                purchase: state.data.purchase,
                receipts: state.data.receipts,
                payments: state.data.payments,
              ),
              _buildNetProfitCard(state),
              const QuickActions(),
              _buildSectionHeader('Receivable due'),
              const RecentListItem(
                title: 'Anand Kirana Stores',
                subtitle: '+91 99000 11122',
                amount: '₹12,450',
                status: 'due',
                letter: 'A',
                color: Colors.blue,
              ),
              const RecentListItem(
                title: 'Citylight Electricals',
                subtitle: '+91 90000 55667',
                amount: '₹8,900',
                status: 'due',
                letter: 'C',
                color: Colors.indigo,
              ),
              _buildSectionHeader('Recent vouchers'),
              const RecentListItem(
                title: 'Anand Kirana Stores',
                subtitle: 'INV-1042 • 11 May',
                amount: '₹12,450',
                status: 'Sales',
                letter: 'S',
                color: Colors.green,
              ),
              const SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF3B82F6),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNetProfitCard(DashboardState state) {
    String title = "NET PROFIT (WEEK)";
    if (state.filter == TimeFilter.today) title = "NET PROFIT (TODAY)";
    if (state.filter == TimeFilter.month) title = "NET PROFIT (MONTH)";
    if (state.filter == TimeFilter.allTime) title = "NET PROFIT (ALL TIME)";

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                state.data.netProfit,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.green, size: 14),
                  SizedBox(width: 5),
                  Text(
                    '+14.2% vs prev',
                    style: TextStyle(color: Colors.green, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.1),
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.white.withOpacity(0.2)),
              ),
            ),
            child: const Text('View P&L', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class TimeFilterRow extends StatelessWidget {
  final TimeFilter selectedFilter;
  final Function(TimeFilter) onFilterChanged;

  const TimeFilterRow({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFilterItem('Today', TimeFilter.today),
          _buildFilterItem('Week', TimeFilter.week),
          _buildFilterItem('Month', TimeFilter.month),
          _buildFilterItem('All Time', TimeFilter.allTime),
        ],
      ),
    );
  }

  Widget _buildFilterItem(String label, TimeFilter filter) {
    final isSelected = selectedFilter == filter;
    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(filter),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0F172A) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white.withOpacity(0.6),
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
