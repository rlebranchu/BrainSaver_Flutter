import 'package:brain_saver_flutter/models/models.dart';
import 'package:brain_saver_flutter/services/services.dart';
import 'package:brain_saver_flutter/views/screens/todo/cubit/todo_cubit.dart';

class TodoRepository {
  final TodoService _todoService = TodoService();

  Future<List<Todo>> fetchListTodoOfUser(
      String userId, ListTodoStatus status) async {
    return await _todoService.fetchListTodoOfUser(userId, status);
  }

  Future<void> saveTodo(String userId, String todoTitle) async {
    await _todoService.saveTodo(userId, todoTitle);
  }

  Future<void> completeTodo(String todoId, bool complete) async {
    await _todoService.completeTodo(todoId, complete);
  }

  Future<void> deleteTodo(Todo todo) async {
    await _todoService.deleteTodo(todo);
  }
}
