import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_demo/controllers/device_details/device_details_bloc.dart';
import 'package:todo_demo/controllers/device_details/device_details_event.dart';
import 'package:todo_demo/controllers/todo/todo_event.dart';
import 'package:todo_demo/views/device_details_screen.dart';
import 'package:todo_demo/views/home_screen.dart';
import 'package:todo_demo/views/todo_screen.dart';

import 'controllers/todo/todo_bloc.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => DeviceDetailsBloc()..add(FetchApiEvent())),
        BlocProvider(create: (_) => TodoBloc()..add(FetchTodosEvent())),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
