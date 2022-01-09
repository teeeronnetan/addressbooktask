import 'package:example/src/app/pages/task/task_presenter.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskController extends Controller {
  final TaskPresenter taskPresenter;
  // Presenter should always be initialized this way
  TaskController(usersRepo)
      : taskPresenter = TaskPresenter(usersRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {}

  void addTask() {}

  void deleteTask() {}

  void editTask() {}

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    homePresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
