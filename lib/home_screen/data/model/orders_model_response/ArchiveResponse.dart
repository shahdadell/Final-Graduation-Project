class ArchiveResponse {
  ArchiveResponse({
    this.status,
    this.data,
  });

  ArchiveResponse.fromJson(dynamic json) {
    status = json['status'] as String?;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        var orderData = Data.fromJson(v);
        // نضيف الشرط ده عشان نضمن إن الأوردرز اللي بتظهر هنا هي اللي orders_status بتاعها 2 بس
        if (orderData.ordersStatus == '2') {
          data?.add(orderData);
        }
      });
    }
  }

  String? status;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    this.ordersId,
    this.ordersUsersid,
    this.ordersAddress,
    this.ordersType,
    this.ordersPricedelivery,
    this.ordersPrice,
    this.ordersTotalprice,
    this.ordersCoupon,
    this.ordersPaymentmethod,
    this.ordersStatus,
    this.ordersDatetime,
    this.addressId,
    this.addressUsersid,
    this.addressName,
    this.addressPhone,
    this.addressCity,
    this.addressStreet,
    this.addressLat,
    this.addressLong,
  });

  Data.fromJson(dynamic json) {
    ordersId = json['orders_id'] as String?;
    ordersUsersid = json['orders_usersid'] as String?;
    ordersAddress = json['orders_address'] as String?;
    ordersType = json['orders_type'] as String?;
    ordersPricedelivery = json['orders_pricedelivery'] as String?;
    ordersPrice = json['orders_price'] as String?;
    ordersTotalprice = json['orders_totalprice'] as String?;
    ordersCoupon = json['orders_coupon'] as String?;
    ordersPaymentmethod = json['orders_paymentmethod'] as String?;
    ordersStatus = json['orders_status'] as String?;
    ordersDatetime = json['orders_datetime'] as String?;
    addressId = json['address_id'] as String?;
    addressUsersid = json['address_usersid'] as String?;
    addressName = json['address_name'] as String?;
    addressPhone = json['address_phone'] as String?;
    addressCity = json['address_city'] as String?;
    addressStreet = json['address_street'] as String?;
    addressLat = json['address_lat'] as String?;
    addressLong = json['address_long'] as String?;
  }

  String? ordersId;
  String? ordersUsersid;
  String? ordersAddress;
  String? ordersType;
  String? ordersPricedelivery;
  String? ordersPrice;
  String? ordersTotalprice;
  String? ordersCoupon;
  String? ordersPaymentmethod;
  String? ordersStatus;
  String? ordersDatetime;
  String? addressId;
  String? addressUsersid;
  String? addressName;
  String? addressPhone;
  String? addressCity;
  String? addressStreet;
  String? addressLat;
  String? addressLong;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['orders_id'] = ordersId;
    map['orders_usersid'] = ordersUsersid;
    map['orders_address'] = ordersAddress;
    map['orders_type'] = ordersType;
    map['orders_pricedelivery'] = ordersPricedelivery;
    map['orders_price'] = ordersPrice;
    map['orders_totalprice'] = ordersTotalprice;
    map['orders_coupon'] = ordersCoupon;
    map['orders_paymentmethod'] = ordersPaymentmethod;
    map['orders_status'] = ordersStatus;
    map['orders_datetime'] = ordersDatetime;
    map['address_id'] = addressId;
    map['address_usersid'] = addressUsersid;
    map['address_name'] = addressName;
    map['address_phone'] = addressPhone;
    map['address_city'] = addressCity;
    map['address_street'] = addressStreet;
    map['address_lat'] = addressLat;
    map['address_long'] = addressLong;
    return map;
  }
}
