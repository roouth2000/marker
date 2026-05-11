import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/voucher_list_item.dart';
import '../../../dashboard/bloc/dashboard_bloc.dart';
import '../../../dashboard/bloc/dashboard_state.dart';
import '../../../dashboard/bloc/dashboard_event.dart';

class VouchersScreen extends StatelessWidget {
  const VouchersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vouchers',
                  style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
                ),
                Text(
                  'All transactions, day-wise',
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 12),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search party or voucher #',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF64748B)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildFilterChip(context, 'All', state.vouchersFilter == 'All'),
                    _buildFilterChip(context, 'Sales', state.vouchersFilter == 'Sales'),
                    _buildFilterChip(context, 'Purchase', state.vouchersFilter == 'Purchase'),
                    _buildFilterChip(context, 'Receipt', state.vouchersFilter == 'Receipt'),
                    _buildFilterChip(context, 'Payment', state.vouchersFilter == 'Payment'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _buildVoucherList(state.vouchersFilter),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChip(BuildContext context, String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        context.read<DashboardBloc>().add(NavigateToVouchers(label));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF1E293B),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildVoucherList(String filter) {
    // Mock filtering logic
    bool showSales = filter == 'All' || filter == 'Sales';
    bool showPurchase = filter == 'All' || filter == 'Purchase';
    bool showReceipt = filter == 'All' || filter == 'Receipt';

    return ListView(
      children: [
        if (showSales || showReceipt) ...[
          _buildDateHeader('11 MAY', '₹17,850'),
          if (showSales)
            const VoucherListItem(
              title: 'Anand Kirana Stores',
              subtitle: 'INV-1042 • Sales',
              amount: '₹12,450',
              status: 'DUE',
              icon: Icons.receipt_long_outlined,
              iconColor: Colors.green,
            ),
          if (showSales)
            const VoucherListItem(
              title: 'Bharath Hardware',
              subtitle: 'INV-1041 • Sales',
              amount: '₹5,400',
              status: 'PAID',
              icon: Icons.receipt_long_outlined,
              iconColor: Colors.green,
            ),
        ],
        if (showPurchase || showReceipt) ...[
          _buildDateHeader('10 MAY', '₹32,900'),
          if (showReceipt)
            const VoucherListItem(
              title: 'Citylight Electricals',
              subtitle: 'RC-220 • Receipt',
              amount: '₹4,500',
              status: 'PAID',
              icon: Icons.receipt_long_outlined,
              iconColor: Colors.blue,
            ),
          if (showPurchase)
            const VoucherListItem(
              title: 'Sunrise Distributors',
              subtitle: 'PUR-318 • Purchase',
              amount: '₹28,400',
              status: 'DUE',
              isNegative: true,
              icon: Icons.shopping_cart_outlined,
              iconColor: Colors.orange,
            ),
        ],
      ],
    );
  }

  Widget _buildDateHeader(String date, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              color: Color(0xFF1E293B),
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
