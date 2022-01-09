import 'dart:async';

import 'package:example/src/domain/entities/task.dart';

import '../repositories/task_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddTaskUseCase
    extends UseCase<AddTaskUseCaseResponse, AddTaskUseCaseParams> {
  final TaskRepository taskRepository;
  AddTaskUseCase(this.taskRepository);

  int strLength;

  @override
  Future<Stream<AddTaskUseCaseResponse>> buildUseCaseStream(
      AddTaskUseCaseParams params) async {
    final controller = StreamController<AddTaskUseCaseResponse>();

    strLength = params.task.description.length;

    if (strLength <= 5) {
      controller.addError('ERROR');
      return controller.stream;
    }

    try {
      // get user
      final Task = await taskRepository.addTask(params.task);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(AddTaskUseCaseResponse(Task));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class AddTaskUseCaseParams {
  final Task task;
  AddTaskUseCaseParams(this.task);
}

/// Wrapping response inside an object makes it easier to change later
class AddTaskUseCaseResponse {
  final Task task;
  AddTaskUseCaseResponse(this.task);
}
