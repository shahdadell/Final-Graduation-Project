class LoginError {
  String? status;
  String? message;

  LoginError({this.status, this.message});

  factory LoginError.fromJson(Map<String, dynamic> json) => LoginError(
        status: json['status'] as String?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
