// ignore_for_file: missing_return

import 'dart:convert';

import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';
import 'package:localstorage/localstorage.dart';

class DataAddressRepository extends AddressRepository {
  // sigleton
  final storage = LocalStorage('AddressBook');
  List<Address> addresses = <Address>[];

  @override
  Future<Address> addAddress(Address newAddress) async {
    await storage.ready;
    storage.setItem('tyrone', jsonEncode([]));
    addresses.add(newAddress);
    storage.setItem('tyrone', jsonEncode(addresses));
  }

  @override
  Future<Address> deleteAddress(Address address) async {
    await storage.ready;
    // delete address implement
    storage.setItem('tyrone', jsonEncode([]));
    addresses.removeWhere((Address item) => item.uid == address.uid);
    storage.setItem('tyrone', jsonEncode(addresses));
  }

  @override
  Future<Address> editAddress(Address editedAddress) async {
    await storage.ready;
    storage.setItem('tyrone', jsonEncode([]));
    addresses.forEach((Address address) {
      if (address.uid == editedAddress.uid) {
        address.fname = editedAddress.fname;
        address.mname = editedAddress.mname;
        address.lname = editedAddress.lname;
        address.phonenum = editedAddress.phonenum;
        address.addr = editedAddress.addr;
        address.birthdate= editedAddress.birthdate;
      }
    });
    storage.setItem('tyrone', jsonEncode(addresses));
  }

@override
  Future<List<Address>> getAllAddress() async {
    await storage.ready;
    addresses = [];
    final storageData = jsonDecode(storage.getItem('tyrone'));
    print(storageData);
    storageData.forEach((data) {
      addresses.add(Address(data['uid'], data['fname'], data['mname'], data['lname'], data['phonenum'], data['addr'], data['birthdate'], data['age']
      //data['lname'], data['phonenum'], data['addr'], data['birthdate']
      ));
    });
    return addresses;
  }

  @override
  Future<Address> getAddress(String uid) {
    // todo implement get address
  }
}
