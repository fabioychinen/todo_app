import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/load_overview_todo_collections.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/dashboard/bloc/cubit/dashboard_page_cubit.dart';
import 'package:todo_app/application/pages/dashboard/view_states/dashboard_page_error.dart';
import 'package:todo_app/application/pages/dashboard/view_states/dashboard_page_loading.dart';

import 'view_states/dashboard_page_loaded.dart';

class DashboardPageProvider extends StatelessWidget {
  const DashboardPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final toDoRepository = RepositoryProvider.of<ToDoRepository>(context);
    return BlocProvider<DashboardPageCubit>(
      create: (context) => DashboardPageCubit(
        loadOverviewToDoCollections: LoadOverviewToDoCollections(
          toDoRepository: toDoRepository,
        ),
        loadToDoEntry: LoadToDoEntry(
          toDoRepository: toDoRepository,
        ),
        loadToDoEntryIdsForCollection: LoadToDoEntryIdsForCollection(
          toDoRepository: toDoRepository,
        ),
      )..readUncompletedEntries(),
      child: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.dashboard_rounded,
    name: 'dashboard',
    child: DashboardPageProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardPageCubit, DashboardPageCubitState>(
      builder: (context, state) {
        if (state is DashboardPageCubitLoadingState) {
          return const DashboardPageLoading();
        } else if (state is DashboardPageCubitLoadedState) {
          return DashboardPageLoaded(
              uncompletedTasks: state.uncompletedEntries);
        } else {
          return const DashboardPageError();
        }
      },
    );
  }
}
