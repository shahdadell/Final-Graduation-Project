class OffersModelResponse {
  String? id;
  String? title;
  String? description;
  String? price;
  String? image;
  String? startDate;
  String? endDate;
  String? serviceId;
  String? serviceName;
  String? serviceNameAr;

  OffersModelResponse({
    this.id,
    this.title,
    this.description,
    this.price,
    this.image,
    this.startDate,
    this.endDate,
    this.serviceId,
    this.serviceName,
    this.serviceNameAr,
  });

  factory OffersModelResponse.fromJson(Map<String, dynamic> json) {
    return OffersModelResponse(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      image: json['image'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      serviceId: json['service_id'] as String?,
      serviceName: json['service_name'] as String?,
      serviceNameAr: json['service_name_ar'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'price': price,
        'image': image,
        'start_date': startDate,
        'end_date': endDate,
        'service_id': serviceId,
        'service_name': serviceName,
        'service_name_ar': serviceNameAr,
      };
}
