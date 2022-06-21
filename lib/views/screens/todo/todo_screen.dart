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

// Page which represents Todo App
class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the user logged and store in AppState
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    // GestureDetector to detect all click on background to hide keyboard
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

// Container of all filter's button
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

// Button All to show only done todos of logged user on Click
class _AllFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the user logged and store in AppState
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

// Button Done to show only waiting todos of logged user on Click
class _WaitingFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the user logged and store in AppState
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

// Button Done to show only done todos of logged user on Click
class _DoneFilterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the user logged and store in AppState
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

// List View to show all todos of Logged user for all filters : All, Waiting, Done
class _ListTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        // If loading state -> circular loading appears
        if (state is TodoLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: PRIMARYCOLOR,
            ),
          );
          // Else we show all todo of logged user
        } else if (state is TodoLoaded) {
          return Expanded(child: _ListViewTodo());
        }
        return Container();
      },
    );
  }
}

class _ListViewTodo extends StatelessWidget {
  // Function : return the delete background on todo's slide
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
    // Get the user logged and store in AppState
    final user = context.select((AppBloc appBloc) => appBloc.state.user);
    return BlocBuilder<TodoCubit, TodoState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        // In normal situation, we enter always in the if condition
        if (state is TodoLoaded) {
          return ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              // Space between each listView
              return const SizedBox(height: 15);
            },
            // How many item in todo's list
            itemCount: state.todos.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              final todo = state.todos[i];
              // Dismiss is use to delete todo : slide to right or left
              return Dismissible(
                key: Key(todo.id),
                onDismissed: (direction) {
                  // Left and right slide -> delete the slided todo
                  context.read<TodoCubit>().deleteTodo(user.id, todo);
                  //Show message to confirm todo suppression
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Todo ${todo.title} deleted')));
                },
                // Show a red background as the item is swiped away.
                background: backgroundDismissDelete(MainAxisAlignment.start),
                secondaryBackground:
                    backgroundDismissDelete(MainAxisAlignment.end),
                child: Container(
                  // Show shadow below each listView item
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
                  // Generation of ListView item like CheckBoxListTile (Title and Checkbox)
                  child: CheckboxListTile(
                    title: Text(todo.title.toString()),
                    value: todo.complete,
                    onChanged: (checked) {
                      // Call Completion Function of TodoCubit with new value of Checkbox
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
        // In normal situation, we always in TodoLoaded situation, so this Container is never used
        return Container();
      },
    );
  }
}

// The bottom button which open modal to show todo creation's form
class _AddTodoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the user logged and store in AppState
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
    // This creation of another cubit is necessary because showModalBottomSheet using new route
    return BlocProvider(
      create: (_) => TodoFormCubit(_todoRepository),
      child: SingleChildScrollView(
        padding: MediaQuery.of(context).viewInsets,
        child: const Padding(
          padding: EdgeInsets.all(20),
          // Show the form to create todo
          child: TodoForm(),
        ),
      ),
    );
  }
}
