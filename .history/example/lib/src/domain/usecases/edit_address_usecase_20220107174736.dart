import 'dart:async';
import 'package:example/src/domain/entities/address.dart';
import '../repositories/address_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class EditAddressUseCase
    extends UseCase<EditAddressUseCaseResponse, EditAddressUseCaseParams> {
  final AddressRepository addressRepository;
  EditAddressUseCase(this.addressRepository);

  @override
  Future<Stream<EditAddressUseCaseResponse>> buildUseCaseStream(
      EditAddressUseCaseParams params) async {
    final controller = StreamController<EditAddressUseCaseResponse>();
    try {
      // get user
      final Address = await addressRepository.editAddress(params.address);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(EditAddressUseCaseResponse(Address));

      controller.close();
    } catch (e) {
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class EditAddressUseCaseParams {
  final Address address;
  EditAddressUseCaseParams(this.address);
}

/// Wrapping response inside an object makes it easier to change later
class EditAddressUseCaseResponse {
  final Address address;
  EditAddressUseCaseResponse(this.address);
}
