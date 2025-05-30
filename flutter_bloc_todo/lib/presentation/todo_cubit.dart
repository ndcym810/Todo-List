import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_todo/domain/models/todo.dart';
import 'package:flutter_bloc_todo/domain/repository/todo_repo.dart';

class TodoCubit extends Cubit<List<Todo>> {
  final TodoRepo todoRepo;

  TodoCubit(this.todoRepo) : super([]) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todoList = await todoRepo.getTodos();

    emit(todoList);
  }

  Future<void> addTodo(String body) async {
    final newTodo = Todo(body: body, id: 0);

    await todoRepo.addTodo(newTodo);

    loadTodos();
  }

  Future<void> deleteTodo(Todo todo) async {
    await todoRepo.deleteTodo(todo);

    loadTodos();
  }

  Future<void> toggleCompletion(Todo todo) async {
    final updateTodo = todo.toggleCompletion();

    await todoRepo.updateTodo(updateTodo);

    loadTodos();
  }
}
