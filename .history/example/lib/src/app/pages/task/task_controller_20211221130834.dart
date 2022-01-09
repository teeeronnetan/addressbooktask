import 'package:example/src/app/pages/task/task_presenter.dart';
import 'package:example/src/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uuid/uuid.dart';

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
    //get all listeners
    taskPresenter.getAllTaskOnNext = (response) {
      _taskListWidget = [];
      response.task.forEach((Task task) {
        _taskListWidget.add(ListTile(
          contentPadding: 1.0,
          trailing: Wrap(spacing: 10, children: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Icon(Icons.edit),
              onPressed: () {},
            ),
            MaterialButton(
              elevation: 5.0,
              child: Icon(Icons.delete),
              onPressed: () {},
            )
          ]),
          title: Text(task.description),
        ));
      });

      refreshUI();
    };
    taskPresenter.getAllTaskOnComplete = () {
      print('Task retrieved');
    };

    //add listener

    taskPresenter.addNewTaskOnNext = (response) {
      taskPresenter.getAllTask();
    };
    taskPresenter.addNewTaskOnComplete = () {};
    taskPresenter.addNewTaskOnError = (response) {};
  }

  void addTask() {
    final description = _addTaskInputController.text.toString();
    var uuid = Uuid();
    taskPresenter.addNewTask(Task(uuid.v1(), description, false));
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
