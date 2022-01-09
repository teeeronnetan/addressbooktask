import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';

class DataTaskRepository extends TaskRepository {
  List<Task> tasks;
  // sigleton
  static final DataTaskRepository _instance = DataTaskRepository._internal();
  DataTaskRepository._internal() {
    tasks = <Task>[];
  }
  factory DataTaskRepository() => _instance;

  @override
  Future<Task> addTask(Task task) {
    //dir ka mag add
  }

  @override
  Future<Task> deleteTask(String uid) {
    //drir delete
  }

  @override
  Future<Task> editTask(Task task) {
    // todo implement edit task
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
