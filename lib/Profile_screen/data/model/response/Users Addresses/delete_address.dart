class DeleteAddress {
  String? status;

  DeleteAddress({this.status});

  factory DeleteAddress.fromJson(Map<String, dynamic> json) => DeleteAddress(
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
