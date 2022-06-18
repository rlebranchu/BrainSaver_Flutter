import 'package:brain_saver_flutter/blocs/app/app_bloc.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:brain_saver_flutter/views/components/components.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_cubit.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_form_cubit.dart';
import 'package:brain_saver_flutter/views/screens/todo/todo_form.dart';
import 'package:brain_saver_flutter/views/theme/style_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final TodoRepository _todoRepository = TodoRepository();

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BlocProvider(
          create: (_) => TodoCubit(_todoRepository, user.id),
          child: Column(
            children: [
              _TodoFilter(),
              const SizedBox(height: 20),
              _ListTodo(),
              const SizedBox(height: 20),
              _AddTodoButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _TodoFilter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _AllFilterButton(),
        _WaitingFilterButton(),
        _DoneFilterButton(),
      ],
    );
  }
}

class _AllFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is TodoLoaded) {
          return ElevatedButton(
            onPressed: () => context
                .read<TodoCubit>()
                .changeStatus(user.id, ListTodoStatus.all),
            child: Text(
              'All',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
                color: state.status == ListTodoStatus.all
                    ? Colors.white
                    : PRIMARYCOLOR,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: state.status == ListTodoStatus.all
                  ? PRIMARYCOLOR
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BORDERRADIUS),
              ),
              textStyle: const TextStyle(fontFamily: 'Montserrat'),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _WaitingFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is TodoLoaded) {
          return ElevatedButton(
            onPressed: () => context
                .read<TodoCubit>()
                .changeStatus(user.id, ListTodoStatus.waiting),
            child: Text(
              'Waiting',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
                color: state.status == ListTodoStatus.waiting
                    ? Colors.white
                    : PRIMARYCOLOR,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: state.status == ListTodoStatus.waiting
                  ? PRIMARYCOLOR
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BORDERRADIUS),
              ),
              textStyle: const TextStyle(fontFamily: 'Montserrat'),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _DoneFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is TodoLoaded) {
          return ElevatedButton(
            onPressed: () => context
                .read<TodoCubit>()
                .changeStatus(user.id, ListTodoStatus.done),
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Montserrat',
                color: state.status == ListTodoStatus.done
                    ? Colors.white
                    : PRIMARYCOLOR,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: state.status == ListTodoStatus.done
                  ? PRIMARYCOLOR
                  : Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(BORDERRADIUS),
              ),
              textStyle: const TextStyle(fontFamily: 'Montserrat'),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _ListTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is TodoLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: PRIMARYCOLOR,
            ),
          );
        } else if (state is TodoLoaded) {
          return Expanded(child: _ListViewTodo());
        }
        return Container();
      },
    );
  }
}

class _ListViewTodo extends StatelessWidget {
  Widget backgroundDismissDelete(MainAxisAlignment axis) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(
          color: Colors.red,
        ),
        borderRadius: BorderRadius.circular(BORDERRADIUS),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          mainAxisAlignment: axis,
          children: const [
            Text('Delete the todo', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is TodoLoaded) {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 15);
            },
            itemCount: state.todos.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              final todo = state.todos[i];
              return Dismissible(
                key: Key(todo.id),
                onDismissed: (direction) {
                  context.read<TodoCubit>().deleteTodo(user.id, todo);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Todo ${todo.title} deleted')));
                },
                // Show a red background as the item is swiped away.
                background: backgroundDismissDelete(MainAxisAlignment.start),
                secondaryBackground:
                    backgroundDismissDelete(MainAxisAlignment.end),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.4, 1.4),
                        blurRadius: 10.0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(BORDERRADIUS),
                    color: Colors.white,
                  ),
                  child: CheckboxListTile(
                    title: Text(todo.title.toString()),
                    value: todo.complete,
                    onChanged: (checked) {
                      context
                          .read<TodoCubit>()
                          .completeTodo(user.id, todo.id, checked!);
                    },
                    activeColor: PRIMARYCOLOR,
                    checkColor: Colors.white,
                    checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

class _AddTodoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButtonValidation(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (_) {
              return _AddTodoFormModal();
            },
            isScrollControlled: true,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(BORDERRADIUS),
                  topRight: Radius.circular(BORDERRADIUS)),
            ),
          ).then((value) =>
              context.read<TodoCubit>().fetchListTodoOfUser(user.id));
        },
        child: const Text('Add Todo', style: TextStyle(fontSize: 15)),
      ),
    );
  }
}

class _AddTodoFormModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TodoFormCubit(_todoRepository),
      child: SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: TodoForm(),
        ),
      ),
    );
  }
}
