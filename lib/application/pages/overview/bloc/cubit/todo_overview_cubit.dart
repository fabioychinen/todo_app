import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';

import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/delete_todo_collection.dart';

import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/use_cases/load_overview_todo_collections.dart';

part 'todo_overview_state.dart';

class ToDoOverviewCubit extends Cubit<ToDoOverviewCubitState> {
  ToDoOverviewCubit(
      {ToDoOverviewCubitState? initialState,
      required this.loadOverviewToDoCollections,
      required this.deleteToDoCollection})
      : super(initialState ?? ToDoOverviewCubitLoadingState());

  final LoadOverviewToDoCollections loadOverviewToDoCollections;
  final DeleteToDoCollection deleteToDoCollection;

  Future<void> readToDoOverviewCollections() async {
    emit(
      ToDoOverviewCubitLoadingState(),
    );

    try {
      final collectionsFuture = loadOverviewToDoCollections.call(NoParams());
      final collections = await collectionsFuture;

      if (collections.isLeft) {
        emit(
          ToDoOverviewCubitErrorState(),
        );
      } else {
        emit(
          ToDoOverviewCubitLoadedState(
            collections: collections.right,
          ),
        );
      }
    } on Exception {
      emit(
        ToDoOverviewCubitErrorState(),
      );
    }
  }

  Future<void> removeToDoCollection(
      {required CollectionId collectionId}) async {
    emit(
      ToDoOverviewCubitLoadingState(),
    );

    try {
      await deleteToDoCollection.call(
        CollectionIdParams(collectionId: collectionId),
      );

      final collectionsFuture = loadOverviewToDoCollections.call(
        NoParams(),
      );
      final collections = await collectionsFuture;

      if (collections.isLeft) {
        emit(
          ToDoOverviewCubitErrorState(),
        );
      } else {
        emit(
          ToDoOverviewCubitLoadedState(
            collections: collections.right,
          ),
        );
      }
    } on Exception {
      emit(
        ToDoOverviewCubitErrorState(),
      );
    }
  }
}
