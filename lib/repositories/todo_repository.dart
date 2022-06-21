import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/services/services.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_cubit.dart';

class TodoRepository {
  final TodoService _todoService = TodoService();

  // Ask to service to get list of todo of the user logged
  Future<List<Todo>> fetchListTodoOfUser(
      String userId, ListTodoStatus status) async {
    return await _todoService.fetchListTodoOfUser(userId, status);
  }

  // Ask to service to save a new todo
  Future<void> saveTodo(String userId, String todoTitle) async {
    await _todoService.saveTodo(userId, todoTitle);
  }

  // Ask to service to set completion of specific todo
  Future<void> completeTodo(String todoId, bool complete) async {
    await _todoService.completeTodo(todoId, complete);
  }

  // Ask to service to delete an existing todo item
  Future<void> deleteTodo(Todo todo) async {
    await _todoService.deleteTodo(todo);
  }
}
