import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/todo_model.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _todoRepository;

  TodoCubit(this._todoRepository, String userId) : super(TodoLoading()) {
    // At opening of Todo Screen, we fetch automatically the list of todos of user logged
    fetchListTodoOfUser(userId);
  }

  // Ask to service to fetch all todos of user logged
  void fetchListTodoOfUser(String userId) async {
    ListTodoStatus status =
        state is TodoLoaded ? (state as TodoLoaded).status : ListTodoStatus.all;
    List<Todo> list = await _todoRepository.fetchListTodoOfUser(userId, status);
    emit(TodoLoaded(todos: list, status: status));
  }

  // New state: with the new value of status of filter
  void changeStatus(String userId, ListTodoStatus status) async {
    if (state is TodoLoaded) {
      emit((state as TodoLoaded).copyWith(status: status));
      // get new list of todos
      fetchListTodoOfUser(userId);
    }
  }

  // New state: with the new value of completion of todo
  void completeTodo(String userId, String todoId, bool complete) async {
    await _todoRepository.completeTodo(todoId, complete);
    // get new list of todos
    fetchListTodoOfUser(userId);
  }

  // Delete specific todo
  void deleteTodo(String userId, Todo todo) async {
    await _todoRepository.deleteTodo(todo);
    fetchListTodoOfUser(userId);
  }
}
