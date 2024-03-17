import 'package:either_dart/either.dart';

import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';

import '../../core/use_case.dart';
import '../entities/todo_entry.dart';

class LoadToDoEntry implements UseCase<ToDoEntry, ToDoEntryIdsParams> {
  const LoadToDoEntry({
    required this.toDoRepository,
  });

  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryIdsParams params) async {
    try {
      final loadedEntry = toDoRepository.readToDoEntry(
        params.collectionId,
        params.entryId,
      );
      return loadedEntry.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(
        ServerFailure(
          stackTrace: e.toString(),
        ),
      );
    }
  }
}
