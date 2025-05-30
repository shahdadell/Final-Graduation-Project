// import 'ItemItemDatum.dart';

// class ItemModelResponseResponse {
//   String? status;
//   List<ItemItemDatum>? data;

//   ItemModelResponseResponse({this.status, this.data});

//   factory ItemModelResponseResponse.fromJson(Map<String, dynamic> json) {
//     return ItemModelResponseResponse(
//       status: json['status'] as String?,
//       data: (json['data'] as List<dynamic>?)
//           ?.map((e) => ItemItemDatum.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'data': data?.map((e) => e.toJson()).toList(),
//       };
// }


import 'package:graduation_project/home_screen/data/model/item_model_response/Itemdatum.dart';

class ItemModelResponse {
  String? status;
  List<ItemDatum>? data;

  ItemModelResponse({this.status, this.data});

  factory ItemModelResponse.fromJson(Map<String, dynamic> json) => ItemModelResponse(
        status: json['status'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemDatum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
