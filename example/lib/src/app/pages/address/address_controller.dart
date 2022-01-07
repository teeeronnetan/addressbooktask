import 'package:example/src/app/pages/address/address_presenter.dart';
import 'package:example/src/domain/entities/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:uuid/uuid.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddressController extends Controller {
  List<Address> _addressList = [];
  List<Address> get addressList => _addressList;
  final AddressPresenter addressPresenter;
  Address _selectedAddress;
  
  final TextEditingController _editAddressInputController =
      TextEditingController();
  final TextEditingController _addAddressInputController = TextEditingController();
  final TextEditingController _editAddress1InputController =
      TextEditingController();
  final TextEditingController _addAddress1InputController = TextEditingController();
  final TextEditingController _addAddress2InputController = TextEditingController();
  final TextEditingController _editAddress2InputController =
      TextEditingController();
  final TextEditingController _addAddress3InputController = TextEditingController();
  final TextEditingController _editAddress3InputController =
      TextEditingController();
  final TextEditingController _addAddress4InputController = TextEditingController();
  final TextEditingController _editAddress4InputController =
      TextEditingController();
    final TextEditingController _addAddress5InputController = TextEditingController();
  final TextEditingController _editAddress5InputController =
      TextEditingController();

  TextEditingController get addAddressInputController => _addAddressInputController;
  TextEditingController get editAddressInputController => _editAddressInputController;
  TextEditingController get addAddress1InputController => _addAddress1InputController;
  TextEditingController get editAddress1InputController => _editAddress1InputController;
  TextEditingController get addAddress2InputController => _addAddress2InputController;
  TextEditingController get editAddress2InputController => _editAddress2InputController;
  TextEditingController get addAddress3InputController => _addAddress3InputController;
  TextEditingController get editAddress3InputController => _editAddress3InputController;
  TextEditingController get addAddress4InputController => _addAddress4InputController;
  TextEditingController get editAddress4InputController => _editAddress4InputController;
  TextEditingController get addAddress5InputController => _addAddress5InputController;
  TextEditingController get editAddress5InputController => _editAddress5InputController;

  // Presenter should always be initialized this way
  AddressController(addressRepo)
      : addressPresenter = AddressPresenter(addressRepo),
        _selectedAddress = null,
        super() {
    addressPresenter.getAllAddress();
  }

  @override
  // this is called automatically by the parent class
  void initListeners() {
    //get all listeners
    addressPresenter.getAllAddressOnNext = (response) {
      _addressList = [];
      _addressList = response.address;
      refreshUI();
    };
    addressPresenter.getAllAddressOnComplete = () {
      print('Address retrieved');
    };
    addressPresenter.getAllAddressOnError = (e) {
      print("GETTING DATA ERROR");
      print(e);
    };

    void showToast(customMsg) => Fluttertoast.showToast(
          msg: customMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 10,
        );

    //add address listener

    addressPresenter.addNewAddressOnNext = (response) {
      addressPresenter.getAllAddress();
    };
    addressPresenter.addNewAddressOnComplete = () {};
    addressPresenter.addNewAddressOnError = (response) {};
    addressPresenter.addNewAddressOnError = (error) {
      print(error);
      showToast(error);
    };

    // delete address listener

    addressPresenter.deleteAddressOnNext = (response) {
      addressPresenter.getAllAddress();
    };
    addressPresenter.deleteAddressOnComplete = () {};
    addressPresenter.deleteAddressOnError = (response) {};
    addressPresenter.deleteAddressOnError = (error) {
      print(error);
      showToast(error);
    };

    // edit address listener

    addressPresenter.editAddressOnNext = (response) {
      addressPresenter.getAllAddress();
    };
    addressPresenter.editAddressOnComplete = () {};
    addressPresenter.editAddressOnError = (response) {};
  }

  void setSelectedAddress(Address address) {
    _selectedAddress = address;
  }

  void getAddress() {
    addressPresenter.getAllAddress();
  }

  void addAddress() {
    final fname = _addAddressInputController.text.toString();
    final mname = _addAddress5InputController.text.toString();
    final lname = _addAddress1InputController.text.toString();
    final phonenum = _addAddress2InputController.text.toString();
    final addr = _addAddress3InputController.text.toString();
    final birthdate = _addAddress4InputController.text.toString();
    final age = -1;
    var uuid = Uuid();
    addressPresenter.addNewAddress(Address(uuid.v1(),fname, mname,lname,phonenum,addr,birthdate, age));
  }

  void deleteAddress(Address address) {
    addressPresenter.deleteAddress(address);
  }

  void editAddress() {
    _selectedAddress.fname = _editAddressInputController.text;
    _selectedAddress.lname = _editAddress1InputController.text;
    _selectedAddress.phonenum = _editAddress2InputController.text;
    _selectedAddress.addr = _editAddress3InputController.text;
    _selectedAddress.birthdate = _editAddress4InputController.text;
    addressPresenter.editAddress(_selectedAddress);
    print(_selectedAddress);
  }

  @override
  void onResumed() => print('On resumed');

  @override
  void onReassembled() => print('View is about to be reassembled');

  @override
  void onDeactivated() => print('View is about to be deactivated');

  @override
  void onDisposed() {
    addressPresenter.dispose(); // don't forget to dispose of the presenter
    super.onDisposed();
  }
}
