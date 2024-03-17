import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/domain/use_cases/update_todo_entry.dart';
import 'package:todo_app/application/components/todo_entry_item/bloc/cubit/todo_entry_item_cubit.dart';
import 'package:todo_app/application/components/todo_entry_item/view_states/todo_entry_item_error.dart';
import 'package:todo_app/application/components/todo_entry_item/view_states/todo_entry_item_loaded.dart';
import 'package:todo_app/application/components/todo_entry_item/view_states/todo_entry_item_loading.dart';

class ToDoEntryItemProvider extends StatelessWidget {
  const ToDoEntryItemProvider({
    super.key,
    required this.collectionId,
    required this.entryId,
  });

  final CollectionId collectionId;
  final EntryId entryId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToDoEntryItemCubit>(
      create: (context) => ToDoEntryItemCubit(
        entryId: entryId,
        collectionId: collectionId,
        loadToDoEntry: LoadToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
        updateToDoEntry: UpdateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      )..fetch(),
      child: const ToDoEntryItem(),
    );
  }
}

class ToDoEntryItem extends StatelessWidget {
  const ToDoEntryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoEntryItemCubit, ToDoEntryItemCubitState>(
        builder: (context, state) {
      if (state is ToDoEntryItemCubitLoadingState) {
        return const ToDoEntryItemLoading();
      } else if (state is ToDoEntryItemCubitLoadedState) {
        return ToDoEntryItemLoaded(
          toDoEntry: state.toDoEntry,
          onChanged: (value) => context.read<ToDoEntryItemCubit>().update(),
        );
      } else {
        return const ToDoEntryItemError();
      }
    });
  }
}
