import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/core/screens/authentication/controller/auth_controller.dart';
import 'package:merchant/src/features/core/screens/authentication/model/login_model.dart';
import 'package:merchant/src/features/core/screens/authentication/model/sign_up_model.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo extends GetxController{
  final ApiService apiService;
  final SharedPreferences sharedPreferences;

  AuthRepo({ 
    required this.apiService, 
    required this.sharedPreferences
  });
  Map<String,String> header = {};

  Future<Response> registration(SignUpBody body)async{
    return await apiService.signUp(AppConstant.SIGN_UP, body.toJson(),header);
  }
  
  Future<Response> LogIn(LogInBody body)async{

    return await apiService.signUp(AppConstant.LOGIN, body.toJson(),header);
  }

  Future<Response> sendOTP(String email, String otp)async{
    Map<String,String> body = {
      "emailPhone": email,
      "otp": otp,
    };

    return await apiService.signUp(AppConstant.OTP, body,header);
  }

  Future<Response> resendOTP(String email)async{
    Map<String,String> body = {
      "emailPhone": email,
    };

    return await apiService.signUp(AppConstant.RESEND_OTP, body,header);
  }

  saveUserToken(String token) async{
    apiService.token = token;
    apiService.updateHeader(token);

    return await sharedPreferences.setString(AppConstant.TOKEN, token);
  }
}