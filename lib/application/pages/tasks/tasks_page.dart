import 'package:flutter/material.dart';
import 'package:todo_app/core/page_config.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.task_rounded,
    name: 'tasks',
    child: TasksPage(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.deepPurpleAccent,
      child: const Center(
        child: Text(
          'Tasks Page',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
