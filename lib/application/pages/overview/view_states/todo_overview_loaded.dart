// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/application/pages/create_todo_collection/create_todo_collection_page.dart';
import 'package:todo_app/application/pages/detail/todo_detail_page.dart';
import 'package:todo_app/application/pages/home/bloc/cubit/navigation_todo_cubit.dart';
import 'package:todo_app/application/pages/overview/bloc/cubit/todo_overview_cubit.dart';

class ToDoOverviewLoaded extends StatelessWidget {
  const ToDoOverviewLoaded({
    super.key,
    required this.collections,
  });

  final List<ToDoCollection> collections;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: collections.length,
          itemBuilder: (context, index) {
            final item = collections[index];
            final colorScheme = Theme.of(context).colorScheme;
            return BlocBuilder<NavigationToDoCubit, NavigationToDoCubitState>(
              buildWhen: (previous, current) =>
                  previous.selectedCollectionId != current.selectedCollectionId,
              builder: (context, state) {
                return ListTile(
                  tileColor: colorScheme.surface,
                  selectedTileColor: colorScheme.surfaceVariant,
                  iconColor: item.todoColor.color,
                  selectedColor: item.todoColor.color,
                  selected: state.selectedCollectionId == item.id,
                  onTap: () {
                    context
                        .read<NavigationToDoCubit>()
                        .selectedToDoCollectionChanged(
                          item.id,
                        );
                    if (Breakpoints.small.isActive(context)) {
                      context.pushNamed(
                        ToDoDetailPage.pageConfig.name,
                        pathParameters: {
                          'collectionId': item.id.value,
                        },
                      );
                    }
                  },
                  leading: const Icon(Icons.circle),
                  title: Text(item.title),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              key: const Key('create-todo-collection'),
              heroTag: 'create-todo-collection',
              onPressed: () {
                context
                    .pushNamed(
                  CreateToDoCollectionPage.pageConfig.name,
                )
                    .then(
                  (value) {
                    if (value == true) {
                      context
                          .read<ToDoOverviewCubit>()
                          .readToDoOverviewCollections();
                    }
                  },
                );
              },
              child: Icon(
                CreateToDoCollectionPage.pageConfig.icon,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton(
              key: const Key('delete-todo-collection'),
              heroTag: 'delete-todo-collection',
              onPressed: () {
                CollectionId? collectionIdToRemove = context
                    .read<NavigationToDoCubit>()
                    .state
                    .selectedCollectionId;
                if (collectionIdToRemove != null) {
                  context.read<ToDoOverviewCubit>().removeToDoCollection(
                        collectionId: collectionIdToRemove,
                      );
                  context
                      .read<NavigationToDoCubit>()
                      .emit(const NavigationToDoCubitState());
                }
              },
              backgroundColor: Colors.redAccent,
              child: const Icon(
                Icons.delete_rounded,
              ),
            ),
          ),
        )
      ],
    );
  }
}
