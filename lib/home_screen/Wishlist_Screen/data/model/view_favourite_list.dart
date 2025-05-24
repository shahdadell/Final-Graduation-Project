import 'datum_View.dart';

class ViewFavouriteList {
  String? status;
  List<DatumViewFav>? data;

  ViewFavouriteList({this.status, this.data});

  factory ViewFavouriteList.fromJson(Map<String, dynamic> json) {
    return ViewFavouriteList(
      status: json['status'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => DatumViewFav.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
