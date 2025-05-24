/// email : "abdoahmed@example.com"
/// verifycode : "12345"

class OtpScreenForgetPassword {
  OtpScreenForgetPassword({
    this.email,
    this.verifycode,
  });

  OtpScreenForgetPassword.fromJson(dynamic json) {
    email = json['email'];
    verifycode = json['verifycode'];
  }
  String? email;
  String? verifycode;

  Map<String, dynamic> toJson() => {
        'email': email,
        'verifycode': verifycode,
      };
}
