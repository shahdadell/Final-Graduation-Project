import 'package:graduation_project/auth/data/model/response/Register/registerresponse_new.dart';

import 'AuthResultEntity .dart';

/// status : "success"
/// message : "none"

class CheckEmailResponse {
  CheckEmailResponse({
    this.status,
    this.message,
  });

  CheckEmailResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
  }
  String? status;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    return map;
  }

  AuthResultEntity toAuthResultEntity() {
    return AuthResultEntity();
  }
}
