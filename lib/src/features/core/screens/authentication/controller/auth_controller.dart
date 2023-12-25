import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/features/core/screens/authentication/model/login_model.dart';
import 'package:merchant/src/features/core/screens/authentication/model/response_model.dart';
import 'package:merchant/src/features/core/screens/authentication/model/sign_up_model.dart';
import 'package:merchant/src/features/core/screens/authentication/repository/auth_repo.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:merchant/src/routing/route_helper.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> registration(SignUpBody signUpBody,String email) async {
    _isLoading = false;
    print(signUpBody.email);
    Response response = await authRepo.registration(signUpBody);
    late ResponseModel resBody;
    if (response.statusCode == 200) {
      // authRepo.saveUserToken(response.body["token"]);
      // responseModel = ResponseModel(true, response.body["token"]);

      resBody = ResponseModel.fromJson(response.body);
      // Get.toNamed(RouteHelper.gotoOTP(email));
      print("success");

    } else {
      // responseModel = ResponseModel(false, response.statusText!);
      resBody = ResponseModel.fromJson(response.body);
      print("${resBody.data!.phoneEmail}");
      Get.snackbar("${resBody.message}","${resBody.data!.phoneEmail}${response.body["data"]["password"]}${response.body["data"]["password_confirm"]}");
    }
    _isLoading = true;
    update();
    // return responseModel;
  }

  Future<void> logIn(LogInBody logInBody) async{
    Response response = await authRepo.LogIn(logInBody);
    ResponseLoginModel resBody = ResponseLoginModel();
    if (response.body["success"] == true) {
      // authRepo.saveUserToken(response.body["token"]);
      // responseModel = ResponseModel(true, response.body["token"]);
      resBody = ResponseLoginModel.fromJson(response.body);
      Get.toNamed(RouteHelper.gotoInitial());
      print("success");

    } else {
      // responseModel = ResponseModel(false, response.statusText!);
      print(response.body["message"]);
      Get.snackbar("${response.body["message"]}","${response.body["data"]}");
    }

    update();
  }
  // late String message;
  Future<void> sendOTP(String email, String otp) async {
    try {
      Response response = await authRepo.sendOTP(email, otp);
      late ResponseOTPModel resBody;
      if(response.body["success"]==true){
        resBody = ResponseOTPModel(response.body["success"],response.body["message"]);
        print("success");
      }else{
        resBody = ResponseOTPModel(response.body["success"],response.body["message"]);
        print(resBody.message);
        Get.snackbar("Timeout","${resBody.message}");
      }
    } on Exception catch (e) {
      throw(e);
    }
  }

  Future<void> resendOTP(String email) async {
    try {
      Response response = await authRepo.resendOTP(email);
      late ResponseOTPModel resBody;
      if(response.body["success"]==true){
        resBody = ResponseOTPModel(response.body["success"],response.body["message"]);
        print("success");
        print(resBody.message);
      }else{
        resBody = ResponseOTPModel(response.body["success"],response.body["message"]);
        print(resBody.message);
      }
    } on Exception catch (e) {
      throw(e);
    }
  }

  
}
