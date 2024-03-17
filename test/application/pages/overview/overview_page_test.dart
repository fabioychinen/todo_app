import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/application/pages/overview/bloc/cubit/todo_overview_cubit.dart';
import 'package:todo_app/application/pages/overview/overview_page.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

class MockToDoOverviewCubit extends MockCubit<ToDoOverviewCubitState>
    implements ToDoOverviewCubit {}

void main() {
  Widget widgetUnderTest({required ToDoOverviewCubit cubit}) {
    return MaterialApp(
      home: BlocProvider<ToDoOverviewCubit>(
        create: (context) => cubit..readToDoOverviewCollections(),
        child: const Scaffold(body: OverviewPage()),
      ),
    );
  }

  group('OverviewPage tests:', () {
    late MockToDoOverviewCubit mockToDoOverviewCubit;

    setUp(() => mockToDoOverviewCubit = MockToDoOverviewCubit());

    group('Should displayed view state', () {
      testWidgets(
        'Loading when cubit emits ToDo Overview Cubit LoadingState',
        (widgetTester) async {
          whenListen(
            mockToDoOverviewCubit,
            Stream.fromIterable([ToDoOverviewCubitLoadingState()]),
            initialState: ToDoOverviewCubitLoadingState(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));

          expect(find.byType(ToDoOverviewCubitLoadingState), findsOneWidget);
        },
      );

      testWidgets(
        'Loaded when cubit emits ToDo Overview Cubit Loaded State',
        (widgetTester) async {
          // ignore: unused_local_variable
          final collections = [
            ToDoCollection(
              id: CollectionId.fromUniqueString(1.toString()),
              title: 'Overview test',
              todoColor: const ToDoColor(
                colorIndex: 1,
              ),
            ),
          ];

          whenListen(
            mockToDoOverviewCubit,
            Stream.fromIterable(
                [ToDoOverviewCubitLoadedState(collections: const [])]),
            initialState: ToDoOverviewCubitLoadingState(),
          );

          await widgetTester
              .pumpWidget(widgetUnderTest(cubit: mockToDoOverviewCubit));
          await widgetTester.pumpAndSettle();

          expect(find.byType(ToDoOverviewCubitLoadingState), findsNothing);
          expect(find.byType(ToDoOverviewCubitLoadedState), findsOneWidget);
          expect(find.text('ToDo Overview test'), findsOneWidget);
        },
      );
    });
  });
}
