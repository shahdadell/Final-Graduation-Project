/// status : "success"
/// message : "Account verified successfully."

class OtpResponse {
  OtpResponse({
    this.status,
    this.message,
  });

  OtpResponse.fromJson(dynamic json) {
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
}
