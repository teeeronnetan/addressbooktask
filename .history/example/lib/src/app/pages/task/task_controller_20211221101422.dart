import 'package:example/src/app/pages/task/task_presenter.dart';
import 'package:example/src/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskController extends Controller {
  List<Widget> _taskListWidget = [];
  List<Widget> get taskListWidget => _taskListWidget;
  final TaskPresenter taskPresenter;
  final TextEditingController _addTaskInputController = TextEditingController();
  TextEditingController get addTaskInputController =>
      _addTaskInputController; //getter ni para matawag sa view
  // Presenter should always be initialized this way
  TaskController(taskRepo)
      : taskPresenter = TaskPresenter(taskRepo),
        super() {
    taskPresenter.getAllTask();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    taskPresenter.getAllTaskOnNext = (response) {
      response.task.forEach((Task task) {
        _taskListWidget.add(ListTile(
          title: Text(task.description),
        ));
      });

      refreshUI();
    };
    taskPresenter.getAllTaskOnComplete = () {
      print('Task retrieved');
    };
  }

  void addTask() {
    print(_addTaskInputController.text.toString());
  }

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
    taskPresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
