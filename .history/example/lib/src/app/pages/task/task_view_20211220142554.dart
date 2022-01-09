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

  Future<void> createAlertDialog() async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add task'),
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        }
           
        });
  }

  @override
  Widget get view {
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
            onPressed: () => {},
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
