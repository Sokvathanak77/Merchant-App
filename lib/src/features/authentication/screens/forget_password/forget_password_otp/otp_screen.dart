import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merchant/src/common_widgets/buttons/primary_button.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/sizes.dart';
import 'package:merchant/src/constants/text_strings.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/features/authentication/screens/splash_screen/splash_screen.dart';
import '../../../controllers/otp_controller.dart';

class OTPScreen extends StatefulWidget {
  final String phone ;
  OTPScreen({Key? key, required this.phone}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
  
}



class _OTPScreenState extends State<OTPScreen> {
  
  LoginController loginController = Get.find();
  OTPController otpController = Get.find();
  @override
  void initState() {
    loginController.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String otp = '';
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(Dimensions.width20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tOtpTitle,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: Dimensions.font20*4),
                textScaleFactor: 1,
              ),
              Text(tOtpSubTitle.toUpperCase(), style: Theme.of(context).textTheme.titleLarge,textScaleFactor: 1,),
              SizedBox(height: Dimensions.height20),
              GetBuilder<LoginController>(builder: (loginController){
                return loginController.expired==false?
                Text(
                  "$tOtpMessage ${widget.phone} expired in ${loginController.start.value}s",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: Dimensions.font16),
                  textScaleFactor: 1,
                ):
                Container(
                  width: Dimensions.width100*2,
                  child: ElevatedButton(
                    onPressed: (){
                      loginController.phoneLoginSignUp(widget.phone);
                      loginController.startTimer();
                    }, 
                    child: Text("Resend OTP",style: TextStyle(fontSize: Dimensions.font18),textScaleFactor: 1,)
                  ),
                );
              }),
              SizedBox(height: Dimensions.height20),
              OtpTextField(
                  mainAxisAlignment: MainAxisAlignment.center,
                  numberOfFields: 6,
                  fillColor: Colors.black.withOpacity(0.1),
                  filled: true,
                  onSubmit: (code) {
                    otp = code;
                    OTPController.instance.verifyOTP(otp,widget.phone);
                  }),
              SizedBox(height: Dimensions.height20),
              Obx(() =>
                SizedBox(
                  width: double.infinity,
                  child: TPrimaryButton(
                    text: tNext,
                    textStyle: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold),
                    isLoading: otpController.isOtploading.value,
                    onPressed: () {
                      otpController.isOtploading.value==false
                      ?
                      OTPController.instance.verifyOTP(otp,widget.phone)
                      :
                      null;
                    },
                    // child: otpController.isOtploaded==false
                    // ?
                    // Center(child: CircularProgressIndicator(),)
                    // :
                    // Text(tNext,style: TextStyle(fontSize: 18),)
                  ),
                ), 
              ),
            ],
          ),
        ),
      ),
    );
  }
}
