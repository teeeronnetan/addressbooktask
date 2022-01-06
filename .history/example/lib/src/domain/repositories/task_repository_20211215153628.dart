import 'package:example/src/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Task> getTask(String uid);
  Future<Task> getAllTask(List[Task]);
  Future<Task> deleteTask(String uid);
  Future<Task> addTask(Map data);
  Future<Task> editTask(String uid, Map data);
}
