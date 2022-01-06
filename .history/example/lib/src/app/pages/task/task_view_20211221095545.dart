import 'package:example/src/app/pages/task/task_controller.dart';
import 'package:example/src/data/repositories/data_task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskPage extends View {
  TaskPage({Key key}) : super(key: key);

  @override
  _TaskPageState createState() =>
      // inject dependencies inwards
      _TaskPageState();
}

class _TaskPageState extends ViewState<TaskPage, TaskController> {
  _TaskPageState() : super(TaskController(DataTaskRepository()));

  Future<String> createAlertDialog(BuildContext context,TaskController controller) {
   

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter task:'),
            content: TextField(
              controller: controller.addTaskInputController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Add task'),
                onPressed: () {
                  controller.addTask()
                },
              )
            ],
          );
        });
  }

  @override
  Widget get view {
    var globalKey;
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Scaffold(
        key:
            globalKey, // built in global key for the ViewState for easy access in the controller
        body: Center(),
      ),
      floatingActionButton: ControlledWidgetBuilder<TaskController>(
        builder: (context, controller) {
          return FloatingActionButton(
            onPressed: () {
              createAlertDialog(context);
            },
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
