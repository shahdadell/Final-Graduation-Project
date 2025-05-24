/// username : "shoadell"
/// password : "password123"
/// email : "shoadell@gmail.com"
/// phone : "1234567890"

class RegisterRequest {
  RegisterRequest({
    String? username,
    String? password,
    String? email,
    String? phone,
  }) {
    _username = username;
    _password = password;
    _email = email;
    _phone = phone;
  }

  RegisterRequest.fromJson(dynamic json) {
    _username = json['username'];
    _password = json['password'];
    _email = json['email'];
    _phone = json['phone'];
  }
  String? _username;
  String? _password;
  String? _email;
  String? _phone;
  RegisterRequest copyWith({
    String? username,
    String? password,
    String? email,
    String? phone,
  }) =>
      RegisterRequest(
        username: username ?? _username,
        password: password ?? _password,
        email: email ?? _email,
        phone: phone ?? _phone,
      );
  String? get username => _username;
  String? get password => _password;
  String? get email => _email;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['password'] = _password;
    map['email'] = _email;
    map['phone'] = _phone;
    return map;
  }
}
