import 'dart:async';

import 'package:example/src/domain/entities/address.dart';

import '../repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class DeleteAddressUseCase
    extends UseCase<DeleteAddressUseCaseResponse, DeleteAddressUseCaseParams> {
  final AddressRepository addressRepository;
  DeleteAddressUseCase(this.addressRepository);

  @override
  Future<Stream<DeleteAddressUseCaseResponse>> buildUseCaseStream(
      DeleteAddressUseCaseParams params) async {
    final controller = StreamController<DeleteAddressUseCaseResponse>();
    // if (params.address.isCheck) {
    //   controller.addError('ERROR: Unable to delete!');
    //   return controller.stream;
    // }
    try {
      // get user
      final user = await addressRepository.deleteAddress(params.address);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(DeleteAddressUseCaseResponse(user));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class DeleteAddressUseCaseParams {
  final Address address;
  DeleteAddressUseCaseParams(this.address);
}

/// Wrapping response inside an object makes it easier to change later
class DeleteAddressUseCaseResponse {
  final Address address;
  DeleteAddressUseCaseResponse(this.address);
}
