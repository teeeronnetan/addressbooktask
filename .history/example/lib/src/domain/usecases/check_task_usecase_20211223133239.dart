import 'dart:async';
import 'package:example/src/domain/entities/task.dart';
import '../repositories/task_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CheckTaskUseCase
    extends UseCase<CheckTaskUseCaseResponse, CheckTaskUseCaseParams> {
  final TaskRepository taskRepository;
  CheckTaskUseCase(this.taskRepository);

  @override
  Future<Stream<CheckTaskUseCaseResponse>> buildUseCaseStream(
      CheckTaskUseCaseParams params) async {
    final controller = StreamController<CheckTaskUseCaseResponse>();
    try {
      // get task
      final Task = await taskRepository.checkTask(params.task);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(CheckTaskUseCaseResponse(Task));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class CheckTaskUseCaseParams {
  final Task task;
  CheckTaskUseCaseParams(this.task);
}

/// Wrapping response inside an object makes it easier to change later
class CheckTaskUseCaseResponse {
  final Task task;
  CheckTaskUseCaseResponse(this.task);
}
