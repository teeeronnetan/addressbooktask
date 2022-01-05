import 'package:example/src/domain/usecases/get_all_task_usecase.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskPresenter extends Presenter {
  Function getAllTaskOnNext;
  Function getAllTaskOnComplete;
  Function getAllTaskOnError;

  final GetAllTaskUseCase getAllTaskUseCase;
  TaskPresenter(taskRepo) : getAllTaskUseCase = GetAllTaskUseCase(taskRepo);

  void getAllTask() {
    // execute getUseruserCase
    getAllTaskUseCase.execute(
        _GetAllTaskUseCaseObserver(this),void);
  }

  @override
  void dispose() {
    getAllTaskUseCase.dispose();
  }
}

class _GetAllTaskUseCaseObserver extends Observer<GetAllTaskUseCase> {
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
