import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/domain/entities/todo_entry.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/application/core/form_value.dart';
import 'package:todo_app/core/use_case.dart';

part 'create_todo_entry_page_cubit_state.dart';

class CreateToDoEntryPageCubit extends Cubit<CreateToDoEntryPageCubitState> {
  CreateToDoEntryPageCubit({
    required this.createToDoEntry,
    required this.collectionId,
  }) : super(const CreateToDoEntryPageCubitState());

  final CreateToDoEntry createToDoEntry;
  final CollectionId collectionId;

  void descriptionChanged(String? description) {
    ValidationStatus currentStatus = ValidationStatus.pending;

    // ignore: prefer_is_empty
    if (description == null || description.isEmpty || description.length < 1) {
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

  Future<void> submit() async {
    await createToDoEntry.call(
      ToDoEntryParams(
        entry: ToDoEntry.empty().copyWith(
          description: state.description?.value,
        ),
        collectionId: collectionId,
      ),
    );
  }
}
