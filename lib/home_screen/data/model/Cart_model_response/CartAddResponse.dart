/// success : true
/// message : "Item added/updated in cart"
/// quantity : 13

class CartAddResponse {
  CartAddResponse({
    this.success,
    this.message,
    this.quantity,
  });

  CartAddResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    quantity = json['quantity'];
  }
  bool? success;
  String? message;
  num? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['quantity'] = quantity;
    return map;
  }
}
