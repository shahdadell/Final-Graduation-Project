class DataAddNewAddress {
  String? addressCity;
  String? addressUsersid;
  String? addressName;
  String? addressStreet;
  String? addressLat;
  String? addressLong;

  DataAddNewAddress({
    this.addressCity,
    this.addressUsersid,
    this.addressName,
    this.addressStreet,
    this.addressLat,
    this.addressLong,
  });

  factory DataAddNewAddress.fromJson(Map<String, dynamic> json) =>
      DataAddNewAddress(
        addressCity: json['address_city'] as String?,
        addressUsersid: json['address_usersid'] as String?,
        addressName: json['address_name'] as String?,
        addressStreet: json['address_street'] as String?,
        addressLat: json['address_lat'] as String?,
        addressLong: json['address_long'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'address_city': addressCity,
        'address_usersid': addressUsersid,
        'address_name': addressName,
        'address_street': addressStreet,
        'address_lat': addressLat,
        'address_long': addressLong,
      };
}
