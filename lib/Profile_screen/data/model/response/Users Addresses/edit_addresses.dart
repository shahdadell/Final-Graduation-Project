class EditAddresses {
  String? status;

  EditAddresses({this.status});

  factory EditAddresses.fromJson(Map<String, dynamic> json) => EditAddresses(
        status: json['status'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
