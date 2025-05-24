// import 'Categorydatum.dart';

// class Categories {
//   String? status;
//   List<Categorydatum>? data;

//   Categories({this.status, this.data});

//   factory Categories.fromJson(Map<String, dynamic> json) => Categories(
//         status: json['status'] as String?,
//         data: (json['data'] as List<dynamic>?)
//             ?.map((e) => Categorydatum.fromJson(e as Map<String, dynamic>))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'data': data?.map((e) => e.toJson()).toList(),
//       };
// }
