/*

To implement the todo repo and handles storing, retrieving, updating,
deleting in the isar database

*/

import 'package:flutter_bloc_todo/data/models/isar_todo.dart';
import 'package:flutter_bloc_todo/domain/models/todo.dart';
import 'package:flutter_bloc_todo/domain/repository/todo_repo.dart';
import 'package:isar/isar.dart';

class IsarTodoRepo implements TodoRepo {
  // database
  final Isar db;

  IsarTodoRepo(this.db);

  // get todos
  @override
  Future<List<Todo>> getTodos() async {
    // fetch from the db
    final todos = await db.todoIsars.where().findAll();

    // return as a list of todos and give to domain layer
    return todos.map((todoIsar) => todoIsar.toDomain()).toList();
  }

  // add todo
  @override
  Future<void> addTodo(Todo newTodo) async {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(newTodo);

    // store isar todo to db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // update todo
  @override
  Future<void> updateTodo(Todo todo) async {
    // convert todo into isar todo
    final todoIsar = TodoIsar.fromDomain(todo);

    // store isar todo to db
    return db.writeTxn(() => db.todoIsars.put(todoIsar));
  }

  // delete todo
  @override
  Future<void> deleteTodo(Todo todo) async {
    await db.writeTxn(() => db.todoIsars.delete(todo.id));
  }
}
