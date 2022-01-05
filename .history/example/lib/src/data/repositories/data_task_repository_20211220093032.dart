import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class DataTaskRepository extends TaskRepository {
  List<Task> tasks;
  // sigleton
  static final DataTaskRepository _instance = DataTaskRepository._internal();
  DataTaskRepository._internal() {
    tasks = <Task>[];
    tasks.addAll([
      Task('test-uid', 'John Smith', 18),
      Task('test-uid2', 'John Doe', 22)
    ]);
  }
  factory DataTaskRepository() => _instance;

  @override
  Future<Task> addTask(Task task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }

  @override
  Future<Task> deleteTask(String uid) {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<Task> editTask(Task task) {
    // TODO: implement editTask
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> getAllTask(String uid) {
    // TODO: implement getAllTask
    throw UnimplementedError();
  }

  @override
  Future<Task> getTask(String uid) {
    // TODO: implement getTask
    throw UnimplementedError();
  }
}
