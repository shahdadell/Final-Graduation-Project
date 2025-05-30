abstract class OrderEvent {}

class CheckoutEvent extends OrderEvent {
  final int userId;
  final int addressId;
  final int orderstype;
  final double priceDelivery;
  final double ordersPrice;
  final int? couponId;
  final int paymentMethod;
  final double couponDiscount;

  CheckoutEvent({
    required this.userId,
    required this.addressId,
    required this.orderstype,
    required this.priceDelivery,
    required this.ordersPrice,
    this.couponId,
    required this.paymentMethod,
    required this.couponDiscount,
  });
}

class FetchPendingOrdersEvent extends OrderEvent {
  final int userId;

  FetchPendingOrdersEvent({required this.userId});
}

class FetchArchivedOrdersEvent extends OrderEvent {
  final int userId;

  FetchArchivedOrdersEvent({required this.userId});
}

class FetchOrderDetailsEvent extends OrderEvent {
  final String ordersId;

  FetchOrderDetailsEvent({required this.ordersId});
}

class ArchiveOrderEvent extends OrderEvent {
  final String orderId;
  final int userId;

  ArchiveOrderEvent({required this.orderId, required this.userId});
}

class DeleteOrderEvent extends OrderEvent {
  final String orderId;
  final int userId;

  DeleteOrderEvent({required this.orderId, required this.userId});
}
