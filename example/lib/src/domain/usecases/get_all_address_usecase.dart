import 'dart:async';

import 'package:example/src/domain/entities/address.dart';

import '../repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class GetAllAddressUseCase extends UseCase<GetAllAddressUseCaseResponse, void> {
  final AddressRepository addressRepository;
  GetAllAddressUseCase(this.addressRepository);

  @override
  Future<Stream<GetAllAddressUseCaseResponse>> buildUseCaseStream(
      void params) async {
    final controller = StreamController<GetAllAddressUseCaseResponse>();
    try {
      // get user
      final addressList = await addressRepository.getAllAddress();
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetAllAddressUseCaseResponse(addressList));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping response inside an object makes it easier to change later
class GetAllAddressUseCaseResponse {
  final List<Address> address;
  GetAllAddressUseCaseResponse(this.address);
}
