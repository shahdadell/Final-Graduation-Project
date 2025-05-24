/// status : "success"
/// message : "Coupon applied successfully"
/// data : {"coupon_id":"1","coupon_name":"abdo","coupon_count":"360","coupon_discount":"50","coupon_expiredate":"2026-02-19 22:21:27"}

class CouponeResponse {
  CouponeResponse({
    this.status,
    this.message,
    this.data,
  });

  CouponeResponse.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? status;
  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// coupon_id : "1"
/// coupon_name : "abdo"
/// coupon_count : "360"
/// coupon_discount : "50"
/// coupon_expiredate : "2026-02-19 22:21:27"

class Data {
  Data({
    this.couponId,
    this.couponName,
    this.couponCount,
    this.couponDiscount,
    this.couponExpiredate,
  });

  Data.fromJson(dynamic json) {
    couponId = json['coupon_id'];
    couponName = json['coupon_name'];
    couponCount = json['coupon_count'];
    couponDiscount = json['coupon_discount'];
    couponExpiredate = json['coupon_expiredate'];
  }
  String? couponId;
  String? couponName;
  String? couponCount;
  String? couponDiscount;
  String? couponExpiredate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coupon_id'] = couponId;
    map['coupon_name'] = couponName;
    map['coupon_count'] = couponCount;
    map['coupon_discount'] = couponDiscount;
    map['coupon_expiredate'] = couponExpiredate;
    return map;
  }
}
