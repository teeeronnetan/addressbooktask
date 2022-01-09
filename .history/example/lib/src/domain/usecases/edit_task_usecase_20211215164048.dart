import 'dart:async';

import 'package:example/src/domain/entities/task.dart';

import '../repositories/task_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class EditTaskUseCase
    extends UseCase<EditTaskUseCaseResponse, EditTaskUseCaseParams> {
  final TaskRepository taskRepository;
  EditTaskUseCase(this.taskRepository);

  @override
  Future<Stream<EditTaskUseCaseResponse>> buildUseCaseStream(
      EditTaskUseCaseParams params) async {
    final controller = StreamController<EditTaskUseCaseResponse>();
    try {
      // get user
      final Task = await taskRepository.editTask(params.task);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(EditTaskUseCaseResponse(Task));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class EditTaskUseCaseParams {
  final Task task;
  EditTaskUseCaseParams(this.task);
}

/// Wrapping response inside an object makes it easier to change later
class EditTaskUseCaseResponse {
  final Task task;
  EditTaskUseCaseResponse(this.task);
}
