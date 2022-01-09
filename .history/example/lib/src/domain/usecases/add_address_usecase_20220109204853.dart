import 'dart:async';

import 'package:example/src/domain/entities/address.dart';

import '../repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddAddressUseCase
    extends UseCase<AddAddressUseCaseResponse, AddAddressUseCaseParams> {
  final AddressRepository addressRepository;
  AddAddressUseCase(this.addressRepository);

  int strLength = 0;

  @override
  Future<Stream<AddAddressUseCaseResponse>> buildUseCaseStream(
      AddAddressUseCaseParams params) async {
    final controller = StreamController<AddAddressUseCaseResponse>();

    strLength = params.address.fname.length;

    if (strLength <= 3) {
      controller.addError('ERROR: Details too short!');
      return controller.stream;
    }

    try {
      // get user
      final age = 18;

      params.address.age = age;

      final Address = await addressRepository.addAddress(params.address);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(AddAddressUseCaseResponse(Address));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class AddAddressUseCaseParams {
  final Address address;
  AddAddressUseCaseParams(this.address);
}

/// Wrapping response inside an object makes it easier to change later
class AddAddressUseCaseResponse {
  final Address address;
  AddAddressUseCaseResponse(this.address);
}
