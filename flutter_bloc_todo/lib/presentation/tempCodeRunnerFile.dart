   // final todoCubit = context.read<TodoCubit>();

    // return Scaffold(
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () => _showAddTodoBox(context),
    //     child: const Icon(Icons.add),
    //   ),
    //   body: BlocBuilder<TodoCubit, List<Todo>>(
    //     builder: (context, todos) {
    //       return ListView.builder(
    //         itemCount: todos.length,
    //         itemBuilder: (context, index) {
    //           // get individual todo from todo list
    //           final todo = todos[index];

    //           // List Tile UI
    //           return ListTile(
    //             // body text
    //             title: Text(todo.body),
    //             // check box
    //             leading: Checkbox(
    //               value: todo.isCompleted,
    //               onChanged: (value) => todoCubit.toggleCompletion(todo),
    //             ),
    //             trailing: IconButton(
    //               onPressed: () => todoCubit.deleteTodo(todo),
    //               icon: const Icon(Icons.cancel),
    //             ),
    //           );
    //         },
    //       );
    //     },
    //   ),
    // );