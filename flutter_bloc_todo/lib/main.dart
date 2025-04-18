import 'package:flutter/material.dart';
import 'package:flutter_bloc_todo/data/models/hive_todo.dart';
import 'package:flutter_bloc_todo/data/repository/hive_todo_repo.dart';
import 'package:flutter_bloc_todo/domain/repository/todo_repo.dart';
import 'package:flutter_bloc_todo/presentation/todo_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register the HiveTodo adapter
  Hive.registerAdapter(HiveTodoAdapter());

  // Create the repository
  final todoRepo = await HiveTodoRepository.create();

  // Run app with the repository
  runApp(MyApp(todoRepo: todoRepo));
}

class MyApp extends StatelessWidget {
  final TodoRepo todoRepo;

  const MyApp({super.key, required this.todoRepo});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: TodoPage(todoRepo: todoRepo),
    );
  }
}
