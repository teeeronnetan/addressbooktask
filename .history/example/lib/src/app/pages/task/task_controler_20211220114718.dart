import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskController extends Controller {
  final HomePresenter homePresenter;
  // Presenter should always be initialized this way
  TaskController(usersRepo)
      : homePresenter = HomePresenter(usersRepo),
        super();

  @override
  // this is called automatically by the parent class
  void initListeners() {}

  void buttonPressed() {}

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
