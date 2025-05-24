import 'datacart.dart';

class CartViewResponse {
  CartViewResponse({
    this.status,
    this.restCafe,
    this.hotelTourist,
    this.otherCategories,
    this.offers,
  });

  CartViewResponse.fromJson(dynamic json) {
    status = json['status'];
    restCafe =
        json['rest_cafe'] != null ? RestCafe.fromJson(json['rest_cafe']) : null;
    hotelTourist = json['hotel_tourist'] != null
        ? HotelTourist.fromJson(json['hotel_tourist'])
        : null;
    if (json['other_categories'] != null) {
      otherCategories = [];
      json['other_categories'].forEach((v) {
        otherCategories?.add(v);
      });
    }
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((v) {
        offers?.add(Datacart.fromJson(v));
      });
    }
  }

  String? status;
  RestCafe? restCafe;
  HotelTourist? hotelTourist;
  List<dynamic>? otherCategories;
  List<Datacart>? offers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (restCafe != null) {
      map['rest_cafe'] = restCafe?.toJson();
    }
    if (hotelTourist != null) {
      map['hotel_tourist'] = hotelTourist?.toJson();
    }
    if (otherCategories != null) {
      map['other_categories'] = otherCategories;
    }
    if (offers != null) {
      map['offers'] = offers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class HotelTourist {
  HotelTourist({
    this.countprice,
    this.datacart,
  });

  HotelTourist.fromJson(dynamic json) {
    countprice = json['countprice'] != null
        ? Countprice.fromJson(json['countprice'])
        : null;
    if (json['datacart'] != null) {
      datacart = [];
      json['datacart'].forEach((v) {
        datacart?.add(Datacart.fromJson(v));
      });
    }
  }

  Countprice? countprice;
  List<Datacart>? datacart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (countprice != null) {
      map['countprice'] = countprice?.toJson();
    }
    if (datacart != null) {
      map['datacart'] = datacart?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Countprice {
  Countprice({
    this.totalprice,
    this.totalcount,
  });

  Countprice.fromJson(dynamic json) {
    totalprice = json['totalprice'];
    totalcount = json['totalcount'];
  }

  String? totalprice;
  String? totalcount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalprice'] = totalprice;
    map['totalcount'] = totalcount;
    return map;
  }
}

class RestCafe {
  RestCafe({
    this.countprice,
    this.datacart,
  });

  RestCafe.fromJson(dynamic json) {
    countprice = json['countprice'] != null
        ? Countprice.fromJson(json['countprice'])
        : null;
    if (json['datacart'] != null) {
      datacart = [];
      json['datacart'].forEach((v) {
        datacart?.add(Datacart.fromJson(v));
      });
    }
  }

  Countprice? countprice;
  List<Datacart>? datacart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (countprice != null) {
      map['countprice'] = countprice?.toJson();
    }
    if (datacart != null) {
      map['datacart'] = datacart?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
