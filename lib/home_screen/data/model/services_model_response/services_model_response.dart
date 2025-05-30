import 'package:graduation_project/home_screen/data/model/services_model_response/service_model.dart';

class ServicesModelResponse {
  String? status;
  List<ServiceModel>? data;

  ServicesModelResponse({this.status, this.data});

  factory ServicesModelResponse.fromJson(Map<String, dynamic> json) {
    return ServicesModelResponse(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}

// import 'ServiceModel.dart';

// class ServicesModelResponse {
//   String? status;
//   List<ServiceModel>? data;

//   ServicesModelResponse({this.status, this.data});

//   factory ServicesModelResponse.fromJson(Map<String, dynamic> json) {
//     return ServicesModelResponse(
//       status: json['status'] as String?,
//       data: (json['data'] as List<dynamic>?)
//           ?.map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'data': data?.map((e) => e.toJson()).toList(),
//       };
// }
