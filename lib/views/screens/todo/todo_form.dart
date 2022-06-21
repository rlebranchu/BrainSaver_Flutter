import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Form to create a new Todo to user logged
class TodoForm extends StatelessWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Container of Title Input and Save Button
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _TitleInput(),
        const SizedBox(height: 13),
        _SaveButton(),
      ],
    );
  }
}

// Title Input
class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoFormCubit, TodoFormState>(
      // Refresh only if Event's title of state has changed
      buildWhen: (previous, current) => previous.todoTitle != current.todoTitle,
      builder: (context, state) {
        return TextFieldApp(
            label: 'Name of Todo',
            initialValue: state.todoTitle,
            onChange: (todoName) =>
                context.read<TodoFormCubit>().todoTitleChanged(todoName),
            textAlign: TextAlign.center);
      },
    );
  }
}

// Save Buttons
class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the user logged and store in AppState
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<TodoFormCubit, TodoFormState>(
      // Refresh only if Event's title of state has changed
      buildWhen: (previous, current) => previous.todoTitle != current.todoTitle,
      builder: (context, state) {
        // Show Save Button only if todo's title is not empty
        return state.todoTitle.isEmpty
            ? Container()
            : ElevatedButtonValidation(
                child: const Text('Save Todo', style: TextStyle(fontSize: 15)),
                onPressed: () => {
                  context.read<TodoFormCubit>().saveTodo(user.id),
                  Navigator.pop(context)
                },
              );
      },
    );
  }
}
