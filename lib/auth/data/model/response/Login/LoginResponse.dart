class LoginResponse {
  String? status;
  String? message;
  int? userId; // غيرنا من String? لـ int?
  String? accessToken;
  String? refreshToken;

  LoginResponse({
    this.status,
    this.message,
    this.userId,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
        userId: int.tryParse(json['user_id']?.toString() ?? '0') ??
            0, // تحويل من String لـ int
        accessToken: json['access_token'] as String?,
        refreshToken: json['refresh_token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'user_id': userId,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
