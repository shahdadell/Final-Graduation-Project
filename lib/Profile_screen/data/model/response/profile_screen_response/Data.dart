class Data {
  Data({
    this.usersId,
    this.usersName,
    this.usersPassword,
    this.usersEmail,
    this.usersPhone,
    this.usersVerfiycode,
    this.usersApprove,
    this.usersCreate,
    this.usersImage,
  });

  Data.fromJson(dynamic json) {
    usersId = json['users_id']?.toString();
    usersName = json['users_name']?.toString();
    usersPassword = json['users_password']?.toString();
    usersEmail = json['users_email']?.toString();
    usersPhone = json['users_phone']?.toString();
    usersVerfiycode = json['users_verfiycode']?.toString();
    usersApprove = json['users_approve']?.toString();
    usersCreate = json['users_create']?.toString();
    usersImage = json['users_image'];
  }

  String? usersId;
  String? usersName;
  String? usersPassword;
  String? usersEmail;
  String? usersPhone;
  String? usersVerfiycode;
  String? usersApprove;
  String? usersCreate;
  dynamic usersImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['users_id'] = usersId;
    map['users_name'] = usersName;
    map['users_password'] = usersPassword;
    map['users_email'] = usersEmail;
    map['users_phone'] = usersPhone;
    map['users_verfiycode'] = usersVerfiycode;
    map['users_approve'] = usersApprove;
    map['users_create'] = usersCreate;
    map['users_image'] = usersImage;
    return map;
  }
}
