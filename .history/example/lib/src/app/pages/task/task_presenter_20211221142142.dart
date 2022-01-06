import 'package:example/src/domain/entities/task.dart';
import 'package:example/src/domain/usecases/add_task_usecase.dart';
import 'package:example/src/domain/usecases/delete_task_usecase.dart';
import 'package:example/src/domain/usecases/get_all_task_usecase.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskPresenter extends Presenter {
  Function getAllTaskOnNext;
  Function getAllTaskOnComplete;
  Function getAllTaskOnError;

  Function addNewTaskOnNext;
  Function addNewTaskOnComplete;
  Function addNewTaskOnError;

  Function deleteTaskOnNext;
  Function deleteTaskOnComplete;
  Function deleteTaskOnError;

  final GetAllTaskUseCase getAllTaskUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;

  TaskPresenter(taskRepo)
      : getAllTaskUseCase = GetAllTaskUseCase(taskRepo),
        addTaskUseCase = AddTaskUseCase(taskRepo),
        deleteTaskUseCase = DeleteTaskUseCase(taskRepo);

  void getAllTask() {
    // execute getUseruserCase
    getAllTaskUseCase.execute(_GetAllTaskUseCaseObserver(this), null);
  }

  void addNewTask(Task task) {
    // execute getUseruserCase
    addTaskUseCase.execute(
        _AddTaskUseCaseObserver(this), AddTaskUseCaseParams(task));
  }

  void deleteTask(String uid) {
    deleteTaskUseCase.execute(
        _DeleteTaskUseCaseObserver(this), DeleteTaskUseCaseParams(uid));
  }

  @override
  void dispose() {
    getAllTaskUseCase.dispose();
    addTaskUseCase.dispose();
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

class _AddTaskUseCaseObserver extends Observer<AddTaskUseCaseResponse> {
  final TaskPresenter presenter;
  _AddTaskUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.addNewTaskOnComplete();
  }

  @override
  void onError(e) {
    presenter.addNewTaskOnError(e);
  }

  @override
  void onNext(response) {
    presenter.addNewTaskOnNext(response);
  }
}

class _DeleteTaskUseCaseObserver extends Observer<DeleteTaskUseCaseResponse> {
  final TaskPresenter presenter;
  _DeleteTaskUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.deleteTaskOnComplete();
  }

  @override
  void onError(e) {
    presenter.deleteTaskOnError();
  }

  @override
  void onNext(response) {
    presenter.deleteTaskOnNext(response);
  }
}
