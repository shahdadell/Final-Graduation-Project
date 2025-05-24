// ignore_for_file: file_names

class LogOutResponse {
  String? status;
  String? message;

  LogOutResponse({this.status, this.message});

  factory LogOutResponse.fromJson(Map<String, dynamic> json) {
    return LogOutResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
