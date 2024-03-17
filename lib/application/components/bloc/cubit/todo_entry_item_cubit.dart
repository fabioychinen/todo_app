import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/core/use_case.dart';

import 'package:todo_app/domain/entities/todo_entry.dart';

import 'package:todo_app/domain/entities/unique_id.dart';

import 'package:todo_app/domain/use_cases/load_todo_entry.dart';

import 'package:todo_app/domain/use_cases/update_todo_entry.dart';

part 'todo_entry_item_cubit_state.dart';

class ToDoEntryItemCubit extends Cubit<ToDoEntryItemState> {
  ToDoEntryItemCubit({
    required this.loadToDoEntry,
    required this.entryId,
    required this.collectionId,
    required this.uploadToDoEntry,
  }) : super(ToDoEntryItemLoadingState());

  final EntryId entryId;

  final CollectionId collectionId;

  final LoadToDoEntry loadToDoEntry;

  final UpdateToDoEntry uploadToDoEntry;

  Future<void> fetch() async {
    try {
      final entry = await loadToDoEntry.call(
        ToDoEntryIdsParams(
          collectionId: collectionId,
          entryId: entryId,
        ),
      );

      return entry.fold(
        (left) => emit(ToDoEntryItemErrorState()),
        (right) => emit(ToDoEntryItemLoadedState(toDoEntry: right)),
      );
    } on Exception {
      emit(ToDoEntryItemErrorState());
    }
  }

  Future<void> update() async {
    try {
      final updatedEntry = await uploadToDoEntry.call(ToDoEntryIdsParams(
        collectionId: collectionId,
        entryId: entryId,
      ));

      return updatedEntry.fold(
        (left) => emit(ToDoEntryItemErrorState()),
        (right) => emit(
          ToDoEntryItemLoadedState(toDoEntry: right),
        ),
      );
    } on Exception {
      emit(ToDoEntryItemErrorState());
    }
  }
}
