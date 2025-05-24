import 'AuthResultEntity .dart';

/// status : "success"
/// message : "none"

class LoginResponseEntity {
  LoginResponseEntity({
    this.status,
    this.message,
  });

  String? status;
  String? message;

  AuthResultEntity toAuthResultEntity() {
    return AuthResultEntity();
  }
}
