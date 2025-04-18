class Todo {
  final int id;
  final String body;
  final bool isCompleted;

  Todo({required this.id, required this.body, this.isCompleted = false});

  Todo toggleCompletion() {
    return Todo(id: id, body: body, isCompleted: !isCompleted);
  }
}
