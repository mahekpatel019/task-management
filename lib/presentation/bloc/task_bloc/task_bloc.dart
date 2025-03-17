import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_event.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;

  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<SaveTask>(_onSaveTask);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(TasksLoading());
    try {
      final tasks = await taskRepository.getTasks();
      emit(TasksLoaded(tasks));
    } catch (e) {
      emit(TaskError(e.toString()));
    }
  }

  Future<void> _onSaveTask(SaveTask event, Emitter<TaskState> emit) async {
    try {
      emit(TaskOperationInProgress());
      await taskRepository.saveTask(event.task);
      emit(TaskOperationSuccess());
      add(LoadTasks());
    } catch (e) {
      emit(TaskError(e is Exception ? e.toString() : 'Unknown error occurred'));
    }
  }
}
