import 'package:example/src/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Task> getTask(String uid);
  Future<List<Task>> getAllTask();
  Future<Task> deleteTask(String uid);
  Future<Task> addTask(Task task);
  Future<Task> editTask(Task task);
  Future<Task> checkTask(Task task);
}
