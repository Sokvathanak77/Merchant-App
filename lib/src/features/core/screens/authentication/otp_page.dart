import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/image_strings.dart';
import 'package:merchant/src/features/core/screens/authentication/controller/auth_controller.dart';
import 'package:merchant/src/features/core/screens/authentication/signup_page.dart';
import 'package:merchant/src/routing/route_helper.dart';


class OTPPage extends StatelessWidget {
  final String email;
  OTPPage({super.key, required this.email});

//   @override
//   State<OTPPage> createState() => _OTPPageState();
// }
  
// class _OTPPageState extends State<OTPPage> {
  AuthController authController = Get.find();

  RxBool isSend = false.obs;
  String verify = "Verification code has been sent to your email address";
  
  @override
  Widget build(BuildContext context) {
    
    var otpController = TextEditingController();
    String otp = otpController.text.trim();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Obx(() =>
        Material(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 150),
            child: Column(
              children: [
                Container(width: 200,height: 100,child: Image.asset(tWelcomeScreenImage,fit: BoxFit.cover,)),
                Container(
                  width: double.maxFinite,
                  height: 70,
                  child: Text( isSend==true?verify:"",
                    style: TextStyle(fontSize: 18,color: Colors.blue,inherit: false),)),
                Row(
                  children: [
                    Container(
                      width: 227,
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        
                        // controller: ,
                        decoration: InputDecoration(
                          
                          // fillColor: Colors.grey,
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(15))),
                          hintText: 'OTP Code',
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(15))),
                          
                        ),
                        
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print("tapped");
                        isSend.value = true;
                        authController.resendOTP(email);
                      },
                      child: Container(

                        height: 60,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.horizontal(right: Radius.circular(15))),
                        child: Center(child: Text("Resend Verification",style: TextStyle(color: Colors.white),))
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: ElevatedButton(
                    onPressed: (){
                      authController.sendOTP(email,otp);
                    }, 
                    child: Text("Login",style: TextStyle(fontSize: 18),)
                    
                  )
                ),
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}