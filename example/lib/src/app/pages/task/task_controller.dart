import 'package:example/src/app/pages/task/task_presenter.dart';
import 'package:example/src/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    taskPresenter.getAllTaskOnError = (e) {
      print("GETTING DATA ERROR");
      print(e);
    };

    void showToast(customMsg) => Fluttertoast.showToast(
          msg: customMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 10,
        );

    //add task listener

    taskPresenter.addNewTaskOnNext = (response) {
      taskPresenter.getAllTask();
    };
    taskPresenter.addNewTaskOnComplete = () {};
    taskPresenter.addNewTaskOnError = (response) {};
    taskPresenter.addNewTaskOnError = (error) {
      print(error);
      showToast(error);
    };

    // delete task listener

    taskPresenter.deleteTaskOnNext = (response) {
      taskPresenter.getAllTask();
    };
    taskPresenter.deleteTaskOnComplete = () {};
    taskPresenter.deleteTaskOnError = (response) {};
    taskPresenter.deleteTaskOnError = (error) {
      print(error);
      showToast(error);
    };

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

  void handleCheckbox() {
    _selectedTask.isCheck = !_selectedTask.isCheck;
    taskPresenter.editTask(_selectedTask);
  }

  void getTask() {
    taskPresenter.getAllTask();
  }

  void addTask() {
    final description = _addTaskInputController.text.toString();
    var uuid = Uuid();
    taskPresenter.addNewTask(Task(uuid.v1(), description, false));
  }

  void deleteTask(Task task) {
    taskPresenter.deleteTask(task);
  }

  void editTask() {
    _selectedTask.description = _editTaskInputController.text;
    taskPresenter.editTask(_selectedTask);
    print(_selectedTask);
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
