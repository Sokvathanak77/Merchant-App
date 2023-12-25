import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/image_strings.dart';
import 'package:merchant/src/features/core/screens/authentication/controller/auth_controller.dart';
import 'package:merchant/src/features/core/screens/authentication/model/sign_up_model.dart';
import 'package:merchant/src/routing/route_helper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage> {
  
  var authController = Get.find<AuthController>();
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  late bool success;
  late String email;
  
  // void _registration(){
    
  //   String userName = userNameController.text.trim();
  //   email = emailController.text.trim();
  //   String password = passwordController.text.trim();
  //   String confirmPassword = confirmPasswordController.text.trim();
  //   success = false;
  //   if(userName.isEmpty){
  //     Get.snackbar('Name', 'Input Your Name');
  //   }else if(email.isEmpty){
  //     Get.snackbar('Email', 'Input Your Email Address');
  //   }else if(!GetUtils.isEmail(email)){
  //     Get.snackbar('Invalid Email', 'Incorrect Email Address');
  //   }else if(password.isEmpty){
  //     Get.snackbar('Password', 'Input Your Password');
  //   }else if(password.length<6){
  //     Get.snackbar('Password', 'Password can\'t be less than 6 character');
  //   }else if(confirmPassword.isEmpty){
  //     Get.snackbar('Password', 'Input confirm password');
  //   }else if(confirmPassword.length<6){
  //     Get.snackbar('Password', 'Incorrect confirm password');
  //   }else{
  //     Get.snackbar('Perfect', 'All Went Well');
  //     success = true;

  //   }
  // }
  
  @override
  void initState() {
    SignUpBody signUpBody = SignUpBody(
        userName: userNameController.text.trim(),
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

      SignUpBody signUpBody = SignUpBody(
        userName: userNameController.text.trim(),
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
        
      );
    
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Material(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Container(width: 200,height: 100,child: Image.asset(tWelcomeScreenImage,fit: BoxFit.cover,)),
                Container(width: double.maxFinite,height: 50,child: Text("Sign Up New Account",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.w800,inherit: false),)),
                Container(
                  width: double.infinity,
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: TextField(
                    enableSuggestions: true,
                    controller: userNameController,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      hintText: 'UserName',
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: TextField(
                    controller: emailController,
                    enableSuggestions: true,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      hintText: 'Email Or PhoneNumber',
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      hintText: 'Password',
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 70,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      fillColor: Colors.grey,
                      hintText: 'Confirm Password',
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      
                    ),
                    
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                  child: ElevatedButton(onPressed: (){
                    // _registration();
                    // success==false? null:Get.toNamed(RouteHelper.gotoOTP(email));
                    authController.registration(signUpBody,signUpBody.email);
                    print(emailController.text);
                  }, child: Text("Sign Up",style: TextStyle(fontSize: 18),))
                ),
                SizedBox(height: 10),
                Divider(color: Colors.black,indent: 60,endIndent: 60),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text("already have an account?"),
                    TextButton(
                      onPressed: (){
                        // Get.toNamed(RouteHelper.gotoLogin());
                        Get.back();
                      },
                      child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}