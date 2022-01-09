import 'package:example/src/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Task> getTask(String uid);
  // ignore: avoid_types_as_parameter_names, use_function_type_syntax_for_parameters
  Future<Task> getAllListTask(List(<Task>));
  Future<Task> deleteTask(String uid);
  Future<Task> addTask(Map data);
  Future<Task> editTask(String uid, Map data);
}
