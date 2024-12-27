abstract class TodoEvent {}

class FetchTodosEvent extends TodoEvent {
  final String filter;
  FetchTodosEvent({this.filter = "all"});
}

class AddTodoEvent extends TodoEvent {
  final String task;
  AddTodoEvent(this.task);
}

class UpdateTodoEvent extends TodoEvent {
  final int id;
  final bool completed;
  final String task;
  UpdateTodoEvent(this.id, this.completed, this.task);
}

class DeleteTodoEvent extends TodoEvent {
  final int id;
  DeleteTodoEvent(this.id);
}