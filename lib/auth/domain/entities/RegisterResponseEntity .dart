/// status : "success"
/// message : "User registered successfully. Please check your email to complete the registration."

class RegisterResponseEntity {
  RegisterResponseEntity({
    String? status,
    String? message,
  }) {
    _status = status;
    _message = message;
  }

  String? _status;
  String? _message;
  RegisterResponseEntity copyWith({
    String? status,
    String? message,
  }) =>
      RegisterResponseEntity(
        status: status ?? _status,
        message: message ?? _message,
      );
  String? get status => _status;
  String? get message => _message;
}
