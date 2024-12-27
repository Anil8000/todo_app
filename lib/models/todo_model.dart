class TodoModel {
  final int id;
  final String task;
  final bool completed;

  TodoModel({required this.id, required this.task, required this.completed});

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(id: map['id'], task: map['task'], completed: map['completed'] == 1);
  }

  Map<String, dynamic> toMap() {
    return {'task': task, 'completed': completed ? 1 : 0};
  }
}
