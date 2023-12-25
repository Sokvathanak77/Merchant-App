import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/authentication/models/user_info_model.dart';
import 'package:merchant/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:merchant/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:merchant/src/features/core/screens/home/home_page.dart';
import 'package:merchant/src/features/core/screens/home/home_screen.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:merchant/src/routing/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/text_strings.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';
import '../../../utils/helper/helper_controller.dart';

class LoginController extends GetxController {

  static LoginController get instance => Get.find();
  final auth = AuthenticationRepository.instance;
  ApiService apiService = Get.find();
  /// TextField Controllers to get data from TextFields
  final showPassword = false.obs;
  final email = TextEditingController();
  final password = TextEditingController();
  final phoneNo = TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> profileFormKey = GlobalKey<FormState>();


  /// Loader
  final isNewUserLoading = false.obs;
  final isLogoutLoading = false.obs;
  final isGoogleLoading = false.obs;
  final isFacebookLoading = false.obs;
  final isPhoneLoading = false.obs;



  /// [EmailAndPasswordLogin]
  Future<void> login() async {
    try {
      isNewUserLoading.value = true;
      if (!loginFormKey.currentState!.validate()) {
        isNewUserLoading.value = false;
        return;
      }
      final auth = AuthenticationRepository.instance;
      await auth.loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isNewUserLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  /// [PhoneSignInAuthentication]
  Future<void> phoneSignIn(String phoneNumber) async {
    try {
      isNewUserLoading.value = true;
      if (!phoneFormKey.currentState!.validate()) {
        isNewUserLoading.value = false;
      
        isPhoneLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.loginWithPhoneNo(phoneNumber).then((value) => Get.to(() => OTPScreen(phone: phoneNumber,)));
      isPhoneLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
      }
    } catch (e) {
      isPhoneLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  Future<void> phoneLoginSignUp(String phoneNo)async{
    isPhoneLoading.value = true;
    try {
      if (phoneNo.contains(RegExp(r'^[0]'),4)) {
        Helper.errorSnackBar(title: "Invalid Phone Number", message: "Please enter the correct number");
        
      }else if(phoneNo.isEmpty){
        Helper.errorSnackBar(title: "Invalid Phone Number", message: "Phone Number can\t be empty");
      }else if (phoneNo.length<12||phoneNo.length > 13){
        Helper.errorSnackBar(title: "Invalid Phone Number", message: "Phone Number can\t be less than 8 & more than 9 digits");
      }
      else{
        final auth = AuthenticationRepository.instance;
        isPhoneLoading.value=false;
        await auth.phoneAuthentication(phoneNo).then((value) => Get.off(() => OTPScreen(phone: phoneNo)));
      }
      isPhoneLoading.value=false;
    } catch (e) {
      isPhoneLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  


  RxInt start = 0.obs;
  bool expired = false;

  void startTimer(){
    expired = false;
    start.value =60;
    final onsec = Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) { 
      if(start.value == 0 ){
        timer.cancel();
        expired = true;
        update();
      }else{
        start.value--;
        update();
      }
    });
  }

  Future<void> createNewUser(String phone,name,dob,pass)async {
    isNewUserLoading.value=true;
    final auth = AuthenticationRepository.instance;
    var sharedPreferences = await SharedPreferences.getInstance();
    String token,id;
    String phoneNo=phone.substring(1);
    phone = "+$phoneNo";
      if(profileFormKey.currentState!.validate()){
        Response res = await auth.newUserToApi(phone,name,dob,pass);
        if(res.statusCode==200){
          UserInfoModel userInfoModel = UserInfoModel.fromJson(res.body);
          token = userInfoModel.token??"";
          id = userInfoModel.data!.id.toString();
          Response checkRes = await auth.checkToken(token);
            if(checkRes.statusCode==200){
              await sharedPreferences.setString("user_token", token);
              await sharedPreferences.setString("user_id", id);
              AppConstant.USER_ID = userInfoModel.data!.id.toString();
              // print(AppConstant.USER_ID+"hello2");
              apiService.updateHeader(token);
              isNewUserLoading.value=false;
              Get.offAll(()=>HomeScreen());
            }else{
              Get.defaultDialog(
                middleText: "Token Expired or Wrong Token",
                onConfirm: () => Get.offAll(()=>SplashScreen()),
                barrierDismissible: false,
              );
            }
          
        }else{
          print(res.body);
          print("new user not success");
        }
      }else{
        isNewUserLoading.value=false;
      }
  }

  // Future<void> checkToken()async{
  //   var sharedPreferences = await SharedPreferences.getInstance();
  //   String token= await sharedPreferences.getString("user_token")!;
  //   try {
  //   var checkRes = await auth.checkToken(token);
  //     if(checkRes.statusCode==200){
  //       UserData userInfo = UserData.fromJson(checkRes.body);
  //       AppConstant.USER_ID = userInfo.id.toString();
  //       apiService.updateHeader(token);
  //       Get.offAllNamed(RouteHelper.gotoInitial());
  //     }else{
  //       Get.defaultDialog(
  //         middleText: "Token Expired or Wrong Token",
  //         onConfirm: () => Get.offAll(()=>SplashScreen()),
  //         barrierDismissible: false,
  //       );
  //     }
  //   } on Exception catch (e) {
  //     throw e;
  //   }
  // }

  Future<void> signOut() async{
    isLogoutLoading.value = true;
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString("user_token")??"";
    try {
        var res = await auth.signOut(token);
      if(res.body["success"]){
        await pref.remove("user_token");
        await pref.remove("user_id");
        AppConstant.USER_ID="";
        auth.setInitialScreen(auth.firebaseUser);
      }else{
        print("logout not success");
      }
      isLogoutLoading.value=false;
    } on Exception catch (e) {
      isLogoutLoading.value=false;
      throw e;
    }
  }

  /// [GoogleSignInAuthentication]
  Future<void> googleSignIn() async {
    try {
      isGoogleLoading.value = true;
      final auth = AuthenticationRepository.instance;
      await auth.signInWithGoogle();
      isGoogleLoading.value = false;
      auth.setInitialScreen(auth.firebaseUser);
    } catch (e) {
      isGoogleLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  /// [FacebookSignInAuthentication]
  Future<void> facebookSignIn() async {
    try {
      isFacebookLoading.value = true;
      await AuthenticationRepository.instance.signInWithFacebook();
      isFacebookLoading.value = false;
    } catch (e) {
      isFacebookLoading.value = false;
      Helper.errorSnackBar(title: tOhSnap, message: e.toString());
    }
  }

  
}


