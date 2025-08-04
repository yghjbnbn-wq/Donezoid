import 'package:donezoid/models/task_model.dart';
import 'package:donezoid/services/database_service.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  List<Task> _tasks = [];

  List<Task> get allTasks => _tasks;

  List<Task> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  List<Task> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  TaskProvider() {
    loadTasks();
  }

  Future<void> loadTasks() async {
    _tasks = _databaseService.getAllTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _databaseService.addTask(task);
    await loadTasks(); // Reload all tasks to get the new one
  }

  Future<void> updateTask(Task task) async {
    await _databaseService.updateTask(task);
    await loadTasks(); // Reload to reflect the update
  }

  Future<void> deleteTask(String id) async {
    await _databaseService.deleteTask(id);
    await loadTasks(); // Reload to reflect the deletion
  }

  Future<void> toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    await updateTask(task);
  }

  Future<void> toggleFavoriteStatus(Task task) async {
    task.isFavorite = !task.isFavorite;
    await updateTask(task);
  }

  Future<void> clearAllTasks() async {
    await _databaseService.clearAllTasks();
    await loadTasks();
  }
}
