import 'package:either_dart/either.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/core/use_case.dart';

class DeleteToDoCollection implements UseCase<bool, CollectionIdParams> {
  DeleteToDoCollection({required this.toDoRepository});

  final ToDoRepository toDoRepository;

  @override
  Future<Either<Failure, bool>> call(params) async {
    try {
      final result = toDoRepository.deleteToDoCollection(
        collectionId: params.collectionId,
      );

      return result.fold(
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
