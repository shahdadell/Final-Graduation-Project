/// email : "abdoahmed@example.com"
/// password : "newpassword123"

class ResetPasswordRequest {
  ResetPasswordRequest({
    this.email,
    this.password,
  });

  ResetPasswordRequest.fromJson(dynamic json) {
    email = json['email'];
    password = json['password'];
  }
  String? email;
  String? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    return map;
  }
}
