import 'package:example/src/app/pages/address/address_controller.dart';
import 'package:example/src/data/repositories/data_localstorage_address_repository.dart';
// import 'package:example/src/data/repositories/data_task_repository.dart';
import 'package:example/src/domain/entities/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddressPage extends View {
  AddressPage({Key key}) : super(key: key);

  @override
  _AddressPageState createState() =>
      // inject dependencies inwards
      _AddressPageState();
}

class _AddressPageState extends ViewState<AddressPage, AddressController> {
  _AddressPageState() : super(AddressController(DataAddressRepository()));

  @override
  Widget get view {
    var globalKey;
    return Scaffold(
      appBar: AppBar(
        title: Text('Address Book'),
      ),
      body: Scaffold(
        key:
            globalKey, // built in global key for the ViewState for easy access in the controller
        body: ControlledWidgetBuilder<AddressController>(
            builder: (context, controller) {
          return ListView(
            children: createListTileList(context, controller),
          );
        }),
      ),
      floatingActionButton: ControlledWidgetBuilder<AddressController>(
        builder: (context, controller) {
          return FloatingActionButton(
            onPressed: () {
              createAlertDialog(context, controller, false);
              controller.getAddress();
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
  controller.addressList.forEach((Address address) {
    tileList.add(ListTile(
      trailing: Wrap(spacing: 0, children: <Widget>[
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            controller.editAddressInputController.text = address.fname;
            controller.editAddress5InputController.text = address.mname;
            controller.editAddress1InputController.text = address.lname;
            controller.editAddress2InputController.text = address.phonenum;
            controller.editAddress3InputController.text = address.addr;
            controller.editAddress4InputController.text = address.birthdate;
            controller.setSelectedAddress(address);
            createAlertDialog(context, controller, true);
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            controller.deleteAddress(address);
          },
        )
      ]),
      title: Text(address.fname +
          ' ' +
          address.mname +
          ' ' +
          address.lname +
          '/' +
          address.phonenum +
          '/' +
          address.addr +
          '/' +
          address.birthdate +
          '/' +
          address.age.toString() +
          ' years old'),
    ));
  });
  return tileList;
}

Future<String> createAlertDialog(
    BuildContext context, AddressController controller, bool isEdit) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(isEdit ? 'Update Details:' : 'Enter Details:'),
          content: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(fontSize: 19)),
                controller: isEdit
                    ? controller.editAddressInputController
                    : controller.addAddressInputController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Middle Name',
                    labelStyle: TextStyle(fontSize: 19)),
                controller: isEdit
                    ? controller.editAddress5InputController
                    : controller.addAddress5InputController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(fontSize: 19)),
                controller: isEdit
                    ? controller.editAddress1InputController
                    : controller.addAddress1InputController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(fontSize: 19)),
                controller: isEdit
                    ? controller.editAddress2InputController
                    : controller.addAddress2InputController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Address', labelStyle: TextStyle(fontSize: 19)),
                controller: isEdit
                    ? controller.editAddress3InputController
                    : controller.addAddress3InputController,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Birthdate (dd-mm-yyyy)',
                    labelStyle: TextStyle(fontSize: 19)),
                controller: isEdit
                    ? controller.editAddress4InputController
                    : controller.addAddress4InputController,
              ),
            ],
          ),

          // TextField(
          //   controller: isEdit
          //       ? controller.editAddressInputController
          //       : controller.addAddressInputController,
          // ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(isEdit ? 'Edit Details' : 'Add Details'),
              onPressed: () {
                if (isEdit) {
                  //edit
                  controller.editAddress();
                  Navigator.of(context).pop();
                } else {
                  controller.addAddress();
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        );
      });
}
