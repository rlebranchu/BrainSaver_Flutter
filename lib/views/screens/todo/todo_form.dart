import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/schedule/cubit/schedule_form_cubit.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

class _TitleInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoFormCubit, TodoFormState>(
      buildWhen: (previous, current) => previous.todoTitle != current.todoTitle,
      builder: (context, state) {
        return TextFieldApp(
            label: 'Name of appointment',
            initialValue: state.todoTitle,
            onChange: (appointmentName) =>
                context.read<TodoFormCubit>().todoTitleChanged(appointmentName),
            textAlign: TextAlign.center);
      },
    );
  }
}

class _SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<TodoFormCubit, TodoFormState>(
      buildWhen: (previous, current) => previous.todoTitle != current.todoTitle,
      builder: (context, state) {
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
