import 'package:task_management/domain/entities/task.dart';

class TaskModel {
  final int taskId;
  final String taskName;
  final String taskDetails;
  final bool isFavourite;
  final DateTime createdDate;
  final DateTime updatedDate;

  TaskModel({
    required this.taskId,
    required this.taskName,
    required this.taskDetails,
    required this.isFavourite,
    required this.createdDate,
    required this.updatedDate,
  });

  /// Factory constructor to create TaskModel from JSON
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['task_id'] ?? 0, // Default to 0 if missing
      taskName: json['task_name'] ?? 'Untitled Task',
      taskDetails: json['task_details'] ?? '',
      isFavourite: (json['is_favourite'] as bool?) ?? false, // Ensure bool type
      createdDate:
          json['created_date'] != null
              ? DateTime.tryParse(json['created_date']) ?? DateTime.now()
              : DateTime.now(), // Handle null or invalid date
      updatedDate:
          json['updated_date'] != null
              ? DateTime.tryParse(json['updated_date']) ?? DateTime.now()
              : DateTime.now(),
    );
  }

  /// Convert TaskModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'task_name': taskName,
      'task_details': taskDetails,
      'is_favourite': isFavourite,
      'created_date': createdDate.toIso8601String(),
      'updated_date': updatedDate.toIso8601String(),
    };
  }

  /// Convert TaskModel to Task entity
  Task toEntity() {
    return Task(
      id: taskId,
      name: taskName,
      details: taskDetails,
      isFavourite: isFavourite,
      createdDate: createdDate,
      updatedDate: updatedDate,
    );
  }

  /// **Copy with method to update specific fields**
  TaskModel copyWith({
    int? taskId,
    String? taskName,
    String? taskDetails,
    bool? isFavourite,
    DateTime? createdDate,
    DateTime? updatedDate,
  }) {
    return TaskModel(
      taskId: taskId ?? this.taskId,
      taskName: taskName ?? this.taskName,
      taskDetails: taskDetails ?? this.taskDetails,
      isFavourite: isFavourite ?? this.isFavourite,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
    );
  }
}
