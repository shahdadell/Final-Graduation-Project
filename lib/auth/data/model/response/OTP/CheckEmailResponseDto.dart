import 'package:graduation_project/auth/data/model/response/Login/LoginResponse.dart';

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

  LoginResponse toAuthResultEntity() {
    return LoginResponse();
  }
}
