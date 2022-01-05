import 'package:example/src/domain/usecases/add_task_usecase.dart';
import 'package:example/src/domain/usecases/get_all_task_usecase.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskPresenter extends Presenter {
  Function getAllTaskOnNext;
  Function getAllTaskOnComplete;
  Function getAllTaskOnError;

  Function addNewTaskOnNext;
  Function addNewTaskOnComplete;
  Function addNewTaskOnError;

  final GetAllTaskUseCase getAllTaskUseCase;
  final AddTaskUseCase addTaskUseCase;

  TaskPresenter(taskRepo)
      : getAllTaskUseCase = GetAllTaskUseCase(taskRepo),
        addTaskUseCase = AddTaskUseCase(taskRepo);

  void getAllTask() {
    // execute getUseruserCase
    getAllTaskUseCase.execute(_GetAllTaskUseCaseObserver(this), null);
  }

  void addNewTask(Task task) {
    // execute getUseruserCase
    getAllTaskUseCase.execute(_GetAllTaskUseCaseObserver(this), null);
  }

  @override
  void dispose() {
    getAllTaskUseCase.dispose();
  }
}

class _GetAllTaskUseCaseObserver extends Observer<GetAllTaskUseCaseResponse> {
  final TaskPresenter presenter;
  _GetAllTaskUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    assert(presenter.getAllTaskOnComplete != null);
    presenter.getAllTaskOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getAllTaskOnError != null);
    presenter.getAllTaskOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getAllTaskOnNext != null);
    presenter.getAllTaskOnNext(response);
  }
}
