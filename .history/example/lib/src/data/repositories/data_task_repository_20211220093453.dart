import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class DataTaskRepository extends TaskRepository {
  List<Task> tasks;
  // sigleton
  static final DataTaskRepository _instance = DataTaskRepository._internal();
  DataTaskRepository._internal() {
    tasks = <Task>[];
    tasks.addAll(
        [Task('test-uid', 'John Smith'), Task('test-uid2', 'John Doe')]);
  }
  factory DataTaskRepository() => _instance;

  @override
  Future<Task> addTask(Task task) {
    // to-do implement addTask
    throw UnimplementedError();
  }

  @override
  Future<Task> deleteTask(String uid) {
    // to-do implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Task> editTask(Task task) {
    // to-do implement editTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask(String uid) {
    // to-do implement getAllTask
    return tasks;
  }

  @override
  Future<Task> getTask(String uid) {
    // to-do implement getTask
    throw UnimplementedError();
  }
}
