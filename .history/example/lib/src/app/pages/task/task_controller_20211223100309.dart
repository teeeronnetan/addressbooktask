import 'package:example/src/app/pages/task/task_presenter.dart';
import 'package:example/src/app/pages/task/task_view.dart';

import 'package:example/src/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uuid/uuid.dart';

class TaskController extends Controller {
  List<Task> _taskList = [];
  List<Task> get taskList => _taskList;
  final TaskPresenter taskPresenter;
  Task _selectedTask;

  final TextEditingController _editTaskInputController =
      TextEditingController();
  final TextEditingController _addTaskInputController = TextEditingController();

  TextEditingController get addTaskInputController => _addTaskInputController;
  TextEditingController get editTaskInputController => _editTaskInputController;

  // Presenter should always be initialized this way
  TaskController(taskRepo)
      : taskPresenter = TaskPresenter(taskRepo),
        _selectedTask = null,
        super() {
    taskPresenter.getAllTask();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    //get all listeners
    taskPresenter.getAllTaskOnNext = (response) {
      _taskList = [];
      _taskList = response.task;
      refreshUI();
    };
    taskPresenter.getAllTaskOnComplete = () {
      print('Task retrieved');
    };

    //add task listener

    taskPresenter.addNewTaskOnNext = (response) {
      taskPresenter.getAllTask();
    };
    taskPresenter.addNewTaskOnComplete = () {};
    taskPresenter.addNewTaskOnError = (response) {};

    // delete task listener

    taskPresenter.deleteTaskOnNext = (response) {
      taskPresenter.getAllTask();
    };
    taskPresenter.deleteTaskOnComplete = () {};
    taskPresenter.deleteTaskOnError = (response) {};

    // edit task listener

    taskPresenter.editTaskOnNext = (response) {
      taskPresenter.getAllTask();
    };
    taskPresenter.editTaskOnComplete = () {};
    taskPresenter.editTaskOnError = (response) {};
  }

  void setSelectedTask(Task task) {
    _selectedTask = task;
  }

  void addTask() {
    final description = _addTaskInputController.text.toString();
    var uuid = Uuid();
    taskPresenter.addNewTask(Task(uuid.v1(), description, false));
  }

  void deleteTask(String uid) {
    taskPresenter.deleteTask(uid);
  }

  void editTask() {
    _selectedTask.description = _editTaskInputController.text;
    taskPresenter.editTask(_selectedTask);
  }

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
