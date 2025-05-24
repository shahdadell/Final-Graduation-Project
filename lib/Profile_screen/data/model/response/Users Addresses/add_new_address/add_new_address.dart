import 'data_add_address.dart';

class AddNewAddress {
  String? status;
  String? message;
  DataAddNewAddress? data;

  AddNewAddress({this.status, this.message, this.data});

  factory AddNewAddress.fromJson(Map<String, dynamic> json) => AddNewAddress(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: json['data'] == null
            ? null
            : DataAddNewAddress.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}
