part of 'todo_cubit.dart';

enum ListTodoStatus { all, done, waiting }

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {
  @override
  String toString() => 'TodosLoading';
}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final ListTodoStatus status;

  const TodoLoaded({required this.todos, this.status = ListTodoStatus.all});

  @override
  List<Object> get props => [todos, status];

  factory TodoLoaded.initial() {
    return const TodoLoaded(todos: <Todo>[], status: ListTodoStatus.all);
  }

  TodoLoaded copyWith({List<Todo>? todos, ListTodoStatus? status}) {
    return TodoLoaded(
      todos: todos ?? this.todos,
      status: status ?? this.status,
    );
  }
}

class TodoNotLoaded extends TodoState {}
