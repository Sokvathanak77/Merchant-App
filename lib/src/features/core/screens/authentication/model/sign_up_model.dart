class SignUpBody{
  String userName;
  String email;
  String password;
  String confirmPassword;

  SignUpBody({
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["name"] = this.userName;
    data["PhoneEmail"]= this.email;
    data["password"]= this.password;
    data["password_confirm"]= this.confirmPassword;

    return data;
  }
}