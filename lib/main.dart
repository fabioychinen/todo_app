import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/application/app/basic_app.dart';
import 'package:todo_app/data/data_sources/local/hive_local_datasource.dart';
import 'package:todo_app/data/repositories/todo_repository_local.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/application/pages/home/bloc/cubit/navigation_todo_cubit.dart';

void main() async {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  final localDataSource = HiveLocalDataSource();
  await localDataSource.init();
  runApp(
    RepositoryProvider<ToDoRepository>(
      create: (context) => ToDoRepositoryLocal(
        localDataSource: localDataSource,
      ),
      child: BlocProvider<NavigationToDoCubit>(
        create: (context) => NavigationToDoCubit(),
        child: const BasicApp(),
      ),
    ),
  );
}
