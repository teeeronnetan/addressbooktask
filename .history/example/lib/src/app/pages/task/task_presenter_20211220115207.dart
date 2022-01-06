import 'package:example/src/domain/usecases/get_all_task_usecase.dart';

import '../../../domain/usecases/get_user_usecase.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskPresenter extends Presenter {
  Function getAllTaskOnNext;
  Function getAllTaskOnComplete;
  Function getAllTaskOnError;

  final GetAllTaskUseCase getAllTaskUseCase;
  TaskPresenter(taskRepo) : getAllTaskUseCase = GetAllTaskUseCase(taskRepo);

  @override
  void dispose() {
    getAllTaskUseCase.dispose();
  }
}

class _GetUserUseCaseObserver extends Observer<GetAllTaskUseCase> {
  final TaskPresenter presenter;
  _GetUserUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    assert(presenter.getUserOnComplete != null);
    presenter.getUserOnComplete();
  }

  @override
  void onError(e) {
    assert(presenter.getUserOnError != null);
    presenter.getUserOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getUserOnNext != null);
    presenter.getUserOnNext(response.user);
  }
}
