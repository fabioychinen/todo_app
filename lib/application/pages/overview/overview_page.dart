import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/overview/bloc/cubit/todo_overview_cubit.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_error.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_loading.dart';
import 'package:todo_app/domain/use_cases/load_todo_collections.dart';

class OverviewPageProvider extends StatelessWidget {
  const OverviewPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoOverviewCubit(
        loadToDoCollections: LoadToDoCollections(
          toDoRepository: RepositoryProvider.of(context),
        ),
      )..readToDoCollections(),
      child: const OverviewPage(),
    );
  }
}

class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});

  static const pageConfig = PageConfig(
    icon: Icons.work_history_rounded,
    name: 'overview',
    child: OverviewPageProvider(),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.tealAccent,
      child: BlocBuilder<ToDoOverviewCubit, ToDoOverviewCubitState>(
        builder: (context, state) {
          if (state is ToDoOverviewCubitLoadingState) {
            return const ToDoOverviewLoading();
          } else if (state is ToDoOverviewCubitLoadedState) {
            return ToDoOverviewLoaded(collections: state.collections);
          } else {
            return const ToDoOverviewError();
          }
        },
      ),
    );
  }
}
