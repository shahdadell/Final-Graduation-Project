class ResetPasswordResponse {
  String? status;

  ResetPasswordResponse({this.status});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
