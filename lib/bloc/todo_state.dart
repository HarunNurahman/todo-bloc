part of 'todo_bloc.dart';

sealed class TodoState {
  final List<TodoModel> todos;

  TodoState(this.todos);
}

final class TodoInitial extends TodoState {
  TodoInitial(super.todos);
}

final class TodoAdded extends TodoState {
  TodoAdded(super.todos);
}

final class TodoRemoved extends TodoState {
  TodoRemoved(super.todos);
}

final class TodoUpdated extends TodoState {
  TodoUpdated(super.todos);
}
