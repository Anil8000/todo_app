abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Map<String, dynamic>> tasks;
  TodoLoaded(this.tasks);
}

class TodoError extends TodoState {}