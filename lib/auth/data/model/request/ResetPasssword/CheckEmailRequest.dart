/// email : "abdoahmed@example.com"

class CheckEmailRequest {
  CheckEmailRequest({
    this.email,
  });

  CheckEmailRequest.fromJson(dynamic json) {
    email = json['email'];
  }
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    return map;
  }
}
