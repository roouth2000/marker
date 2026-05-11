import 'package:equatable/equatable.dart';

enum TimeFilter { today, week, month, allTime }

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class FilterChanged extends DashboardEvent {
  final TimeFilter filter;

  const FilterChanged(this.filter);

  @override
  List<Object> get props => [filter];
}

class NavigateToVouchers extends DashboardEvent {
  final String voucherFilter;

  const NavigateToVouchers(this.voucherFilter);

  @override
  List<Object> get props => [voucherFilter];
}

class TabChanged extends DashboardEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object> get props => [index];
}
