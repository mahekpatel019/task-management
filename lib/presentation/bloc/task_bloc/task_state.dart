// presentation/bloc/task_bloc/task_state.dart
import 'package:task_management/domain/entities/task.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TasksLoading extends TaskState {}

class TasksLoaded extends TaskState {
  final List<Task> tasks;

  TasksLoaded(this.tasks);
}

class TaskOperationSuccess extends TaskState {}

class TaskError extends TaskState {
  final String message;

  TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

class TaskOperationInProgress extends TaskState {}
