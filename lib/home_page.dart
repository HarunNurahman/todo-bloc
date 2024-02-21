import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_bloc/bloc/todo_bloc.dart';
import 'package:todo_bloc/models/todo_model.dart';
import 'package:todo_bloc/widgets/input_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  TodoModel todoModel = TodoModel(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  context.read<TodoBloc>().add(OnAddTodo(todoModel));
                },
                actionTitle: 'Add To-Do List',
              )
            ],
          );
        });
  }

  updateTodo() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          List<TodoModel> list = state.todos;
          return Container(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                TodoModel todoModel = list[index];
                return ListTile(
                  leading: CircleAvatar(child: Text('${index + 1}.')),
                  title: Text(todoModel.title!),
                  subtitle: Text(todoModel.description!),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }
}
