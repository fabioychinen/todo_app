part of 'todo_overview_cubit.dart';


sealed class ToDoOverviewCubitState extends Equatable {

  const ToDoOverviewCubitState();


  @override

  List<Object> get props => [];

}


class ToDoOverviewCubitLoadingState extends ToDoOverviewCubitState {}


class ToDoOverviewCubitErrorState extends ToDoOverviewCubitState {}


class ToDoOverviewCubitLoadedState extends ToDoOverviewCubitState {

  const ToDoOverviewCubitLoadedState({required this.collections});


  final List<ToDoCollection> collections;


  @override

  List<Object> get props => [collections];

}
