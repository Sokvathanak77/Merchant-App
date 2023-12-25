class UserInfoModel {
  bool? success;
  bool? isNew;
  UserData? data;
  String? token;

  UserInfoModel({this.success, this.isNew, this.data, this.token});

  UserInfoModel.fromJson(dynamic json) {
    if (json != null) {
      success = json['success'] ?? false;
      isNew = json['is_new'];
      data = json['data'] != null ? UserData.fromJson(json['data']) : null;
      token = json['token'];
    } else {
      throw Exception("Invalid JSON data");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['is_new'] = this.isNew;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? dob;
  Null? image;
  String? phone;
  Null? email;
  Null? emailVerifiedAt;
  int? schemeId;
  Null? role;
  int? verify;
  String? createdAt;
  String? updatedAt;

  UserData(
      {this.id,
      this.name,
      this.dob,
      this.image,
      this.phone,
      this.email,
      this.emailVerifiedAt,
      this.schemeId,
      this.role,
      this.verify,
      this.createdAt,
      this.updatedAt});

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dob = json['dob'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    schemeId = json['scheme_id'];
    role = json['role'];
    verify = json['verify'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['scheme_id'] = this.schemeId;
    data['role'] = this.role;
    data['verify'] = this.verify;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
