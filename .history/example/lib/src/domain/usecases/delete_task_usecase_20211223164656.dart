import 'dart:async';

import 'package:example/src/domain/entities/task.dart';

import '../repositories/task_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeleteTaskUseCase
    extends UseCase<DeleteTaskUseCaseResponse, DeleteTaskUseCaseParams> {
  final TaskRepository taskRepository;
  DeleteTaskUseCase(this.taskRepository);

  @override
  Future<Stream<DeleteTaskUseCaseResponse>> buildUseCaseStream(
      DeleteTaskUseCaseParams params) async {
    final controller = StreamController<DeleteTaskUseCaseResponse>();
    if (params.task.isCheck) {
      controller.addError('ERROR: Task too short!');
      return controller.stream;
    }
    try {
      // get user
      final user = await taskRepository.deleteTask(params.task);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(DeleteTaskUseCaseResponse(user));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class DeleteTaskUseCaseParams {
  final Task task;
  DeleteTaskUseCaseParams(this.task);
}

/// Wrapping response inside an object makes it easier to change later
class DeleteTaskUseCaseResponse {
  final Task task;
  DeleteTaskUseCaseResponse(this.task);
}
