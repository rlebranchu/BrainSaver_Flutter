import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/models/todo_model.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository _todoRepository;

  TodoCubit(this._todoRepository, String userId) : super(TodoLoading()) {
    fetchListTodoOfUser(userId);
  }

  void fetchListTodoOfUser(String userId) async {
    ListTodoStatus status =
        state is TodoLoaded ? (state as TodoLoaded).status : ListTodoStatus.all;
    List<Todo> list = await _todoRepository.fetchListTodoOfUser(userId, status);
    emit(TodoLoaded(todos: list, status: status));
  }

  void changeStatus(String userId, ListTodoStatus status) async {
    if (state is TodoLoaded) {
      emit((state as TodoLoaded).copyWith(status: status));
      fetchListTodoOfUser(userId);
    }
  }

  void completeTodo(String userId, String todoId, bool complete) async {
    await _todoRepository.completeTodo(todoId, complete);
    fetchListTodoOfUser(userId);
  }

  void deleteTodo(String userId, Todo todo) async {
    await _todoRepository.deleteTodo(todo);
    fetchListTodoOfUser(userId);
  }
}
