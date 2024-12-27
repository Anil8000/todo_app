import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_demo/controllers/todo/todo_event.dart';
import 'package:todo_demo/controllers/todo/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  Database? _database;

  TodoBloc() : super(TodoInitial()) {
    on<FetchTodosEvent>((event, emit) async {
      emit(TodoLoading());
      await _initDatabase();
      final tasks = await _database!.query('tasks');
      if (event.filter == "completed") {
        emit(TodoLoaded(tasks.where((task) => task['completed'] == 1).toList()));
      } else if (event.filter == "incomplete") {
        emit(TodoLoaded(tasks.where((task) => task['completed'] == 0).toList()));
      } else {
        emit(TodoLoaded(tasks));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      await _initDatabase();
      await _database!.insert('tasks', {'task': event.task, 'completed': 0});
      add(FetchTodosEvent());
    });

    on<UpdateTodoEvent>((event, emit) async {
      await _initDatabase();
      await _database!.update(
        'tasks', {'task': event.task, 'completed': event.completed ? 1 : 0},
        where: 'id = ?',
        whereArgs: [event.id],
      );
      add(FetchTodosEvent());
    });

    on<DeleteTodoEvent>((event, emit) async {
      await _initDatabase();
      await _database!.delete('tasks', where: 'id = ?', whereArgs: [event.id]);
      add(FetchTodosEvent());
    });
  }

  Future<void> _initDatabase() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, task TEXT, completed INTEGER)',
        );
      },
      version: 1,
    );
  }
}