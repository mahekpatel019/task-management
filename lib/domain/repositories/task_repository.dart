// domain/repositories/task_repository.dart
import 'package:task_management/domain/entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getTasks();
  Future<Task> saveTask(Task task);
}
