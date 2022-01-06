import 'dart:async';

import 'package:example/src/domain/entities/task.dart';

import '../repositories/task_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetAllTaskUseCase extends UseCase<GetAllTaskUseCaseResponse, void> {
  final TaskRepository taskRepository;
  GetAllTaskUseCase(this.taskRepository);

  @override
  Future<Stream<GetAllTaskUseCaseResponse>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<GetAllTaskUseCaseResponse>();
    try {
      // get user
      final taskList = await taskRepository.getAllTask();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetAllTaskUseCaseResponse(taskList));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetAllTaskUseCaseResponse {
  final List<Task> task;
  GetAllTaskUseCaseResponse(this.task);
}
