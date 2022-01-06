import 'package:example/src/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Task> getTask(String uid);
  Future<List<Task>> getAllTask(String uid);
  Future<Task> deleteTask(String uid);
  Future<Task> addTask(Task task);
  Future<Task> editTask(Task task);
}
