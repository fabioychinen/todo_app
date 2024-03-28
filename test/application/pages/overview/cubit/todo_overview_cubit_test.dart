import 'package:bloc_test/bloc_test.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:todo_app/application/pages/overview/bloc/cubit/todo_overview_cubit.dart';
import 'package:todo_app/core/use_case.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/failures/failures.dart';
import 'package:todo_app/domain/use_cases/load_todo_collections.dart';

class MockLoadToDoCollections extends Mock implements LoadToDoCollections {}

void main() {
  group('ToDoOverviewCubit Test:', () {
    final mockLoadToDoCollections = MockLoadToDoCollections();
    final expectedValue = Right<Failure, List<ToDoCollection>>([
      ToDoCollection(
        id: CollectionId.fromUniqueString("1"),
        title: 'bloc test',
        color: ToDoColor(colorIndex: 1),
      ),
    ]);

    final expectedFailure =
        Left<Failure, List<ToDoCollection>>(ServerFailure());

    blocTest<ToDoOverviewCubit, ToDoOverviewCubitState>(
      'emits [ToDoOverviewCubitLoadingState, ToDoOverviewCubitLoadedState] when ToDoOverview is called.',
      setUp: () {
        when(() => mockLoadToDoCollections(NoParams()))
            .thenAnswer((_) => Future.value(expectedValue));
      },
      build: () => ToDoOverviewCubit(
        loadToDoCollections: mockLoadToDoCollections,
      ),
      act: (ToDoOverviewCubit bloc) => bloc.readToDoCollections(),
      expect: () => <ToDoOverviewCubitState>[
        const ToDoOverviewCubitLoadingState(),
        ToDoOverviewCubitLoadedState(
            collections:
                expectedValue.fold((_) => [], (collections) => collections))
      ],
    );

    blocTest<ToDoOverviewCubit, ToDoOverviewCubitState>(
      'emits [ToDoOverviewCubitLoadingState, ToDoOverviewCubitErrorState] when TodoUseCase is called and error occurred.',
      setUp: () {
        when(() => mockLoadToDoCollections(NoParams()))
            .thenAnswer((_) => Future.value(expectedFailure));
      },
      build: () => ToDoOverviewCubit(
        loadToDoCollections: mockLoadToDoCollections,
      ),
      act: (ToDoOverviewCubit bloc) => bloc.readToDoCollections(),
      expect: () => <ToDoOverviewCubitState>[
        const ToDoOverviewCubitLoadingState(),
        const ToDoOverviewCubitErrorState()
      ],
    );
  });
}
