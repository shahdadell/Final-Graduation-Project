/// status : "success"
/// message : "Account verified successfully."

class VerfiyCodeResponse {
  VerfiyCodeResponse({
    this.status,
    this.message,
  });

  VerfiyCodeResponse.fromJson(dynamic json) {
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
