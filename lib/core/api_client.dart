// core/api_client.dart
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_management/data/model/task_model.dart';

// core/api_client.dart
class ApiClient {
  final _client = http.Client();
  final _baseUrl = 'https://hushed-foggy-dollar.glitch.me/api';

  Future<List<TaskModel>> getTasks() async {
    final response = await _client.get(Uri.parse('$_baseUrl/glitch-tasks'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((e) => TaskModel.fromJson(e))
          .toList();
    }
    throw Exception('Failed to load tasks');
  }

  Future<TaskModel> saveTask(Map<String, dynamic> taskData) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/add-task'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(taskData),
      );

      print('Response: ${response.body}'); // Debug response

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (!responseBody.containsKey('task')) {
          // Check response structure
          throw Exception('Invalid API response format: ${response.body}');
        }
        return TaskModel.fromJson(responseBody['task']);
      }
      throw Exception('Failed to save task: ${response.statusCode}');
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }
}
