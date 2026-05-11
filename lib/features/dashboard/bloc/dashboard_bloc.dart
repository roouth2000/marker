import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(data: _mockData[TimeFilter.week]!)) {
    on<FilterChanged>(_onFilterChanged);
    on<NavigateToVouchers>(_onNavigateToVouchers);
    on<TabChanged>(_onTabChanged);
  }

  void _onFilterChanged(FilterChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(
      filter: event.filter,
      data: _mockData[event.filter],
    ));
  }

  void _onNavigateToVouchers(NavigateToVouchers event, Emitter<DashboardState> emit) {
    emit(state.copyWith(
      currentTabIndex: 1, // Vouchers tab index
      vouchersFilter: event.voucherFilter,
    ));
  }

  void _onTabChanged(TabChanged event, Emitter<DashboardState> emit) {
    emit(state.copyWith(currentTabIndex: event.index));
  }

  static const Map<TimeFilter, DashboardData> _mockData = {
    TimeFilter.today: DashboardData(
      sales: '₹17,850',
      purchase: '₹0',
      receipts: '₹0',
      payments: '₹0',
      netProfit: '₹17,850',
    ),
    TimeFilter.week: DashboardData(
      sales: '₹51,750',
      purchase: '₹40,600',
      receipts: '₹12,500',
      payments: '₹15,000',
      netProfit: '₹11,150',
    ),
    TimeFilter.month: DashboardData(
      sales: '₹2,45,000',
      purchase: '₹1,20,000',
      receipts: '₹80,000',
      payments: '₹45,000',
      netProfit: '₹1,25,000',
    ),
    TimeFilter.allTime: DashboardData(
      sales: '₹15,40,000',
      purchase: '₹8,20,000',
      receipts: '₹4,50,000',
      payments: '₹3,10,000',
      netProfit: '₹7,20,000',
    ),
  };
}
