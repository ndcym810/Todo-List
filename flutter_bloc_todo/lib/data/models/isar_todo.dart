// Converts todo model into isar todo model hat we can store in our isar db.

import 'package:flutter_bloc_todo/domain/models/todo.dart';
import 'package:isar/isar.dart';

// to generate isar todo object, run: dart run build_runner build
part 'isar_todo.g.dart';

@collection
@Name("TodoIsar")
class TodoIsar {
  late Id id;
  late String body;
  late bool isCompleted;

  //conver isar object -> pure todo object to use in our app
  Todo toDomain() {
    return Todo(id: id, body: body, isCompleted: isCompleted);
  }

  //convert pure todo object -> isar object to store in isar db
  static TodoIsar fromDomain(Todo todo) {
    return TodoIsar()
      ..id = todo.id
      ..body = todo.body
      ..isCompleted = todo.isCompleted;
  }
}
