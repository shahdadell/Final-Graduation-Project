class AddtoFavourite {
  String? status;
  String? message;

  AddtoFavourite({this.status, this.message});

  factory AddtoFavourite.fromJson(Map<String, dynamic> json) {
    return AddtoFavourite(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
