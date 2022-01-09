import 'dart:async';
import 'package:example/src/domain/entities/task.dart';
import '../repositories/task_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetTaskUseCase
    extends UseCase<GetTaskUseCaseResponse, GetTaskUseCaseParams> {
  final TaskRepository taskRepository;
  GetTaskUseCase(this.taskRepository);

  @override
  Future<Stream<GetTaskUseCaseResponse>> buildUseCaseStream(
      GetTaskUseCaseParams params) async {
    final controller = StreamController<GetTaskUseCaseResponse>();
    try {
      // get user
      final user = await taskRepository.getTask(params.uid);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetTaskUseCaseResponse(user));
      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class GetTaskUseCaseParams {
  final String uid;
  GetTaskUseCaseParams(this.uid);
}

/// Wrapping response inside an object makes it easier to change later
class GetTaskUseCaseResponse {
  final Task task;
  GetTaskUseCaseResponse(this.task);
}
