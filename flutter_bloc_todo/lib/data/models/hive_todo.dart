import 'package:flutter_bloc_todo/domain/models/todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_todo.g.dart';

@HiveType(typeId: 0)
class HiveTodo extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String body;

  @HiveField(2)
  late bool isCompleted;

  // Empty constructor for Hive
  HiveTodo();

  // Named constructor
  HiveTodo.create({
    required this.id,
    required this.body,
    this.isCompleted = false,
  });

  // Convert Hive object -> domain Todo
  Todo toDomain() {
    return Todo(id: id, body: body, isCompleted: isCompleted);
  }

  // Convert domain Todo -> Hive object
  static HiveTodo fromDomain(Todo todo) {
    return HiveTodo.create(
      id: todo.id,
      body: todo.body,
      isCompleted: todo.isCompleted,
    );
  }
}
