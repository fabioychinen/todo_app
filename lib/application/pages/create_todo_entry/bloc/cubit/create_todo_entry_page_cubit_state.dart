part of 'create_todo_entry_page_cubit.dart';

class CreateToDoEntryPageCubitState extends Equatable {
  const CreateToDoEntryPageCubitState({this.description});

  final FormValue<String?>? description;

  CreateToDoEntryPageCubitState copyWith({FormValue<String?>? description}) {
    return CreateToDoEntryPageCubitState(
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        description,
      ];
}
