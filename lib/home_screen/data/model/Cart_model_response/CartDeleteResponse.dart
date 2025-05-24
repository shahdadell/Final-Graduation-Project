/// success : true
/// message : "Item quantity decreased"

class CartDeleteResponse {
  CartDeleteResponse({
    this.success,
    this.message,
  });

  CartDeleteResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
  }
  bool? success;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    return map;
  }
}
