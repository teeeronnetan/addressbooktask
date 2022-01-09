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
}
