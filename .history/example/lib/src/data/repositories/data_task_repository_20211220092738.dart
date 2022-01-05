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
  Future<List<Task>> getAllTask() async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data
    return tasks;
  }

  @override
  Future<Task> getTask(String uid) async {
    // Here, do some heavy work lke http requests, async tasks, etc to get data

    return tasks.firstWhere((tasks) => tasks.uid == uid);
  }

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
}
