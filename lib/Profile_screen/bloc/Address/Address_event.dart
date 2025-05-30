abstract class AddressEvent {}

class AddAddressEvent extends AddressEvent {
  final String addressName;
  final String addressPhone;
  final String addressCity;
  final String addressStreet;
  final String addressLat;
  final String addressLong;

  AddAddressEvent({
    required this.addressName,
    required this.addressPhone,
    required this.addressCity,
    required this.addressStreet,
    required this.addressLat,
    required this.addressLong,
  });
}

class FetchAddressesEvent extends AddressEvent {}

class DeleteAddressEvent extends AddressEvent {
  final String addressId;

  DeleteAddressEvent({required this.addressId});
}

class EditAddressEvent extends AddressEvent {
  final String addressId;
  final String name; // غيرنا من addressTitle إلى name
  final String city; // جديد: city
  final String phone;
  final String street; // غيرنا من addressDetails إلى street
  final String lat; // غيرنا من addressLatitude إلى lat
  final String long; // غيرنا من addressLongitude إلى long

  EditAddressEvent({
    required this.addressId,
    required this.name,
    required this.city,
    required this.street,
    required this.lat,
    required this.long,
    required this.phone,
  });
}
