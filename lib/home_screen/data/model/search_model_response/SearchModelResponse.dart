class SearchModelResponse {
  SearchModelResponse({
    this.status,
    this.items,
    this.services,
  });

  SearchModelResponse.fromJson(dynamic json) {
    status = json['status'];
    items = json['items'] != null ? Items.fromJson(json['items']) : null;
    services =
        json['services'] != null ? Services.fromJson(json['services']) : null;
  }
  String? status;
  Items? items;
  Services? services;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (items != null) {
      map['items'] = items?.toJson();
    }
    if (services != null) {
      map['services'] = services?.toJson();
    }
    return map;
  }
}

class Services {
  Services({
    this.status,
    this.data,
  });

  Services.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
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
    this.serviceId,
    this.serviceName,
    this.serviceNameAr,
    this.serviceDescription,
    this.serviceDescriptionAr,
    this.serviceImage,
    this.serviceLocation,
    this.serviceRating,
    this.servicePhone,
    this.serviceEmail,
    this.serviceWebsite,
    this.serviceType,
    this.serviceCat,
    this.serviceActive,
    this.serviceCreated,
  });

  Data.fromJson(dynamic json) {
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    serviceNameAr = json['service_name_ar'];
    serviceDescription = json['service_description'];
    serviceDescriptionAr = json['service_description_ar'];
    serviceImage = json['service_image'];
    serviceLocation = json['service_location'];
    serviceRating = json['service_rating'];
    servicePhone = json['service_phone'];
    serviceEmail = json['service_email'];
    serviceWebsite = json['service_website'];
    serviceType = json['service_type'];
    serviceCat = json['service_cat'];
    serviceActive = json['service_active'];
    serviceCreated = json['service_created'];
  }
  String? serviceId;
  String? serviceName;
  String? serviceNameAr;
  String? serviceDescription;
  String? serviceDescriptionAr;
  String? serviceImage;
  String? serviceLocation;
  String? serviceRating;
  String? servicePhone;
  String? serviceEmail;
  String? serviceWebsite;
  String? serviceType;
  String? serviceCat;
  String? serviceActive;
  String? serviceCreated;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = serviceId;
    map['service_name'] = serviceName;
    map['service_name_ar'] = serviceNameAr;
    map['service_description'] = serviceDescription;
    map['service_description_ar'] = serviceDescriptionAr;
    map['service_image'] = serviceImage;
    map['service_location'] = serviceLocation;
    map['service_rating'] = serviceRating;
    map['service_phone'] = servicePhone;
    map['service_email'] = serviceEmail;
    map['service_website'] = serviceWebsite;
    map['service_type'] = serviceType;
    map['service_cat'] = serviceCat;
    map['service_active'] = serviceActive;
    map['service_created'] = serviceCreated;
    return map;
  }
}

class Items {
  Items({
    this.status,
    this.data,
  });

  Items.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ItemData.fromJson(v));
      });
    }
  }
  String? status;
  List<ItemData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ItemData {
  ItemData({
    this.itemsId,
    this.serviceId,
    this.itemsName,
    this.itemsNameAr,
    this.itemsDescription,
    this.itemsDescriptionAr,
    this.itemsImage,
    this.itemsCount,
    this.itemsActive,
    this.itemsPrice,
    this.itemsDiscount,
    this.itemsDate,
    this.itemsCat,
  });

  ItemData.fromJson(dynamic json) {
    itemsId = json['items_id'];
    serviceId = json['service_id'];
    itemsName = json['items_name'];
    itemsNameAr = json['items_name_ar'];
    itemsDescription = json['items_description'];
    itemsDescriptionAr = json['items_description_ar'];
    itemsImage = json['items_image'];
    itemsCount = json['items_count'];
    itemsActive = json['items_active'];
    itemsPrice = json['items_price'];
    itemsDiscount = json['items_discount'];
    itemsDate = json['items_date'];
    itemsCat = json['items_cat'];
  }

  String? itemsId;
  String? serviceId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDescription;
  String? itemsDescriptionAr;
  String? itemsImage;
  String? itemsCount;
  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;
  String? itemsDate;
  String? itemsCat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['items_id'] = itemsId;
    map['service_id'] = serviceId;
    map['items_name'] = itemsName;
    map['items_name_ar'] = itemsNameAr;
    map['items_description'] = itemsDescription;
    map['items_description_ar'] = itemsDescriptionAr;
    map['items_image'] = itemsImage;
    map['items_count'] = itemsCount;
    map['items_active'] = itemsActive;
    map['items_price'] = itemsPrice;
    map['items_discount'] = itemsDiscount;
    map['items_date'] = itemsDate;
    map['items_cat'] = itemsCat;
    return map;
  }
}
