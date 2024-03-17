import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_loaded.dart';
import 'package:todo_app/domain/entities/todo_collection.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

void main() {
  Widget widgetUnderTest({required List<ToDoCollection> collections}) {
    return const MaterialApp(
        home: Scaffold(body: ToDoOverviewLoaded(collections: [])));
  }

  group('ToDoOverviewLoadedState test:', () {
    late List<ToDoCollection> collections;
    setUp(() {
      collections = [
        ToDoCollection(
          id: CollectionId.fromUniqueString(1.toString()),
          title: 'ToDoOverviewLoaded test',
          todoColor: const ToDoColor(
            colorIndex: 1,
          ),
        ),
      ];
    });

    testWidgets('Should rendered correctly', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest(collections: collections));
      await widgetTester.pumpAndSettle();
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(collections.length));
      expect(find.text(collections[0].title), findsOneWidget);
    });
  });
}
