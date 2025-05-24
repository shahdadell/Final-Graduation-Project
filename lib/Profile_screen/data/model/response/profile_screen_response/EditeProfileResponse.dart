import 'Data.dart';

class EditeProfileResponse {
  EditeProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  EditeProfileResponse.fromJson(dynamic json) {
    status = json['status']?.toString() ?? '';
    message = json['message']?.toString();
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson;
    }
    return map;
  }
}
