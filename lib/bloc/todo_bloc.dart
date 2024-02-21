import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial(const [])) {
    on<OnAddTodo>((event, emit) {
      TodoModel newTodo = event.newTodo;

      List<TodoModel> oldTodo = state.todos;
      oldTodo.add(newTodo);

      emit(TodoAdded([...state.todos, newTodo]));
    });

    on<OnUpdateTodo>((event, emit) {
      TodoModel newTodo = event.newTodo;
      int index = event.index;

      List<TodoModel> updateTodo = state.todos;
      updateTodo[index] = newTodo;

      emit(TodoUpdated(updateTodo));
    });

    on<OnRemoveTodo>((event, emit) {
      int index = event.index;

      List<TodoModel> removeTodo = state.todos;
      removeTodo.removeAt(index);

      emit(TodoRemoved(removeTodo));
    });
  }
}
