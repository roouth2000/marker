import 'package:equatable/equatable.dart';
import 'dashboard_event.dart';

class DashboardData extends Equatable {
  final String sales;
  final String purchase;
  final String receipts;
  final String payments;
  final String netProfit;

  const DashboardData({
    required this.sales,
    required this.purchase,
    required this.receipts,
    required this.payments,
    required this.netProfit,
  });

  @override
  List<Object> get props => [sales, purchase, receipts, payments, netProfit];
}

class DashboardState extends Equatable {
  final TimeFilter filter;
  final DashboardData data;
  final int currentTabIndex;
  final String vouchersFilter;

  const DashboardState({
    this.filter = TimeFilter.week,
    required this.data,
    this.currentTabIndex = 0,
    this.vouchersFilter = 'All',
  });

  DashboardState copyWith({
    TimeFilter? filter,
    DashboardData? data,
    int? currentTabIndex,
    String? vouchersFilter,
  }) {
    return DashboardState(
      filter: filter ?? this.filter,
      data: data ?? this.data,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      vouchersFilter: vouchersFilter ?? this.vouchersFilter,
    );
  }

  @override
  List<Object> get props => [filter, data, currentTabIndex, vouchersFilter];
}
