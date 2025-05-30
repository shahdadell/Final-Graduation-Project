import 'package:graduation_project/home_screen/data/model/category_model/category_model.dart';

import 'items.dart';

class HomeModelResponse {
  String? status;
  CategoryModel? categories;
  Items? items;

  HomeModelResponse({this.status, this.categories, this.items});

  factory HomeModelResponse.fromJson(Map<String, dynamic> json) {
    return HomeModelResponse(
      status: json['status'] as String?,
      categories: json['categories'] == null
          ? null
          : CategoryModel.fromJson(json['categories'] as Map<String, dynamic>),
      items: json['items'] == null
          ? null
          : Items.fromJson(json['items'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'categories': categories?.toJson(),
        'items': items?.toJson(),
      };
}
