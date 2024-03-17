part of 'dashboard_page_cubit.dart';

abstract class DashboardPageCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardPageCubitInitial extends DashboardPageCubitState {}

class DashboardPageCubitLoadingState extends DashboardPageCubitState {}

class DashboardPageCubitErrorState extends DashboardPageCubitState {}

class DashboardPageCubitLoadedState extends DashboardPageCubitState {
  DashboardPageCubitLoadedState({required this.uncompletedEntries});

  final int uncompletedEntries;

  @override
  List<Object> get props => [
        uncompletedEntries,
      ];
}
