/// status : "success"
/// data : [{"orders_id":"169","orders_usersid":"890","orders_address":"7","orders_type":"1","orders_pricedelivery":"0","orders_price":"45","orders_totalprice":"22.5","orders_coupon":"1","orders_paymentmethod":"0","orders_status":"0","orders_datetime":"2025-04-24 09:48:54","address_id":"7","address_usersid":"136","address_name":"abdo ah,ed","address_phone":"416354","address_city":"nkl","address_street":"gh","address_lat":"0","address_long":"0"},{"orders_id":"163","orders_usersid":"890","orders_address":"104","orders_type":"0","orders_pricedelivery":"10","orders_price":"601","orders_totalprice":"610.5","orders_coupon":"0","orders_paymentmethod":"0","orders_status":"0","orders_datetime":"2025-04-23 21:39:21","address_id":"104","address_usersid":"890","address_name":"AL fayoum","address_phone":"0","address_city":"Alfayoum","address_street":"Alfayoum","address_lat":"0","address_long":"0"}]

class PendingResponse {
  PendingResponse({
    this.status,
    this.data,
  });

  PendingResponse.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        var orderData = Data.fromJson(v);
        // نضيف الشرط ده عشان نضمن إن الأوردرز اللي بتظهر هنا هي اللي orders_status بتاعها 0 بس
        if (orderData.ordersStatus == '0') {
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

/// orders_id : "169"
/// orders_usersid : "890"
/// orders_address : "7"
/// orders_type : "1"
/// orders_pricedelivery : "0"
/// orders_price : "45"
/// orders_totalprice : "22.5"
/// orders_coupon : "1"
/// orders_paymentmethod : "0"
/// orders_status : "0"
/// orders_datetime : "2025-04-24 09:48:54"
/// address_id : "7"
/// address_usersid : "136"
/// address_name : "abdo ah,ed"
/// address_phone : "416354"
/// address_city : "nkl"
/// address_street : "gh"
/// address_lat : "0"
/// address_long : "0"

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
    ordersId = json['orders_id'];
    ordersUsersid = json['orders_usersid'];
    ordersAddress = json['orders_address'];
    ordersType = json['orders_type'];
    ordersPricedelivery = json['orders_pricedelivery'];
    ordersPrice = json['orders_price'];
    ordersTotalprice = json['orders_totalprice'];
    ordersCoupon = json['orders_coupon'];
    ordersPaymentmethod = json['orders_paymentmethod'];
    ordersStatus = json['orders_status'];
    ordersDatetime = json['orders_datetime'];
    addressId = json['address_id'];
    addressUsersid = json['address_usersid'];
    addressName = json['address_name'];
    addressPhone = json['address_phone'];
    addressCity = json['address_city'];
    addressStreet = json['address_street'];
    addressLat = json['address_lat'];
    addressLong = json['address_long'];
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
