/// status : "failure"
/// message : "Email or phone number already exists"

class RegisterError {
  RegisterError({
    String? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  RegisterError.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  String? _status;
  String? _message;
  RegisterError copyWith({
    String? status,
    String? message,
  }) =>
      RegisterError(
        status: status ?? _status,
        message: message ?? _message,
      );
  String? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }
}
