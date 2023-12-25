import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/features/authentication/models/user_info_model.dart';
import 'package:merchant/src/features/authentication/screens/register_new_user_page.dart';
import 'package:merchant/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:merchant/src/features/core/screens/home/home_page.dart';
import 'package:merchant/src/features/core/screens/home/home_screen.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:merchant/src/routing/route_helper.dart';
import 'package:merchant/src/utils/helper/helper_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../core/screens/dashboard/dashboard.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();
  final LoginController loginController = Get.find();
  ApiService apiService = Get.find();
  RxBool isOtploading = false.obs;
  var auth = AuthenticationRepository.instance;

  void verifyOTP(String otp,phone) async {
    // final auth = AuthenticationRepository.instance;
    isOtploading.value = true;
    if(otp.isEmpty){
      Helper.errorSnackBar(title: "Invalid OTP",message: "OTP Can not Empty");
      isOtploading=false.obs;
    }else{
      bool isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
      // isVerified ? Get.offAll(const HomeScreen()) : Get.back();
      isOtploading.value = true;
      if(isVerified == true){
        try {
        var pref = await SharedPreferences.getInstance();
        Response res = await AuthenticationRepository.instance.logInToApi(phone);
        UserInfoModel userInfoModel = UserInfoModel.fromJson(res.body);
          if(userInfoModel.success==true){
            if(userInfoModel.isNew==true){
              String pass ="12345678";
              isOtploading.value=false;
              Get.offAll(()=>NewUserPage(phone:phone,pass: pass));
              print("new user");
            }else{
              String token = userInfoModel.token??"";
              String id = userInfoModel.data!.id.toString();
              Response checkRes = await auth.checkToken(token);
                if(checkRes.statusCode==200){
                  await pref.setString("user_token", token);
                  await pref.setString("user_id", id);
                  apiService.updateHeader(token);
                  AppConstant.USER_ID = userInfoModel.data!.id.toString();
                  isOtploading.value=false;
                  Get.offAll(()=>HomeScreen());
                }else{
                  isOtploading.value = false;
                  Get.defaultDialog(
                    middleText: "Token Expired or Wrong Token",
                    onConfirm: () => Get.offAll(()=>SplashScreen()),
                    barrierDismissible: false,
                  );
                }
              // loginController.checkToken();

              // Get.offAll(()=>HomeScreen());
              print("old user");
            }
            print("login success");
          }else{
            isOtploading.value = false;
            print("login not success");
          }

      } on Exception catch (e) {
        isOtploading.value = false;
        throw(e);
      }
      }else{
        Get.back();
      }
    }
    // auth.setInitialScreen(auth.firebaseUser);
  }

}