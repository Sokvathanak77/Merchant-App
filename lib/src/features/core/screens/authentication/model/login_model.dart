class LogInBody{
  String email;
  String password;

  LogInBody({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["PhoneEmail"]= this.email;
    data["password"]= this.password;

    return data;
  }
}