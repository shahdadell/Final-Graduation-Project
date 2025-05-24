// ignore_for_file: file_names

import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/add_new_address/add_new_address.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/delete_address.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/edit_addresses.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/view_addresses/view_addresses.dart';

abstract class AddressState {}

class AddressInitialState extends AddressState {}

class AddAddressLoadingState extends AddressState {}

class AddAddressSuccessState extends AddressState {
  final AddNewAddress addNewAddress;

  AddAddressSuccessState({required this.addNewAddress});
}

class AddAddressErrorState extends AddressState {
  final String message;

  AddAddressErrorState({required this.message});
}

class FetchAddressesLoadingState extends AddressState {}

class FetchAddressesSuccessState extends AddressState {
  final ViewAddresses viewAddresses;

  FetchAddressesSuccessState({required this.viewAddresses});
}

class FetchAddressesErrorState extends AddressState {
  final String message;

  FetchAddressesErrorState({required this.message});
}

class DeleteAddressLoadingState extends AddressState {}

class DeleteAddressSuccessState extends AddressState {
  final DeleteAddress deleteAddress;

  DeleteAddressSuccessState({required this.deleteAddress});
}

class DeleteAddressErrorState extends AddressState {
  final String message;

  DeleteAddressErrorState({required this.message});
}

class EditAddressLoadingState extends AddressState {}

class EditAddressSuccessState extends AddressState {
  final EditAddresses editAddresses;

  EditAddressSuccessState({required this.editAddresses});
}

class EditAddressErrorState extends AddressState {
  final String message;

  EditAddressErrorState({required this.message});
}
