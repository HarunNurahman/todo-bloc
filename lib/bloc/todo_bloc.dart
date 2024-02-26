import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState([], TodoStatus.init)) {
    // Add To-Do
    on<OnAddTodo>((event, emit) async {
      TodoModel newTodo = event.newTodo;
      emit(TodoState([...state.todos, newTodo], TodoStatus.success));
    });

    // Update To-Do
    on<OnUpdateTodo>((event, emit) async {
      TodoModel newTodo = event.newTodo;
      int index = event.index;

      List<TodoModel> updateTodo = state.todos;
      updateTodo[index] = newTodo;

      emit(TodoState(updateTodo, TodoStatus.success));
    });

    // Remove To-Do
    on<OnRemoveTodo>((event, emit) async {
      int index = event.index;

      List<TodoModel> removeTodo = state.todos;
      removeTodo.removeAt(index);

      emit(TodoState(removeTodo, TodoStatus.success));
    });

    // Fetching data
    on<OnFetchTodo>((event, emit) async {
      emit(TodoState(state.todos, TodoStatus.loading));
      await Future.delayed(const Duration(seconds: 1));
      emit(TodoState([TodoModel('title', 'description')], TodoStatus.success));
    });
  }

  @override
  void onChange(Change<TodoState> change) {
    DMethod.logTitle(
      change.currentState.status.toString(),
      change.nextState.status.toString(),
    );
    super.onChange(change);
  }

  @override
  void onEvent(TodoEvent event) {
    DMethod.log(event.toString());
    super.onEvent(event);
  }
}
