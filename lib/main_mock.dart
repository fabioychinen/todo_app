import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/app/basic_app.dart';
import 'package:todo_app/data/data_sources/local/memory_todo_local_data_source.dart';
import 'package:todo_app/data/repositories/todo_repository_local.dart';

import 'package:todo_app/domain/repositories/todo_repository.dart';

void main() {
  runApp(
    RepositoryProvider<ToDoRepository>(
      create: (context) => ToDoRepositoryLocal(
        localDataSource: MemoryLocalDataSource(),
      ),
      child: const BasicApp(),
    ),
  );
}
