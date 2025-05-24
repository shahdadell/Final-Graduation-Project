class CartEvent {}

class AddToCartEvent extends CartEvent {
  final int userId;
  final int itemId;
  final int quantity;
  final String type;

  AddToCartEvent({
    required this.userId,
    required this.itemId,
    this.quantity = 1,
    required this.type,
  });
}

class GetCartItemCountEvent extends CartEvent {
  final int userId;
  final int itemId;

  GetCartItemCountEvent({
    required this.userId,
    required this.itemId,
  });
}

class FetchCartEvent extends CartEvent {
  final int userId;

  FetchCartEvent({required this.userId});
}

class DeleteCartItemEvent extends CartEvent {
  final int userId;
  final int itemId;
  final String type; // إضافة حقل type

  DeleteCartItemEvent({
    required this.userId,
    required this.itemId,
    required this.type,
  });
}

class CheckCouponEvent extends CartEvent {
  final String couponName;

  CheckCouponEvent({required this.couponName});
}
