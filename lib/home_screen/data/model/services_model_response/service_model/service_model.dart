// import 'datum.dart';

// class ServiceModel {
//   String? status;
//   List<Datum>? data;

//   ServiceModel({this.status, this.data});

//   factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
//         status: json['status'] as String?,
//         data: (json['data'] as List<dynamic>?)
//             ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'data': data?.map((e) => e.toJson()).toList(),
//       };
// }
