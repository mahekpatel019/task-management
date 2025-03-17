// presentation/bloc/task_bloc/task_event.dart
import 'package:task_management/domain/entities/task.dart';

abstract class TaskEvent {}

class LoadTasks extends TaskEvent {}

class SaveTask extends TaskEvent {
  final Task task;

  SaveTask(this.task);
}
