part of 'todo_form_cubit.dart';

class TodoFormState extends Equatable {
  final String todoTitle;

  const TodoFormState({required this.todoTitle});

  @override
  List<Object> get props => [todoTitle];

  factory TodoFormState.initial() {
    return const TodoFormState(todoTitle: '');
  }

  TodoFormState copyWith({String? todoTitle}) {
    return TodoFormState(
      todoTitle: todoTitle ?? this.todoTitle,
    );
  }
}
