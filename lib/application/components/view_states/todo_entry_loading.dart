import 'package:flutter/material.dart';

class ToDoEntryItemLoading extends StatelessWidget {
  const ToDoEntryItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.blueAccent,
      backgroundColor: Colors.grey,
    ));
  }
}
