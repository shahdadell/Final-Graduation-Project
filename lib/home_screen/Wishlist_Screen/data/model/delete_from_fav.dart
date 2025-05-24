class DeleteFromFav {
  String? status;

  DeleteFromFav({this.status});

  factory DeleteFromFav.fromJson(Map<String, dynamic> json) => DeleteFromFav(
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
