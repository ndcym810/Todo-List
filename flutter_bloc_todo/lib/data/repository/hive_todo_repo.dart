import 'package:flutter_bloc_todo/data/models/hive_todo.dart';
import 'package:flutter_bloc_todo/domain/models/todo.dart';
import 'package:flutter_bloc_todo/domain/repository/todo_repo.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveTodoRepository implements TodoRepo {
  static const String boxName = 'todos';
  final Box<HiveTodo> _todoBox;

  HiveTodoRepository(this._todoBox);

  // Factory constructor to open the box
  static Future<HiveTodoRepository> create() async {
    final box = await Hive.openBox<HiveTodo>(boxName);
    return HiveTodoRepository(box);
  }

  @override
  Future<List<Todo>> getTodos() async {
    // Sort todos by ID for consistent order
    final List<HiveTodo> sortedTodos =
        _todoBox.values.toList()..sort((a, b) => a.id.compareTo(b.id));

    return sortedTodos.map((hiveTodo) => hiveTodo.toDomain()).toList();
  }

  @override
  Future<void> addTodo(Todo newTodo) async {
    // Generate new ID if needed
    final todo =
        newTodo.id == 0
            ? Todo(
              id: _getNextId(),
              body: newTodo.body,
              isCompleted: newTodo.isCompleted,
            )
            : newTodo;

    final hiveTodo = HiveTodo.fromDomain(todo);

    // Make sure to await this operation
    await _todoBox.put(hiveTodo.id, hiveTodo);

    // Print for debugging
    print(
      'Added todo with ID: ${hiveTodo.id}, total todos: ${_todoBox.length}',
    );
    _printAllTodos();
  }

  @override
  Future<void> updateTodo(Todo todo) async {
    final hiveTodo = HiveTodo.fromDomain(todo);
    await _todoBox.put(hiveTodo.id, hiveTodo);

    // Print for debugging
    print('Updated todo with ID: ${hiveTodo.id}');
    _printAllTodos();
  }

  @override
  Future<void> deleteTodo(Todo todo) async {
    await _todoBox.delete(todo.id);

    // Print for debugging
    print(
      'Deleted todo with ID: ${todo.id}, remaining todos: ${_todoBox.length}',
    );
    _printAllTodos();
  }

  // Helper method to generate a new ID
  int _getNextId() {
    if (_todoBox.isEmpty) {
      return 1;
    }

    // Find the maximum ID and increment by 1
    final maxId = _todoBox.values
        .map((todo) => todo.id)
        .reduce((value, element) => value > element ? value : element);

    return maxId + 1;
  }

  // Debugging helper
  void _printAllTodos() {
    final todos = _todoBox.values
        .map((t) => 'ID: ${t.id}, Body: ${t.body}')
        .join('\n  ');
    print('All todos in box:\n  $todos');
  }

  // Add listener for box changes
  void addBoxListener(void Function() listener) {
    _todoBox.listenable().addListener(listener);
  }

  // Close the box when done
  Future<void> close() async {
    await _todoBox.close();
  }
}
