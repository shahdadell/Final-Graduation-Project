class ItemModel {
  int? serviceId; // غيرناه لـ int? لأنه رقم
  String? serviceName;
  String? serviceNameAr;
  String? serviceDescription;
  String? serviceDescriptionAr;
  String? serviceImage;
  String? serviceLocation;
  double? serviceRating; // غيرناه لـ double? لأنه ممكن يكون عشري (زي 4.2)
  String? servicePhone;
  String? serviceEmail;
  String? serviceWebsite;
  String? serviceType;
  int? serviceCat; // غيرناه لـ int? لأنه رقم
  int? serviceActive; // غيرناه لـ int? لأنه 0 أو 1
  String? serviceCreated;
  int? itemsId; // غيرناه لـ int? لأنه رقم
  String? itemsName;
  String? itemsNameAr;
  String? itemsDes;
  String? itemsDesAr;
  String? itemsImage;
  int? itemsCount; // غيرناه لـ int? لأنه رقم
  int? itemsActive; // غيرناه لـ int? لأنه 0 أو 1
  double? itemsPrice; // غيرناه لـ double? لأنه ممكن يكون عشري
  double? itemsDiscount; // غيرناه لـ double? لأنه ممكن يكون عشري
  String? itemsDate;
  int? itemsCat; // غيرناه لـ int? لأنه رقم
  int? favorite; // غيرناه لـ int? لأنه 0 أو 1

  ItemModel({
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
    this.favorite,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        serviceId: int.tryParse(json['service_id']?.toString() ?? '') ?? 0,
        serviceName: json['service_name'] as String?,
        serviceNameAr: json['service_name_ar'] as String?,
        serviceDescription: json['service_description'] as String?,
        serviceDescriptionAr: json['service_description_ar'] as String?,
        serviceImage: json['service_image'] as String?,
        serviceLocation: json['service_location'] as String?,
        serviceRating:
            double.tryParse(json['service_rating']?.toString() ?? '') ?? 0.0,
        servicePhone: json['service_phone'] as String?,
        serviceEmail: json['service_email'] as String?,
        serviceWebsite: json['service_website'] as String?,
        serviceType: json['service_type'] as String?,
        serviceCat: int.tryParse(json['service_cat']?.toString() ?? '') ?? 0,
        serviceActive:
            int.tryParse(json['service_active']?.toString() ?? '') ?? 0,
        serviceCreated: json['service_created'] as String?,
        itemsId: int.tryParse(json['items_id']?.toString() ?? '') ?? 0,
        itemsName: json['items_name'] as String?,
        itemsNameAr: json['items_name_ar'] as String?,
        itemsDes: json['items_des'] as String?,
        itemsDesAr: json['items_des_ar'] as String?,
        itemsImage: json['items_image'] as String?,
        itemsCount: int.tryParse(json['items_count']?.toString() ?? '') ?? 0,
        itemsActive: int.tryParse(json['items_active']?.toString() ?? '') ?? 0,
        itemsPrice:
            double.tryParse(json['items_price']?.toString() ?? '') ?? 0.0,
        itemsDiscount:
            double.tryParse(json['items_discount']?.toString() ?? '') ?? 0.0,
        itemsDate: json['items_date'] as String?,
        itemsCat: int.tryParse(json['items_cat']?.toString() ?? '') ?? 0,
        favorite: int.tryParse(json['favorite']?.toString() ?? '') ?? 0,
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
        'favorite': favorite,
      };
}
