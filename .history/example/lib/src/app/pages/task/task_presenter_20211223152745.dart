import 'package:example/src/domain/entities/task.dart';
import 'package:example/src/domain/usecases/add_task_usecase.dart';
// import 'package:example/src/domain/usecases/check_task_usecase.dart';
import 'package:example/src/domain/usecases/delete_task_usecase.dart';
import 'package:example/src/domain/usecases/edit_task_usecase.dart';
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

  Function editTaskOnNext;
  Function editTaskOnComplete;
  Function editTaskOnError;

  // Function checkTaskOnNext;
  // Function checkTaskOnComplete;
  // Function checkTaskOnError;

  final GetAllTaskUseCase getAllTaskUseCase;
  final AddTaskUseCase addTaskUseCase;
  final DeleteTaskUseCase deleteTaskUseCase;
  final EditTaskUseCase editTaskUseCase;
  // final CheckTaskUseCase checkTaskUseCase;

  TaskPresenter(taskRepo)
      : getAllTaskUseCase = GetAllTaskUseCase(taskRepo),
        addTaskUseCase = AddTaskUseCase(taskRepo),
        deleteTaskUseCase = DeleteTaskUseCase(taskRepo),
        editTaskUseCase = EditTaskUseCase(taskRepo);
  // checkTaskUseCase = CheckTaskUseCase(taskRepo);

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
        _DeleteTaskUseCaseObserver(this), DeleteTaskUseCaseParams(task));
  }

  void editTask(Task task) {
    editTaskUseCase.execute(
        _EditTaskUseCaseObserver(this), EditTaskUseCaseParams(task));
  }

  // void checkTask(Task task) {
  //   checkTaskUseCase.execute(
  //       _CheckTaskUseCaseObserver(this), CheckTaskUseCaseParams(task));
  // }

  @override
  void dispose() {
    getAllTaskUseCase.dispose();
    addTaskUseCase.dispose();
    deleteTaskUseCase.dispose();
    editTaskUseCase.dispose();
    // checkTaskUseCase.dispose();
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
    presenter.deleteTaskOnError(e);
  }

  @override
  void onNext(response) {
    presenter.deleteTaskOnNext(response);
  }
}

class _EditTaskUseCaseObserver extends Observer<EditTaskUseCaseResponse> {
  final TaskPresenter presenter;
  _EditTaskUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.editTaskOnComplete();
  }

  @override
  void onError(e) {
    presenter.editTaskOnError(e);
  }

  @override
  void onNext(response) {
    presenter.editTaskOnNext(response);
  }
}

// class _CheckTaskUseCaseObserver extends Observer<CheckTaskUseCaseResponse> {
//   final TaskPresenter presenter;
//   _CheckTaskUseCaseObserver(this.presenter);

//   @override
//   void onComplete() {
//     presenter.checkTaskOnComplete();
//   }

//   @override
//   void onError(e) {
//     presenter.checkTaskOnError(e);
//   }

//   @override
//   void onNext(response) {
//     presenter.checkTaskOnNext(response);
//   }
// }
