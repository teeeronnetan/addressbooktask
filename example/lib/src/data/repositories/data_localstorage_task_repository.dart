// ignore_for_file: missing_return

import 'dart:convert';

import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import 'package:localstorage/localstorage.dart';

class DataTaskRepository extends TaskRepository {
  // sigleton
  final storage = LocalStorage('todoList');
  List<Task> tasks = <Task>[];

  @override
  Future<Task> addTask(Task newTask) async {
    await storage.ready;
    storage.setItem('jollo', jsonEncode([]));
    tasks.add(newTask);
    storage.setItem('jollo', jsonEncode(tasks));
  }

  @override
  Future<Task> deleteTask(Task task) async {
    await storage.ready;
    // delete task implement
    storage.setItem('jollo', jsonEncode([]));
    tasks.removeWhere((Task item) => item.uid == task.uid);
    storage.setItem('jollo', jsonEncode(tasks));
  }

  @override
  Future<Task> editTask(Task editedTask) async {
    await storage.ready;
    storage.setItem('jollo', jsonEncode([]));
    tasks.forEach((Task task) {
      if (task.uid == editedTask.uid) {
        task.description = editedTask.description;
        task.isCheck = editedTask.isCheck;
      }
    });
    storage.setItem('jollo', jsonEncode(tasks));
  }

  @override
  Future<List<Task>> getAllTask() async {
    await storage.ready;
    tasks = [];
    final storageData = jsonDecode(storage.getItem('jollo'));
    print(storageData);
    storageData.forEach((data) {
      tasks.add(Task(data['uid'], data['description'], data['isCheck']));
    });

    return tasks;
  }

  @override
  Future<Task> getTask(String uid) {
    // todo implement get task
  }
}
