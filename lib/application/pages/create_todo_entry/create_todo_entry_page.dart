import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_app/domain/entities/unique_id.dart';
import 'package:todo_app/domain/repositories/todo_repository.dart';
import 'package:todo_app/domain/use_cases/create_todo_entry.dart';
import 'package:todo_app/application/core/form_value.dart';
import 'package:todo_app/application/core/page_config.dart';
import 'package:todo_app/application/pages/create_todo_entry/bloc/cubit/create_todo_entry_page_cubit.dart';

typedef ToDoEntryItemAddedCallback = Function();

class CreateToDoEntryPageExtra {
  const CreateToDoEntryPageExtra({
    required this.collectionId,
    required this.toDoEntryItemAddedCallback,
  });

  final CollectionId collectionId;
  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;
}

class CreateToDoEntryPageProvider extends StatelessWidget {
  const CreateToDoEntryPageProvider({
    super.key,
    required this.collectionId,
    required this.toDoEntryItemAddedCallback,
  });

  final CollectionId collectionId;
  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CreateToDoEntryPageCubit>(
      create: (context) => CreateToDoEntryPageCubit(
        collectionId: collectionId,
        createToDoEntry: CreateToDoEntry(
          toDoRepository: RepositoryProvider.of<ToDoRepository>(context),
        ),
      ),
      child: CreateToDoEntryPage(
        toDoEntryItemAddedCallback: toDoEntryItemAddedCallback,
      ),
    );
  }
}

class CreateToDoEntryPage extends StatefulWidget {
  const CreateToDoEntryPage({
    super.key,
    required this.toDoEntryItemAddedCallback,
  });

  final ToDoEntryItemAddedCallback toDoEntryItemAddedCallback;

  static const pageConfig = PageConfig(
    icon: Icons.task_alt_rounded,
    name: 'create_todo_entry',
    child: Placeholder(),
  );

  @override
  State<CreateToDoEntryPage> createState() => _CreateToDoEntryPageState();
}

class _CreateToDoEntryPageState extends State<CreateToDoEntryPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
              onChanged: (value) => context
                  .read<CreateToDoEntryPageCubit>()
                  .descriptionChanged(value),
              validator: (value) {
                final currentValidationState = context
                        .read<CreateToDoEntryPageCubit>()
                        .state
                        .description
                        ?.validationStatus ??
                    ValidationStatus.pending;

                switch (currentValidationState) {
                  case ValidationStatus.error:
                    return 'This field needs at least two characters to be valid';
                  case ValidationStatus.success:
                  case ValidationStatus.pending:
                    return null;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                final isValid = _formKey.currentState?.validate();

                if (isValid == true) {
                  context.read<CreateToDoEntryPageCubit>().submit();
                  widget.toDoEntryItemAddedCallback.call();
                  context.pop();
                }
              },
              child: const Text('Save Entry'),
            )
          ],
        ),
      ),
    );
  }
}
