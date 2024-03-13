import 'package:flutter/material.dart';

class ToDoEntryItemError extends StatelessWidget {
  const ToDoEntryItemError({super.key, required this.onRetry});
  final Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onRetry,
      leading: const Icon(Icons.warning_rounded),
      title: const Text('Could not load item. Tap to reload.'),
    );
  }
}
