import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/application/pages/overview/view_states/todo_overview_loading.dart';

void main() {
  Widget widgetUnderTest() {
    return const MaterialApp(
      home: Scaffold(
        body: ToDoOverviewLoading(),
      ),
    );
  }

  group('ToDoOverviewLoadingState test:', () {
    testWidgets('Should rendered correctly', (widgetTester) async {
      await widgetTester.pumpWidget(widgetUnderTest());
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
