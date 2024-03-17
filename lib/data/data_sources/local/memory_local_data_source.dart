import 'package:todo_app/data/data_sources/interfaces/todo_local_data_source_interface.dart';
import 'package:todo_app/data/exceptions/exceptions.dart';
import 'package:todo_app/data/models/todo_collection_model.dart';
import 'package:todo_app/data/models/todo_entry_model.dart';

class MemoryLocalDataSource implements ToDoLocalDataSourceInterface {
  final List<ToDoCollectionModel> toDoCollections = [];
  final Map<String, List<ToDoEntryModel>> toDoEntries = {};

  @override
  Future<bool> createToDoCollection({required ToDoCollectionModel collection}) {
    try {
      toDoCollections.add(collection);
      toDoEntries.putIfAbsent(collection.id, () => []);

      return Future.value(true);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> createToDoEntry(
      {required collectionId, required ToDoEntryModel entry}) {
    try {
      final doesCollectionExist = toDoEntries.containsKey(collectionId);

      if (doesCollectionExist) {
        toDoEntries[collectionId]?.add(entry);
        return Future.value(true);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection(
      {required String collectionId}) {
    try {
      final collectionModel = toDoCollections.firstWhere(
        (element) => element.id == collectionId,
        orElse: () => throw CollectionNotFoundException(),
      );

      return Future.value(collectionModel);
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoCollectionIds() {
    try {
      return Future.value(
        toDoCollections.map((collection) => collection.id).toList(),
      );
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> getToDoEntry(
      {required String collectionId, required String entryId}) {
    try {
      if (toDoEntries.containsKey(collectionId)) {
        final entry = toDoEntries[collectionId]?.firstWhere(
          (entry) => entry.id == entryId,
          orElse: () => throw EntryNotFoundException(),
        );

        return Future.value(entry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> getToDoEntryIds({required String collectionId}) {
    try {
      if (toDoEntries.containsKey(collectionId)) {
        return Future.value(
          toDoEntries[collectionId]
              ?.map((collection) => collection.id)
              .toList(),
        );
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry(
      {required String collectionId, required String entryId}) {
    try {
      if (toDoEntries.containsKey(collectionId)) {
        final indexOfElement = toDoEntries[collectionId]?.indexWhere(
          (element) => element.id == entryId,
        );

        if (indexOfElement == -1 || indexOfElement == null) {
          throw EntryNotFoundException();
        }

        final entryToUpdate = toDoEntries[collectionId]?[indexOfElement];
        if (entryToUpdate == null) {
          throw EntryNotFoundException();
        }
        final updatedEntry = ToDoEntryModel(
          description: entryToUpdate.description,
          id: entryToUpdate.id,
          isDone: !entryToUpdate.isDone,
        );

        return Future.value(updatedEntry);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }

  @override
  Future<bool> deleteToDoCollection({required String collectionId}) {
    try {
      if (toDoEntries.containsKey(collectionId)) {
        final collectionToDelete = toDoCollections.firstWhere(
          (element) => element.id == collectionId,
        );

        toDoEntries[collectionId] = [];
        toDoCollections.remove(collectionToDelete);

        return Future.value(true);
      } else {
        throw CollectionNotFoundException();
      }
    } on Exception catch (_) {
      throw CacheException();
    }
  }
}
