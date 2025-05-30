/// status : "error"
/// message : "Email not found."

class CheckEmailError {
  CheckEmailError({
    this.status,
    this.message,
  });

  CheckEmailError.fromJson(dynamic json) {
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
