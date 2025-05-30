// ignore_for_file: file_names

class DatumViewAddress {
  String? addressId;
  String? addressUsersid;
  String? addressName;
  String? addressPhone;
  String? addressCity;
  String? addressStreet;
  String? addressLat;
  String? addressLong;

  DatumViewAddress({
    this.addressId,
    this.addressUsersid,
    this.addressName,
    this.addressPhone,
    this.addressCity,
    this.addressStreet,
    this.addressLat,
    this.addressLong,
  });

  factory DatumViewAddress.fromJson(Map<String, dynamic> json) =>
      DatumViewAddress(
        addressId: json['address_id'] as String?,
        addressUsersid: json['address_usersid'] as String?,
        addressName: json['address_name'] as String?,
        addressPhone: json['address_phone'] as String?,
        addressCity: json['address_city'] as String?,
        addressStreet: json['address_street'] as String?,
        addressLat: json['address_lat'] as String?,
        addressLong: json['address_long'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address_id': addressId,
        'address_usersid': addressUsersid,
        'address_name': addressName,
        'address_phone': addressPhone,
        'address_city': addressCity,
        'address_street': addressStreet,
        'address_lat': addressLat,
        'address_long': addressLong,
      };
}
