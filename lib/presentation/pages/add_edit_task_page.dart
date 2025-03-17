// presentation/pages/add_edit_task_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/domain/entities/task.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/bloc/task_bloc/task_event.dart';

// presentation/pages/add_edit_task_page.dart
class AddEditTaskPage extends StatefulWidget {
  final Task? task;

  const AddEditTaskPage({this.task, super.key});

  @override
  State<AddEditTaskPage> createState() => _AddEditTaskPageState();
}

class _AddEditTaskPageState extends State<AddEditTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _detailsController;
  bool _isFavourite = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.task?.name);
    _detailsController = TextEditingController(text: widget.task?.details);
    _isFavourite = widget.task?.isFavourite ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Task Name'),
                validator:
                    (value) => value?.isEmpty ?? true ? 'Required field' : null,
              ),
              TextFormField(
                controller: _detailsController,
                decoration: const InputDecoration(labelText: 'Details'),
                validator:
                    (value) => value?.isEmpty ?? true ? 'Required field' : null,
              ),
              SwitchListTile(
                title: const Text('Favourite'),
                value: _isFavourite,
                onChanged: (value) => setState(() => _isFavourite = value),
              ),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text('Save Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      final taskModel = TaskModel(
        taskId: widget.task?.id ?? 0, // Ensure non-null ID
        taskName: _nameController.text,
        taskDetails: _detailsController.text,
        isFavourite: _isFavourite,
        createdDate: widget.task?.createdDate ?? DateTime.now(),
        updatedDate: DateTime.now(),
      );

      print('Saving Task: ${taskModel.toJson()}'); // Debug JSON before sending

      // Convert TaskModel to Task using `toEntity()`
      final taskEntity = taskModel.toEntity();

      context.read<TaskBloc>().add(SaveTask(taskEntity));
      Navigator.pop(context);
    }
  }
}
