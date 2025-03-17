import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/domain/entities/task.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_event.dart';
import 'package:task_management/presentation/pages/add_edit_task_page.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(task.name),
      subtitle: Text(task.details),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              task.isFavourite ? Icons.star : Icons.star_border,
              color: task.isFavourite ? Colors.amber : Colors.grey,
            ),
            onPressed: () => _toggleFavourite(context),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEdit(context),
          ),
        ],
      ),
    );
  }
  void _toggleFavourite(BuildContext context) {
    final bloc = context.read<TaskBloc>();
    final updatedTask = task.copyWith(isFavourite: !task.isFavourite);
    bloc.add(SaveTask(updatedTask));
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddEditTaskPage(task: task)),
    );
  }
}
