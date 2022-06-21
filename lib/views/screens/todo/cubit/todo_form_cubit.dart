import 'package:bloc/bloc.dart';
import 'package:brain_saver_flutter/repositories/repositories.dart';
import 'package:equatable/equatable.dart';

part 'todo_form_state.dart';

class TodoFormCubit extends Cubit<TodoFormState> {
  final TodoRepository _todoRepository;

  TodoFormCubit(this._todoRepository) : super(TodoFormState.initial());

  // Reset values of state -> re-initalize state
  void resetForm() {
    emit(TodoFormState.initial());
  }

  // New state : with new value of title of todo
  void todoTitleChanged(String title) {
    emit(state.copyWith(todoTitle: title));
  }

  // Save new Todo in Firestore
  void saveTodo(String userId) {
    _todoRepository.saveTodo(userId, state.todoTitle);
    resetForm();
  }
}
