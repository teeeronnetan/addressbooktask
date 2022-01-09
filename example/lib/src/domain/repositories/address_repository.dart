import 'package:example/src/domain/entities/address.dart';

abstract class AddressRepository {
  Future<Address> getAddress(String uid);
  Future<List<Address>> getAllAddress();
  Future<Address> addAddress(Address address);
  Future<Address> deleteAddress(Address address);
  Future<Address> editAddress(Address address);
}