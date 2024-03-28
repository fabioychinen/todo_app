import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/application/core/form_value.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_todo_entry_page_state.dart';

class CreateToDoEntryPageCubit extends Cubit<CreateToDoEntryPageState> {
  CreateToDoEntryPageCubit({
    required this.collectionId,
    required this.addToDoEntry,
  }) : super(const CreateToDoEntryPageState());

  final CollectionId collectionId;
  final CreateToDoEntry addToDoEntry;

  void descriptionChanged({String? description}) {
    ValidationStatus currentStatus = ValidationStatus.pending;

    if (description == null || description.isEmpty || description.length < 2) {
      currentStatus = ValidationStatus.error;
    } else {
      currentStatus = ValidationStatus.success;
    }
    emit(
      state.copyWith(
        description: FormValue(
          value: description,
          validationStatus: currentStatus,
        ),
      ),
    );
  }

  void submit() async {
    await addToDoEntry.call(
      ToDoEntryParams(
        collectionId: collectionId,
        entry: ToDoEntry.empty().copyWith(
          description: state.description?.value,
        ),
      ),
    );
  }
}
