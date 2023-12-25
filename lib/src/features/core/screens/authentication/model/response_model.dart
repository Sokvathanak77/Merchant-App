class ResponseOTPModel{
  bool _isSuccess;
  String _message;

  ResponseOTPModel( this._isSuccess, this._message);
  String get message => _message;
  bool get isSuccess => _isSuccess;
}


class ResponseModel {
  bool? success;
  String? message;
  Data? data;

  ResponseModel({this.success, this.message, this.data});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? phoneEmail;

  Data({this.phoneEmail});

  Data.fromJson(Map<String, dynamic> json) {
    phoneEmail = json['PhoneEmail'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PhoneEmail'] = this.phoneEmail;
    return data;
  }
}

class ResponseLoginModel {
  bool? success;
  User? user;
  String? token;

  ResponseLoginModel({this.success, this.user, this.token});

  ResponseLoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class User {
  int? id;
  String? name;
  Null? image;
  Null? phone;
  String? email;
  Null? emailVerifiedAt;
  Null? schemeId;
  Null? role;
  int? verify;
  String? createdAt;
  String? updatedAt;
  Null? scheme;

  User(
      {this.id,
      this.name,
      this.image,
      this.phone,
      this.email,
      this.emailVerifiedAt,
      this.schemeId,
      this.role,
      this.verify,
      this.createdAt,
      this.updatedAt,
      this.scheme});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    phone = json['phone'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    schemeId = json['scheme_id'];
    role = json['role'];
    verify = json['verify'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    scheme = json['scheme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['scheme_id'] = this.schemeId;
    data['role'] = this.role;
    data['verify'] = this.verify;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['scheme'] = this.scheme;
    return data;
  }
}

