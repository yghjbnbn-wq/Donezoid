import 'package:donezoid/models/task_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  final Box<Task> _taskBox;

  DatabaseService() : _taskBox = Hive.box<Task>('tasks');

  Future<void> addTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  List<Task> getAllTasks() {
    return _taskBox.values.toList();
  }

  Future<void> updateTask(Task task) async {
    await task.save();
  }

  Future<void> deleteTask(String id) async {
    await _taskBox.delete(id);
  }

  Future<void> clearAllTasks() async {
    await _taskBox.clear();
  }
}
