class RemoveFavIcon {
  String? status;

  RemoveFavIcon({this.status});

  factory RemoveFavIcon.fromJson(Map<String, dynamic> json) => RemoveFavIcon(
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
