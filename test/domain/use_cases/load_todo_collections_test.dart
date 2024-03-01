import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/load_todo_collections.dart';

class ToDoRepositoryMock extends Mock implements ToDoRepository {}

void main() {
  final toDoRepository = ToDoRepositoryMock();

  group('ToDoUseCase test:', () {
    final toDoUseCaseUnderTest =
        LoadToDoCollections(toDoRepository: toDoRepository);

    group('Should return ToDoCollection', () {
      test('when ToDoRepository returns ToDoModel', () async {
        final dummyData = Right<Failure, List<ToDoCollection>>(List.generate(
          5,
          (index) => ToDoCollection(
            id: CollectionId.fromUniqueString('id $index'),
            title: 'title $index',
            color: ToDoColor(
              colorIndex: index % ToDoColor.predefinedColors.length,
            ),
          ),
        ));

        when(() => toDoRepository.readToDoCollections())
            .thenAnswer((_) => Future.value(dummyData));

        final result = await toDoUseCaseUnderTest(NoParams());
        expect(result.isLeft, false);
        expect(result.isRight, true);
        expect(result, dummyData);
        verify(() => toDoRepository.readToDoCollections()).called(1);
        verifyNoMoreInteractions(toDoRepository);
      });
    });
    group('Should return Failure', () {
      test('when TodoRepository returns Failure', () async {
        final dummyData = Left<Failure, List<ToDoCollection>>(ServerFailure());

        when(() => toDoRepository.readToDoCollections())
            .thenAnswer((realInvocation) => Future.value(dummyData));

        final result = await toDoUseCaseUnderTest.call(NoParams());

        expect(result.isLeft, true);
        expect(result.isRight, false);
        expect(result, dummyData);
        verify(() => toDoRepository.readToDoCollections()).called(1);
        verifyNoMoreInteractions(toDoRepository);
      });
    });
  });
}
