import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/core/api_client.dart';
import 'package:task_management/data/repositories/task_repository_impl.dart';
import 'package:task_management/domain/repositories/task_repository.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_event.dart';
import 'package:task_management/presentation/pages/tasks_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => ApiClient()),
        RepositoryProvider<TaskRepository>(
          create:
              (context) =>
                  TaskRepositoryImpl(apiClient: context.read<ApiClient>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => TaskBloc(
                  taskRepository: RepositoryProvider.of<TaskRepository>(
                    context,
                  ),
                )..add(LoadTasks()),
          ),
        ],
        child: MaterialApp(
          title: 'Task Manager',
          home: const TasksPage(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
