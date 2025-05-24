import 'category_datum.dart';

class CategoryModel {
  String? status;
  List<Categorydatum>? data;
  dynamic categories; // للتعامل مع int أو List

  CategoryModel({this.status, this.data, this.categories});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        status: json['status'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Categorydatum.fromJson(e as Map<String, dynamic>))
            .toList(),
        categories: json['categories'], // يمكن يكون int أو List
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data?.map((e) => e.toJson()).toList(),
        'categories': categories,
      };
}