import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/todo_color.dart';
import 'package:todo_app/domain/entities/unique_id.dart';

class ToDoCollection extends Equatable {
  const ToDoCollection({
    required this.id,
    required this.title,
    required this.todoColor,
  });

  factory ToDoCollection.empty() {
    return ToDoCollection(
      id: CollectionId(),
      title: 'Empty collection',
      todoColor: const ToDoColor(
        colorIndex: 0,
      ),
    );
  }

  final CollectionId id;
  final String title;
  final ToDoColor todoColor;

  ToDoCollection copyWith({String? title, ToDoColor? todoColor}) {
    return ToDoCollection(
      id: id,
      title: title ?? this.title,
      todoColor: todoColor ?? this.todoColor,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        todoColor,
      ];
}
