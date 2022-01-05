import 'package:example/src/domain/entities/address.dart';
import 'package:example/src/domain/usecases/add_address_usecase.dart';
import 'package:example/src/domain/usecases/delete_address_usecase.dart';
import 'package:example/src/domain/usecases/edit_address_usecase.dart';
import 'package:example/src/domain/usecases/get_all_address_usecase.dart';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class AddressPresenter extends Presenter {
  Function getAllAddressOnNext;
  Function getAllAddressOnComplete;
  Function getAllAddressOnError;

  Function addNewAddressOnNext;
  Function addNewAddressOnComplete;
  Function addNewAddressOnError;

  Function deleteAddressOnNext;
  Function deleteAddressOnComplete;
  Function deleteAddressOnError;

  Function editAddressOnNext;
  Function editAddressOnComplete;
  Function editAddressOnError;

  final GetAllAddressUseCase getAllAddressUseCase;
  final AddAddressUseCase addAddressUseCase;
  final DeleteAddressUseCase deleteAddressUseCase;
  final EditAddressUseCase editAddressUseCase;

  AddressPresenter(addressRepo)
      : getAllAddressUseCase = GetAllAddressUseCase(addressRepo),
        addAddressUseCase = AddAddressUseCase(addressRepo),
        deleteAddressUseCase = DeleteAddressUseCase(addressRepo),
        editAddressUseCase = EditAddressUseCase(addressRepo);

  void getAllAddress() {
    // execute getUseruserCase
    getAllAddressUseCase.execute(_GetAllAddressUseCaseObserver(this), null);
  }

  void addNewAddress(Address address) {
    // execute getUseruserCase
    addAddressUseCase.execute(
        _AddAddressUseCaseObserver(this), AddAddressUseCaseParams(address));
  }

  void deleteAddress(Address address) {
    deleteAddressUseCase.execute(
        _DeleteAddressUseCaseObserver(this), DeleteAddressUseCaseParams(address));
  }

  void editAddress(Address address) {
    editAddressUseCase.execute(
        _EditAddressUseCaseObserver(this), EditAddressUseCaseParams(address));
  }

  @override
  void dispose() {
    getAllAddressUseCase.dispose();
    addAddressUseCase.dispose();
    deleteAddressUseCase.dispose();
    editAddressUseCase.dispose();
  }
}

class _GetAllAddressUseCaseObserver extends Observer<GetAllAddressUseCaseResponse> {
  final AddressPresenter presenter;
  _GetAllAddressUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    assert(presenter.getAllAddressOnComplete != null);
    presenter.getAllAddressOnComplete();
  }

  @override
  void onError(e) {
    presenter.getAllAddressOnError(e);
  }

  @override
  void onNext(response) {
    assert(presenter.getAllAddressOnNext != null);
    presenter.getAllAddressOnNext(response);
  }
}

class _AddAddressUseCaseObserver extends Observer<AddAddressUseCaseResponse> {
  final AddressPresenter presenter;
  _AddAddressUseCaseObserver(this.presenter);
  @override
  void onComplete() {
    presenter.addNewAddressOnComplete();
  }

  @override
  void onError(e) {
    presenter.addNewAddressOnError(e);
  }

  @override
  void onNext(response) {
    presenter.addNewAddressOnNext(response);
  }
}

class _DeleteAddressUseCaseObserver extends Observer<DeleteAddressUseCaseResponse> {
  final AddressPresenter presenter;
  _DeleteAddressUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.deleteAddressOnComplete();
  }

  @override
  void onError(e) {
    presenter.deleteAddressOnError(e);
  }

  @override
  void onNext(response) {
    presenter.deleteAddressOnNext(response);
  }
}

class _EditAddressUseCaseObserver extends Observer<EditAddressUseCaseResponse> {
  final AddressPresenter presenter;
  _EditAddressUseCaseObserver(this.presenter);

  @override
  void onComplete() {
    presenter.editAddressOnComplete();
  }

  @override
  void onError(e) {
    presenter.editAddressOnError(e);
  }

  @override
  void onNext(response) {
    presenter.editAddressOnNext(response);
  }
}
