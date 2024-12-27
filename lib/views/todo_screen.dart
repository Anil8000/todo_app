import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/controllers/todo/todo_bloc.dart';
import 'package:todo_demo/controllers/todo/todo_event.dart';
import 'package:todo_demo/controllers/todo/todo_state.dart';
import 'package:todo_demo/utils/app_strings.dart';
import 'package:todo_demo/views/widgets/no_data.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('To-Do List'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (filter) {
              BlocProvider.of<TodoBloc>(context).add(FetchTodosEvent(filter: filter));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "all", child: Text(AppStrings.all)),
              const PopupMenuItem(value: "completed", child: Text(AppStrings.completed)),
              const PopupMenuItem(value: "incomplete", child: Text(AppStrings.incomplete)),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) return const Center(child: CircularProgressIndicator());
          if (state is TodoLoaded) {
            if (state.tasks.isEmpty) return NoDataWidget(text: AppStrings.noTasksAvailable);
            return ListView.builder(
              itemCount: state.tasks.length,
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return ListTile(
                  title: Text(task['task']),
                  leading: Checkbox(
                    value: task['completed'] == 1,
                    onChanged: (value) {
                      BlocProvider.of<TodoBloc>(context).add(
                        UpdateTodoEvent(task['id'], value!, task['task']),
                      );
                    },
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context).add(DeleteTodoEvent(task['id']));
                    },
                  ),
                  onTap: () {
                    _taskController.text = task['task'];
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text(AppStrings.updateTask),
                          content: TextField(controller: _taskController),
                          actions: [
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<TodoBloc>(context).add(
                                  UpdateTodoEvent(task['id'], task['completed'] == 1, _taskController.text),
                                );
                                Navigator.pop(context);
                              },
                              child: const Text(AppStrings.update),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            );
          }
          return NoDataWidget(text: 'No tasks available.');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _taskController.clear();
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(controller: _taskController),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (_taskController.text.isNotEmpty) {
                        BlocProvider.of<TodoBloc>(context).add(AddTodoEvent(_taskController.text));
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
