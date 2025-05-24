import 'datumOrderDetails.dart';

class DetailsResponse {
  String? status;
  List<Datumorderdetails>? data;

  DetailsResponse({this.status, this.data});

  factory DetailsResponse.fromJson(Map<String, dynamic> json) {
    return DetailsResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datumorderdetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
