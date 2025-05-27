import 'category_datum.dart';

class CategoryModel {
  String? status;
  List<Categorydatum>? data;

  CategoryModel({this.status, this.data});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    status: json['status'] as String?,
    data: (json['data'] as List<dynamic>?)
        ?.map((e) => Categorydatum.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}