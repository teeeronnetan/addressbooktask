// ignore_for_file: missing_return

import 'package:flutter/material.dart';

import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class DataTaskRepository extends TaskRepository {
  List<Task> tasks;
  // sigleton
  static final DataTaskRepository _instance = DataTaskRepository._internal();
  DataTaskRepository._internal() {
    tasks = <Task>[];
    tasks.addAll([
      Task('test-uid-1', 'Check assignments', true),
      Task('test-uid-2', 'Edit bookmarks', false)
    ]);
  }
  factory DataTaskRepository() => _instance;

  String get uid => null;

  @override
  Future<Task> addTask(Task newTask) async {
    tasks.add(newTask);
  }

  @override
  Future<Task> deleteTask(String uid) async {
    // delete task implement
    tasks.removeWhere((Task item) => item.uid == uid);
  }

  @override
  Future<Task> editTask(Task editedTask) async {
    // edit task implement
    tasks.add(editedTask);
  }

  @override
  Future<List<Task>> getAllTask() async {
    // todo implement get all task
    return tasks;
  }

  @override
  Future<Task> getTask(String uid) {
    // todo implement get task
  }
}
