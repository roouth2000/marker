import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/dashboard_bloc.dart';
import '../../bloc/dashboard_event.dart';
import '../../../inventory/presentation/screens/product_list_screen.dart';
import '../../../invoices/presentation/screens/create_invoice_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = [
      {'label': 'New Invoice', 'icon': Icons.description_outlined, 'color': Colors.blue, 'action': 'invoice'},
      {'label': 'Purchase', 'icon': Icons.shopping_cart_outlined, 'color': Colors.orange, 'filter': 'Purchase'},
      {'label': 'Receipt', 'icon': Icons.receipt_long_outlined, 'color': Colors.green, 'filter': 'Receipt'},
      {'label': 'Payment', 'icon': Icons.payments_outlined, 'color': Colors.red, 'filter': 'Payment'},
      {'label': 'Parties', 'icon': Icons.people_outline, 'color': Colors.purple, 'tab': 2},
      {'label': 'Stock', 'icon': Icons.inventory_2_outlined, 'color': Colors.indigo, 'action': 'stock'},
      {'label': 'Reports', 'icon': Icons.analytics_outlined, 'color': Colors.teal, 'tab': 3},
      {'label': 'Vouchers', 'icon': Icons.confirmation_number_outlined, 'color': Colors.brown, 'filter': 'All'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Text(
            'Quick actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: actions.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final action = actions[index];
              return InkWell(
                onTap: () {
                  if (action['filter'] != null) {
                    context.read<DashboardBloc>().add(NavigateToVouchers(action['filter'] as String));
                  } else if (action['tab'] != null) {
                    context.read<DashboardBloc>().add(TabChanged(action['tab'] as int));
                  } else if (action['action'] == 'stock') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductListScreen()));
                  } else if (action['action'] == 'invoice') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateInvoiceScreen()));
                  }
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (action['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        action['icon'] as IconData,
                        color: action['color'] as Color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      action['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
