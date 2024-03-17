import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/load_overview_todo_collections.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry.dart';
import 'package:todo_app/domain/use_cases/load_todo_entry_ids_for_collection.dart';
import 'package:todo_app/core/use_case.dart';

part 'dashboard_page_cubit_state.dart';

class DashboardPageCubit extends Cubit<DashboardPageCubitState> {
  DashboardPageCubit({
    required this.loadToDoEntryIdsForCollection,
    required this.loadOverviewToDoCollections,
    required this.loadToDoEntry,
  }) : super(DashboardPageCubitInitial());

  final LoadOverviewToDoCollections loadOverviewToDoCollections;
  final LoadToDoEntryIdsForCollection loadToDoEntryIdsForCollection;
  final LoadToDoEntry loadToDoEntry;

  Future<void> readUncompletedEntries() async {
    emit(
      DashboardPageCubitLoadingState(),
    );

    try {
      final collectionsFuture = loadOverviewToDoCollections.call(
        NoParams(),
      );
      final collections = await collectionsFuture;

      if (collections.isLeft) {
        emit(
          DashboardPageCubitErrorState(),
        );
      } else {
        List<EntryId> totalEntryIds = [];
        int uncompletedEntries = 0;

        for (final collection in collections.right) {
          final collectionEntryIds = await loadToDoEntryIdsForCollection(
            CollectionIdParams(
              collectionId: collection.id,
            ),
          );

          if (collectionEntryIds.isLeft) {
            emit(
              DashboardPageCubitErrorState(),
            );
          } else {
            totalEntryIds.addAll(collectionEntryIds.right);

            for (final entryId in collectionEntryIds.right) {
              var toDoEntry = await loadToDoEntry(
                ToDoEntryIdsParams(
                  collectionId: collection.id,
                  entryId: entryId,
                ),
              );

              if (toDoEntry.isLeft) {
                emit(DashboardPageCubitErrorState());
              } else {
                if (!toDoEntry.right.isDone) {
                  uncompletedEntries++;
                }
              }
            }
          }
        }

        emit(DashboardPageCubitLoadedState(
          uncompletedEntries: uncompletedEntries,
        ));
      }
    } on Exception {
      emit(
        DashboardPageCubitErrorState(),
      );
    }
  }
}
