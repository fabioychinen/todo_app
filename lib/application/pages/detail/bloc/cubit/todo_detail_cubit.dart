import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_detail_cubit_state.dart';

class ToDoDetailCubit extends Cubit<ToDoDetailCubitState> {
  ToDoDetailCubit({
    required this.collectionId,
    required this.loadToDoEntryIdsForCollection,
  }) : super(const ToDoDetailCubitLoadingState());

  final CollectionId collectionId;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;

  Future<void> fetch() async {
    emit(const ToDoDetailCubitLoadingState());

    try {
      final entryIds = await loadToDoEntryIdsForCollection.call(
        CollectionIdParams(
          collectionId: collectionId,
        ),
      );

      if (entryIds.isLeft) {
        emit(const ToDoDetailCubitErrorState());
      } else {
        emit(
          ToDoDetailCubitLoadedState(
            entryIds: entryIds.right,
          ),
        );
      }
    } on Exception {
      emit(const ToDoDetailCubitErrorState());
    }
  }
}
