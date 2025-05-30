import 'package:graduation_project/home_screen/data/model/category_model/category_datum.dart';

import 'Categorydatum.dart';

class Items {
  String? status;
  List<Categorydatum>? data;

  Items({this.status, this.data});

  factory Items.fromJson(Map<String, dynamic> json) => Items(
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
