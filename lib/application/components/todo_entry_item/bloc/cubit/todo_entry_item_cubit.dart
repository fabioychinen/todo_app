import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/core/use_case.dart';

part 'todo_entry_item_cubit_state.dart';

class ToDoEntryItemCubit extends Cubit<ToDoEntryItemCubitState> {
  ToDoEntryItemCubit({
    required this.entryId,
    required this.collectionId,
    required this.loadToDoEntry,
    required this.updateToDoEntry,
  }) : super(
          ToDoEntryItemCubitLoadingState(),
        );

  final EntryId entryId;
  final CollectionId collectionId;
  final LoadToDoEntry loadToDoEntry;
  final UpdateToDoEntry updateToDoEntry;

  Future<void> fetch() async {
    try {
      final toDoEntry = await loadToDoEntry.call(ToDoEntryIdsParams(
        collectionId: collectionId,
        entryId: entryId,
      ));

      return toDoEntry.fold(
        (left) => emit(
          ToDoEntryItemCubitErrorState(),
        ),
        (right) => emit(
          ToDoEntryItemCubitLoadedState(
            toDoEntry: toDoEntry.right,
          ),
        ),
      );
    } on Exception {
      emit(ToDoEntryItemCubitErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await updateToDoEntry.call(
        ToDoEntryIdsParams(
          collectionId: collectionId,
          entryId: entryId,
        ),
      );

      return updatedEntry.fold(
        (left) => emit(ToDoEntryItemCubitErrorState()),
        (right) => emit(
          ToDoEntryItemCubitLoadedState(toDoEntry: right),
        ),
      );
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      emit(
        ToDoEntryItemCubitErrorState(),
      );
    }
  }
}
