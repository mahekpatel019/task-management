import 'package:task_management/core/api_client.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/domain/entities/task.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
class TaskRepositoryImpl implements TaskRepository {
  final ApiClient _apiClient;

  TaskRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<List<Task>> getTasks() async {
    final tasks = await _apiClient.getTasks();
    return tasks.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Task> saveTask(Task task) async {
    final taskModel = TaskModel(
      taskId: task.id!,
      taskName: task.name,
      taskDetails: task.details,
      isFavourite: task.isFavourite,
      createdDate: task.createdDate ?? DateTime.now(),
      updatedDate: task.updatedDate ?? DateTime.now(),
    );
    final savedModel = await _apiClient.saveTask(taskModel.toJson());
    return savedModel.toEntity();
  }
}
