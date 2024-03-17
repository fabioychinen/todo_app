part of 'create_todo_collection_page_cubit.dart';

@immutable
class CreateToDoCollectionPageCubitState extends Equatable {
  const CreateToDoCollectionPageCubitState({this.title, this.color});

  final String? title;
  final Color? color;

  CreateToDoCollectionPageCubitState copyWith({
    String? title,
    Color? color,
  }) {
    return CreateToDoCollectionPageCubitState(
      color: color ?? this.color,
      title: title ?? this.title,
    );
  }

  @override
  List<Object?> get props => [
        title,
        color,
      ];
}

class CreateToDoCollectionPageCubitInitial
    extends CreateToDoCollectionPageCubitState {}
