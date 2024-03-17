part of 'todo_overview_cubit.dart';

abstract class ToDoOverviewCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ToDoOverviewCubitInitial extends ToDoOverviewCubitState {}

class ToDoOverviewCubitLoadingState extends ToDoOverviewCubitState {}

class ToDoOverviewCubitErrorState extends ToDoOverviewCubitState {}

class ToDoOverviewCubitLoadedState extends ToDoOverviewCubitState {
  ToDoOverviewCubitLoadedState({
    required this.collections,
  });

  final List<ToDoCollection> collections;

  @override
  List<Object> get props => [
        collections,
      ];
}
