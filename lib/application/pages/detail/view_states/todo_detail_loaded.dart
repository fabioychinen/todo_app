import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/application/components/todo_entry_item/todo_entry_item.dart';
import 'package:todo_app/application/pages/create_todo_entry/create_todo_entry_page.dart';
import 'package:todo_app/application/pages/detail/bloc/cubit/todo_detail_cubit.dart';

class ToDoDetailLoaded extends StatelessWidget {
  const ToDoDetailLoaded({
    super.key,
    required this.entryIds,
    this.collectionId,
  });

  final List<EntryId> entryIds;
  final CollectionId? collectionId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            if (collectionId != null)
              ListView.builder(
                itemCount: entryIds.length,
                itemBuilder: (context, index) => ToDoEntryItemProvider(
                  collectionId: collectionId!,
                  entryId: entryIds[index],
                ),
              ),
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                key: const Key('create-todo-entry'),
                heroTag: 'create-todo-entry',
                tooltip: 'detail_add_todo'.tr(),
                onPressed: collectionId == null
                    ? null
                    : () {
                        context.pushNamed(
                          CreateToDoEntryPage.pageConfig.name,
                          extra: CreateToDoEntryPageExtra(
                            collectionId: collectionId!,
                            toDoEntryItemAddedCallback:
                                context.read<ToDoDetailCubit>().fetch,
                          ),
                        );
                      },
                child: const Icon(Icons.add_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
