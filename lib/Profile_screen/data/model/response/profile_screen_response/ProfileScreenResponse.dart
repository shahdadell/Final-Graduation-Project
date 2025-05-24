import 'Data.dart';

class ProfileScreenResponse {
  ProfileScreenResponse({
    this.status,
    this.data,
  });

  ProfileScreenResponse.fromJson(dynamic json) {
    status = json['status']?.toString() ?? '';
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? status;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}
