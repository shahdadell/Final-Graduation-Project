// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Profile_screen/data/repo/Address_repo.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepo addressRepo;

  AddressBloc(this.addressRepo) : super(AddressInitialState()) {
    on<AddAddressEvent>(_onAddAddress);
    on<FetchAddressesEvent>(_onFetchAddresses);
    on<DeleteAddressEvent>(_onDeleteAddress);
    on<EditAddressEvent>(_onEditAddress);
  }

  Future<void> _onAddAddress(
      AddAddressEvent event, Emitter<AddressState> emit) async {
    emit(AddAddressLoadingState());
    try {
      final response = await addressRepo.addAddress(
        addressTitle: event.addressName,
        addressPhone: event.addressPhone, // ضفنا addressPhone
        addressCity: event.addressCity,
        addressDetails: event.addressStreet,
        addressLatitude: event.addressLat,
        addressLongitude: event.addressLong,
      );
      print('Add Address Response: ${response.toJson()}');
      emit(AddAddressSuccessState(addNewAddress: response));
      add(FetchAddressesEvent());
    } catch (e) {
      print('Error adding address: $e');
      emit(AddAddressErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchAddresses(
      FetchAddressesEvent event, Emitter<AddressState> emit) async {
    emit(FetchAddressesLoadingState());
    try {
      final response = await addressRepo.fetchAddresses();
      print('Fetch Addresses Response: ${response.toJson()}');
      emit(FetchAddressesSuccessState(viewAddresses: response));
    } catch (e) {
      print('Error fetching addresses: $e');
      emit(FetchAddressesErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteAddress(
      DeleteAddressEvent event, Emitter<AddressState> emit) async {
    emit(DeleteAddressLoadingState());
    try {
      final response =
          await addressRepo.deleteAddress(addressId: event.addressId);
      print('Delete Address Response: ${response.toJson()}');
      emit(DeleteAddressSuccessState(deleteAddress: response));
      add(FetchAddressesEvent());
    } catch (e) {
      print('Error deleting address: $e');
      emit(DeleteAddressErrorState(message: e.toString()));
    }
  }

  Future<void> _onEditAddress(
      EditAddressEvent event, Emitter<AddressState> emit) async {
    emit(EditAddressLoadingState());
    try {
      final response = await addressRepo.editAddress(
        addressId: event.addressId,
        name: event.name,
        addressPhone:
            event.phone, // ضفنا addressPhone (باسم phone في EditAddressEvent)
        city: event.city,
        street: event.street,
        lat: event.lat,
        long: event.long,
      );
      print('Edit Address Response: ${response.toJson()}');
      emit(EditAddressSuccessState(editAddresses: response));
      add(FetchAddressesEvent());
    } catch (e) {
      print('Error editing address: $e');
      emit(EditAddressErrorState(message: e.toString()));
    }
  }
}
