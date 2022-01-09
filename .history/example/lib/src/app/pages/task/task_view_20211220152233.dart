import 'package:example/src/app/pages/task/task_controller.dart';
import 'package:example/src/data/repositories/data_task_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class TaskPage extends View {
  TaskPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TaskPageState createState() =>
      // inject dependencies inwards
      _TaskPageState();
}

class _TaskPageState extends ViewState<TaskPage, TaskController> {
  _TaskPageState() : super(TaskController(DataTaskRepository()));

  Future createAlertDialog(BuildContext context) {
    var customController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter task'),
            content: TextField(
              controller: customController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Add task'),
                onPressed: () {},
              )
            ],
          );
        });
  }

  @override
  Widget get view {
    var widget;
    var globalKey;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
