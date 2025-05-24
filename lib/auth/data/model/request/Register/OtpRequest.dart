class OtpRequest {
  String? email;
  String? verifycode;

  OtpRequest({this.email, this.verifycode});

  factory OtpRequest.fromJson(Map<String, dynamic> json) => OtpRequest(
        email: json['email'] as String?,
        verifycode: json['verifycode'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'verifycode': verifycode,
      };
}
