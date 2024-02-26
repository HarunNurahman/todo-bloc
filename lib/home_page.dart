import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:todo_bloc/widgets/input_widget.dart';
import 'package:d_info/d_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    context.read<TodoBloc>().add(OnFetchTodo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.init) {
            return const SizedBox.shrink();
          }
          if (state.status == TodoStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          List<TodoModel> list = state.todos;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              TodoModel todoModel = list[index];
              return ListTile(
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    switch (value) {
                      case 'update':
                        updateTodo(index, todoModel);
                        break;
                      case 'delete':
                        removeTodo(index);
                        break;
                      default:
                        DInfo.snackBarError(context, 'Not Implemented');
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'update',
                      child: Text('Update'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
                leading: CircleAvatar(child: Text('${index + 1}.')),
                title: Text(todoModel.title),
                subtitle: Text(todoModel.description),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  addTodo() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Add To-Do'),
          children: [
            InputWidget(
              title: titleController,
              description: descriptionController,
              onTap: () {
                TodoModel addTodo = TodoModel(
                  titleController.text,
                  descriptionController.text,
                );
                context.read<TodoBloc>().add(OnAddTodo(addTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(
                  context,
                  'To-Do List Added',
                );
              },
              actionTitle: 'Add To-Do List',
            )
          ],
        );
      },
    );
  }

  updateTodo(int index, TodoModel oldTodo) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    titleController.text = oldTodo.title;
    descriptionController.text = oldTodo.description;
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Update To-Do'),
          children: [
            InputWidget(
              title: titleController,
              description: descriptionController,
              onTap: () {
                TodoModel updateTodo = TodoModel(
                  titleController.text,
                  descriptionController.text,
                );
                context.read<TodoBloc>().add(OnUpdateTodo(index, updateTodo));
                Navigator.pop(context);
                DInfo.snackBarSuccess(
                  context,
                  'To-Do Updated',
                );
              },
              actionTitle: 'Update To-Do',
            )
          ],
        );
      },
    );
  }

  removeTodo(int index) {
    DInfo.dialogConfirmation(context, 'Remove To-Do', 'Are you sure?').then(
      (bool? yes) {
        if (yes ?? false) {
          context.read<TodoBloc>().add(OnRemoveTodo(index));
          DInfo.snackBarError(context, 'To-Do Removed');
        }
      },
    );
  }
}
