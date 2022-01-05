import 'package:example/src/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Task> getTask(String uid);
  Future<List<Task>> getAllTask();
  Future<Task> deleteTask(Task task);
  Future<Task> addTask(Task task);
  Future<Task> editTask(Task task);
}
