// ignore_for_file: missing_return

import 'dart:convert';

import '../../domain/entities/address.dart';
import '../../domain/repositories/address_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataAddressRepository extends AddressRepository {
  // singleton
  final CollectionReference _mainCollection =
      FirebaseFirestore.instance.collection('AddressBook');

  List<Address> addresses = <Address>[];

  @override
  Future<Address> addAddress(Address newAddress) async {
    print('Add address');
    _mainCollection.add(newAddress.toJson());
    return newAddress;
  }

  @override
  Future<Address> editAddress(Address editedAddress) async {
    _mainCollection.doc(editedAddress.uid).set(editedAddress.toJson());
    return editedAddress;
  }

  @override
  Future<List<Address>> getAllAddress() async {
    // await storage.ready;
    final addressList = <Address>[];
    final address = await _mainCollection.get();
    address.docs.forEach((doc) {
      final returnedAddress =
          Address(doc.id, doc.get('fname'), doc.get('mname'), doc.get('lname'), doc.get('phonenum'), doc.get('addr'), doc.get('birthdate'), doc.get('age'));
      addressList.add(returnedAddress);
      print(returnedAddress);
    });

    return addressList;
  }

  @override
  Future<Address> deleteAddress(Address address) {
    _mainCollection.doc(address.uid).delete();
  }

  @override
  Future<Address> getAddress(String uid) {
    throw UnimplementedError();
  }
}
