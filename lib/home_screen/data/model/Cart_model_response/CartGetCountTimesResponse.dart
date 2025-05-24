/// status : "success"
/// quantity : 13

class CartGetCountTimesResponse {
  CartGetCountTimesResponse({
    this.status,
    this.quantity,
  });

  CartGetCountTimesResponse.fromJson(dynamic json) {
    status = json['status'];
    quantity = json['quantity'];
  }
  String? status;
  num? quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['quantity'] = quantity;
    return map;
  }
}
