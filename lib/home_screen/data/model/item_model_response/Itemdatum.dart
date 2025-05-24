class ItemDatum {
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
  String? serviceIsDeleted;
  dynamic serviceDeletedAt;
  String? itemsId;
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
  String? itemsIsDeleted;
  dynamic itemsDeletedAt;
  String? favorite;

  ItemDatum({
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
    this.serviceIsDeleted,
    this.serviceDeletedAt,
    this.itemsId,
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
    this.itemsIsDeleted,
    this.itemsDeletedAt,
    this.favorite,
  });

  factory ItemDatum.fromJson(Map<String, dynamic> json) => ItemDatum(
        serviceId: json['service_id'] as String?,
        serviceName: json['service_name'] as String?,
        serviceNameAr: json['service_name_ar'] as String?,
        serviceDescription: json['service_description'] as String?,
        serviceDescriptionAr: json['service_description_ar'] as String?,
        serviceImage: json['service_image'] as String?,
        serviceLocation: json['service_location'] as String?,
        serviceRating: json['service_rating'] as String?,
        servicePhone: json['service_phone'] as String?,
        serviceEmail: json['service_email'] as String?,
        serviceWebsite: json['service_website'] as String?,
        serviceType: json['service_type'] as String?,
        serviceCat: json['service_cat'] as String?,
        serviceActive: json['service_active'] as String?,
        serviceCreated: json['service_created'] as String?,
        serviceIsDeleted: json['service_is_deleted'] as String?,
        serviceDeletedAt: json['service_deleted_at'] as dynamic,
        itemsId: json['items_id'] as String?,
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
        itemsIsDeleted: json['items_is_deleted'] as String?,
        itemsDeletedAt: json['items_deleted_at'] as dynamic,
        favorite: json['favorite'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'service_id': serviceId,
        'service_name': serviceName,
        'service_name_ar': serviceNameAr,
        'service_description': serviceDescription,
        'service_description_ar': serviceDescriptionAr,
        'service_image': serviceImage,
        'service_location': serviceLocation,
        'service_rating': serviceRating,
        'service_phone': servicePhone,
        'service_email': serviceEmail,
        'service_website': serviceWebsite,
        'service_type': serviceType,
        'service_cat': serviceCat,
        'service_active': serviceActive,
        'service_created': serviceCreated,
        'service_is_deleted': serviceIsDeleted,
        'service_deleted_at': serviceDeletedAt,
        'items_id': itemsId,
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
        'items_is_deleted': itemsIsDeleted,
        'items_deleted_at': itemsDeletedAt,
        'favorite': favorite,
      };
}

// class ItemItemDatum {
//   int? serviceId;
//   String? serviceName;
//   String? serviceNameAr;
//   String? serviceDescription;
//   String? serviceDescriptionAr;
//   String? serviceImage;
//   String? serviceLocation;
//   double? serviceRating;
//   String? servicePhone;
//   String? serviceEmail;
//   String? serviceWebsite;
//   String? serviceType;
//   int? serviceCat;
//   int? serviceActive;
//   String? serviceCreated;
//   int? itemsId;
//   String? itemsName;
//   String? itemsNameAr;
//   String? itemsDes;
//   String? itemsDesAr;
//   String? itemsImage;
//   int? itemsCount;
//   int? itemsActive;
//   double? itemsPrice;
//   double? itemsDiscount;
//   String? itemsDate;
//   int? itemsCat;
//   int? favorite;

//   ItemItemDatum({
//     this.serviceId,
//     this.serviceName,
//     this.serviceNameAr,
//     this.serviceDescription,
//     this.serviceDescriptionAr,
//     this.serviceImage,
//     this.serviceLocation,
//     this.serviceRating,
//     this.servicePhone,
//     this.serviceEmail,
//     this.serviceWebsite,
//     this.serviceType,
//     this.serviceCat,
//     this.serviceActive,
//     this.serviceCreated,
//     this.itemsId,
//     this.itemsName,
//     this.itemsNameAr,
//     this.itemsDes,
//     this.itemsDesAr,
//     this.itemsImage,
//     this.itemsCount,
//     this.itemsActive,
//     this.itemsPrice,
//     this.itemsDiscount,
//     this.itemsDate,
//     this.itemsCat,
//     this.favorite,
//   });

//   factory ItemItemDatum.fromJson(Map<String, dynamic> json) {
//     // تحويل القيم لـ String أولاً بأمان
//     String? safeParse(String? value) => value?.toString();

//     return ItemItemDatum(
//       serviceId: int.tryParse(safeParse(json['service_id']) ?? '') ?? 0,
//       serviceName: json['service_name'] as String?,
//       serviceNameAr: json['service_name_ar'] as String?,
//       serviceDescription: json['service_description'] as String?,
//       serviceDescriptionAr: json['service_description_ar'] as String?,
//       serviceImage: json['service_image'] as String?,
//       serviceLocation: json['service_location'] as String?,
//       serviceRating:
//           double.tryParse(safeParse(json['service_rating']) ?? '') ?? 0.0,
//       servicePhone: json['service_phone'] as String?,
//       serviceEmail: json['service_email'] as String?,
//       serviceWebsite: json['service_website'] as String?,
//       serviceType: json['service_type'] as String?,
//       serviceCat: int.tryParse(safeParse(json['service_cat']) ?? '') ?? 0,
//       serviceActive: int.tryParse(safeParse(json['service_active']) ?? '') ?? 0,
//       serviceCreated: json['service_created'] as String?,
//       itemsId: int.tryParse(safeParse(json['items_id']) ?? '') ?? 0,
//       itemsName: json['items_name'] as String?,
//       itemsNameAr: json['items_name_ar'] as String?,
//       itemsDes: json['items_des'] as String?,
//       itemsDesAr: json['items_des_ar'] as String?,
//       itemsImage: json['items_image'] as String?,
//       itemsCount: int.tryParse(safeParse(json['items_count']) ?? '') ?? 0,
//       itemsActive: int.tryParse(safeParse(json['items_active']) ?? '') ?? 0,
//       itemsPrice: double.tryParse(safeParse(json['items_price']) ?? '') ?? 0.0,
//       itemsDiscount:
//           double.tryParse(safeParse(json['items_discount']) ?? '') ?? 0.0,
//       itemsDate: json['items_date'] as String?,
//       itemsCat: int.tryParse(safeParse(json['items_cat']) ?? '') ?? 0,
//       favorite: int.tryParse(safeParse(json['favorite']) ?? '') ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'service_id': serviceId,
//         'service_name': serviceName,
//         'service_name_ar': serviceNameAr,
//         'service_description': serviceDescription,
//         'service_description_ar': serviceDescriptionAr,
//         'service_image': serviceImage,
//         'service_location': serviceLocation,
//         'service_rating': serviceRating,
//         'service_phone': servicePhone,
//         'service_email': serviceEmail,
//         'service_website': serviceWebsite,
//         'service_type': serviceType,
//         'service_cat': serviceCat,
//         'service_active': serviceActive,
//         'service_created': serviceCreated,
//         'items_id': itemsId,
//         'items_name': itemsName,
//         'items_name_ar': itemsNameAr,
//         'items_des': itemsDes,
//         'items_des_ar': itemsDesAr,
//         'items_image': itemsImage,
//         'items_count': itemsCount,
//         'items_active': itemsActive,
//         'items_price': itemsPrice,
//         'items_discount': itemsDiscount,
//         'items_date': itemsDate,
//         'items_cat': itemsCat,
//         'favorite': favorite,
//       };
// }
