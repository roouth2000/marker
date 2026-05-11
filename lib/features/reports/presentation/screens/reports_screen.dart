import 'package:flutter/material.dart';
import '../widgets/profit_loss_summary.dart';
import '../widgets/report_tile.dart';
import '../widgets/reports_bar_chart.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reports',
              style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
            ),
            Text(
              'Profit & Loss, ledgers',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildTimeFilter(),
            const SizedBox(height: 20),
            const ProfitLossSummary(),
            const ReportsBarChart(),
            ReportTile(
              title: 'Sales register',
              amount: '₹91,150',
              icon: Icons.receipt_long_outlined,
              iconColor: Colors.green,
              onTap: () {},
            ),
            ReportTile(
              title: 'Purchase register',
              amount: '₹50,400',
              icon: Icons.shopping_cart_outlined,
              iconColor: Colors.orange,
              onTap: () {},
            ),
            ReportTile(
              title: 'Receipts',
              amount: '₹12,500',
              icon: Icons.receipt_long_outlined,
              iconColor: Colors.blue,
              onTap: () {},
            ),
            ReportTile(
              title: 'Payments',
              amount: '₹27,200',
              icon: Icons.payments_outlined,
              iconColor: Colors.red,
              onTap: () {},
            ),
            ReportTile(
              title: 'Receivable summary',
              amount: '₹46,350',
              icon: Icons.trending_up,
              iconColor: Colors.green,
              onTap: () {},
            ),
            ReportTile(
              title: 'Payable summary',
              amount: '₹13,400',
              icon: Icons.trending_down,
              iconColor: Colors.red,
              onTap: () {},
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeFilter() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildFilterItem('Week', false),
          _buildFilterItem('Month', true),
          _buildFilterItem('All Time', false),
        ],
      ),
    );
  }

  Widget _buildFilterItem(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF64748B),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
