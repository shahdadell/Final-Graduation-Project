import 'datumViewAddress.dart';

class ViewAddresses {
  String? status;
  List<DatumViewAddress>? data;

  ViewAddresses({this.status, this.data});

  factory ViewAddresses.fromJson(Map<String, dynamic> json) => ViewAddresses(
        status: json['status'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => DatumViewAddress.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
