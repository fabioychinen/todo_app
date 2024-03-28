import 'package:either_dart/either.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class UpdateToDoEntry implements UseCase<ToDoEntry, ToDoEntryParams> {
  const UpdateToDoEntry({required this.toDoRepository});

  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, ToDoEntry>> call(ToDoEntryParams params) async {
    try {
      final loadedEntry = await toDoRepository.updateToDoEntry(
        collectionId: params.collectionId,
        entry: params.entry,
      );
      return loadedEntry.fold(
        (left) => Left(left),
        (right) => Right(right),
      );
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
