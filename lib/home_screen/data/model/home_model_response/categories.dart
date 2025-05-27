class Categorydatum {
  String? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImage;
  String? categoriesDatetime;
  String? isDeleted; // إضافة الحقل الجديد
  String? deletedAt; // إضافة الحقل الجديد

  Categorydatum({
    this.categoriesId,
    this.categoriesName,
    this.categoriesNameAr,
    this.categoriesImage,
    this.categoriesDatetime,
    this.isDeleted,
    this.deletedAt,
  });

  factory Categorydatum.fromJson(Map<String, dynamic> json) => Categorydatum(
    categoriesId: json['categories_id'] as String?,
    categoriesName: json['categories_name'] as String?,
    categoriesNameAr: json['categories_name_ar'] as String?,
    categoriesImage: json['categories_image'] as String?,
    categoriesDatetime: json['categories_datetime'] as String?,
    isDeleted: json['is_deleted'] as String?, // إضافة
    deletedAt: json['deleted_at'] as String?, // إضافة
  );

  Map<String, dynamic> toJson() => {
    'categories_id': categoriesId,
    'categories_name': categoriesName,
    'categories_name_ar': categoriesNameAr,
    'categories_image': categoriesImage,
    'categories_datetime': categoriesDatetime,
    'is_deleted': isDeleted, // إضافة
    'deleted_at': deletedAt, // إضافة
  };
}