import 'package:flutter/material.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';

class ToDoEntryItemLoaded extends StatelessWidget {
  const ToDoEntryItemLoaded({
    super.key,
    required this.toDoEntry,
    required this.onChanged,
  });

  final ToDoEntry toDoEntry;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.03,
      ),
      child: CheckboxListTile(
        title: Text(toDoEntry.description),
        value: toDoEntry.isDone,
        onChanged: onChanged,
      ),
    );
  }
}
