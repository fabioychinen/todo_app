// ignore_for_file: await_only_futures

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
      final collectionsEither = await loadOverviewToDoCollections.call(
        NoParams(),
      );
      final collections = await collectionsEither.fold(
        (failure) {
          emit(
            DashboardPageCubitErrorState(),
          );
          return [];
        },
        (collections) => collections,
      );

      List<EntryId> totalEntryIds = [];
      List<Future> entryFutures = [];

      for (final collection in collections) {
        final collectionEntryIdsEither = await loadToDoEntryIdsForCollection(
          CollectionIdParam(collectionId: collection.id),
        );
        await collectionEntryIdsEither.fold(
          (failure) {
            emit(
              DashboardPageCubitErrorState(),
            );
            return [];
          },
          (collectionEntryIds) {
            totalEntryIds.addAll(collectionEntryIds);
            entryFutures
                .addAll(collectionEntryIds.map((entryId) => loadToDoEntry(
                      ToDoEntryIdsParam(
                        collectionId: collection.id,
                        entryId: entryId,
                      ),
                    )));
          },
        );
      }

      final todoEntries = await Future.wait(entryFutures);

      int uncompletedEntries = 0;

      for (final toDoEntry in todoEntries) {
        if (!toDoEntry.isDone) {
          uncompletedEntries++;
        }
      }

      emit(DashboardPageCubitLoadedState(
        uncompletedEntries: uncompletedEntries,
      ));
    } on Exception {
      emit(
        DashboardPageCubitErrorState(),
      );
    }
  }
}
