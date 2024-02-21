part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class OnAddTodo extends TodoEvent {
  final TodoModel newTodo;

  OnAddTodo(this.newTodo);
}

class OnRemoveTodo extends TodoEvent {
  final int index;

  OnRemoveTodo(this.index);
}

class OnUpdateTodo extends TodoEvent {
  final int index;
  final TodoModel newTodo;

  OnUpdateTodo(this.index, this.newTodo);
}
