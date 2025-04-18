/*

To Do View: responsible for UI

-use BlocBuilder

*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/domain/models/todo.dart';
import 'package:flutter_bloc_todo/presentation/todo_cubit.dart';

class TodoView extends StatelessWidget {
  const TodoView({super.key});

  // show dialog box for user to type
  void _showAddTodoBox(BuildContext context) {
    final textController = TextEditingController();
    // Capture the cubit from the current context before showing dialog
    final todoCubit = context.read<TodoCubit>();

    showDialog(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            content: TextField(controller: textController),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  // Use the captured cubit instead of trying to read from dialog context
                  todoCubit.addTodo(textController.text);
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _showAddTodoBox(context),
      ),
      body: BlocBuilder<TodoCubit, List<Todo>>(
        buildWhen: (previous, current) {
          // Always rebuild when the list changes
          return true;
        },
        builder: (context, todos) {
          if (todos.isEmpty) {
            return const Center(child: Text('No todos yet. Add one!'));
          }

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              // get individual todo from todo list
              final todo = todos[index];

              // List Tile UI
              return ListTile(
                // body text
                title: Text(todo.body),
                // check box
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged:
                      (value) =>
                          context.read<TodoCubit>().toggleCompletion(todo),
                ),
                trailing: IconButton(
                  onPressed: () => context.read<TodoCubit>().deleteTodo(todo),
                  icon: const Icon(Icons.cancel),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
