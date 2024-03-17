import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/components/todo_entry_item/bloc/cubit/todo_entry_item_cubit.dart';

class ToDoEntryItemError extends StatelessWidget {
  const ToDoEntryItemError({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.read<ToDoEntryItemCubit>().fetch();
      },
      leading: const Icon(Icons.warning_rounded),
      title: const Text(
        'Could not load the item. Select the item to retry',
      ),
    );
  }
}
