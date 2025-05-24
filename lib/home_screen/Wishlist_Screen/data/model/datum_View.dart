class DatumViewFav {
  String? favoriteId;
  String? favoriteUsersid;
  String? favoriteItemsid;
  String? itemsId;
  String? serviceId;
  String? itemsName;
  String? itemsNameAr;
  String? itemsDes;
  String? itemsDesAr;
  String? itemsImage;
  String? itemsCount;
  String? itemsActive;
  String? itemsPrice;
  String? itemsDiscount;
  String? itemsDate;
  String? itemsCat;
  String? usersId;

  DatumViewFav({
    this.favoriteId,
    this.favoriteUsersid,
    this.favoriteItemsid,
    this.itemsId,
    this.serviceId,
    this.itemsName,
    this.itemsNameAr,
    this.itemsDes,
    this.itemsDesAr,
    this.itemsImage,
    this.itemsCount,
    this.itemsActive,
    this.itemsPrice,
    this.itemsDiscount,
    this.itemsDate,
    this.itemsCat,
    this.usersId,
  });

  factory DatumViewFav.fromJson(Map<String, dynamic> json) => DatumViewFav(
        favoriteId: json['favorite_id'] as String?,
        favoriteUsersid: json['favorite_usersid'] as String?,
        favoriteItemsid: json['favorite_itemsid'] as String?,
        itemsId: json['items_id'] as String?,
        serviceId: json['service_id'] as String?,
        itemsName: json['items_name'] as String?,
        itemsNameAr: json['items_name_ar'] as String?,
        itemsDes: json['items_des'] as String?,
        itemsDesAr: json['items_des_ar'] as String?,
        itemsImage: json['items_image'] as String?,
        itemsCount: json['items_count'] as String?,
        itemsActive: json['items_active'] as String?,
        itemsPrice: json['items_price'] as String?,
        itemsDiscount: json['items_discount'] as String?,
        itemsDate: json['items_date'] as String?,
        itemsCat: json['items_cat'] as String?,
        usersId: json['users_id'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'favorite_id': favoriteId,
        'favorite_usersid': favoriteUsersid,
        'favorite_itemsid': favoriteItemsid,
        'items_id': itemsId,
        'service_id': serviceId,
        'items_name': itemsName,
        'items_name_ar': itemsNameAr,
        'items_des': itemsDes,
        'items_des_ar': itemsDesAr,
        'items_image': itemsImage,
        'items_count': itemsCount,
        'items_active': itemsActive,
        'items_price': itemsPrice,
        'items_discount': itemsDiscount,
        'items_date': itemsDate,
        'items_cat': itemsCat,
        'users_id': usersId,
      };
}
