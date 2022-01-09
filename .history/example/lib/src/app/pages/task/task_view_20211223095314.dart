import 'package:example/src/app/pages/task/task_controller.dart';
import 'package:example/src/data/repositories/data_task_repository.dart';
import 'package:example/src/domain/entities/task.dart';
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
        body: ControlledWidgetBuilder<TaskController>(
            builder: (context, controller) {
          return ListView(
            children: createListTileList(context, controller),
          );
        }),
      ),
      floatingActionButton: ControlledWidgetBuilder<TaskController>(
        builder: (context, controller) {
          return FloatingActionButton(
            onPressed: () {
              createAlertDialog(context, controller, false);
            },
            child: Icon(Icons.add),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

List<Widget> createListTileList(context, controller) {
  final tileList = <Widget>[];
  controller.taskList.forEach((Task task) {
    tileList.add(ListTile(
      trailing: Wrap(spacing: 5, children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            controller.editTaskInputController.text = task.description;
            print(controller.selectedTask);

            // createAlertDialog(context, controller, true);
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            controller.deleteTask(task.uid);
          },
        )
      ]),
      title: Text(task.description),
    ));
  });
  return tileList;
}

Future<String> createAlertDialog(
    BuildContext context, TaskController controller, bool isEdit) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Update task:' : 'Enter task:'),
          content: TextField(
            controller: isEdit
                ? controller.editTaskInputController
                : controller.addTaskInputController,
          ),
          actions: <Widget>[
            MaterialButton(
              elevation: 5.0,
              child: Text(isEdit ? 'Edit task' : 'Add task'),
              onPressed: () {
                if (isEdit) {
                  //edit
                  controller.editTask();
                  Navigator.of(context).pop();
                } else {
                  controller.addTask();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}
