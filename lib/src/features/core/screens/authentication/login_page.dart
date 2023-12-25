// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:merchant/src/constants/dimenstion.dart';
// import 'package:merchant/src/constants/image_strings.dart';
// import 'package:merchant/src/features/core/screens/authentication/controller/auth_controller.dart';
// import 'package:merchant/src/features/core/screens/authentication/model/login_model.dart';
// import 'package:merchant/src/routing/route_helper.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   AuthController authController = Get.find();
//   var emailController = TextEditingController();
//   var passwordController= TextEditingController();

//   @override
//   Widget build(BuildContext context) {

//     LogInBody logInBody = LogInBody(
//       email: emailController.text.trim(), 
//       password: passwordController.text.trim(),
//     );


//     return GestureDetector(
//       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
//       child: Material(
//         child: SafeArea(
//           child: Container(
//             padding: EdgeInsets.only(left: 10, right: 10, top: 50),
//             child: Column(
//               children: [
//                 Container(width: 200,height: 100,child: Image.asset(tWelcomeScreenImage,fit: BoxFit.cover,)),
//                 Container(width: double.maxFinite,height: 100,child: Text("Welcome Back",style: TextStyle(fontSize: 30,color: Colors.blue,fontWeight: FontWeight.w800,inherit: false),)),
//                 Container(
//                   width: double.infinity,
//                   height: 70,
//                   padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
//                   child: TextField(
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey,
//                       hintText: 'Email',
//                       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//                     ),
                    
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Container(
//                   width: double.infinity,
//                   height: 70,
//                   padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
//                   child: TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       fillColor: Colors.grey,
//                       hintText: 'Password',
//                       focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      
//                     ),
                    
//                   ),
//                 ),
//                 SizedBox(height: 20,),
//                 Container(
//                   width: double.infinity,
//                   height: 60,
//                   padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
//                   child: ElevatedButton(
//                     onPressed: (){
//                       authController.logIn(logInBody);
//                     }, 
//                     child: Text("Login",style: TextStyle(fontSize: 18),))
//                 ),
//                 SizedBox(height: 10),
//                 Divider(color: Colors.black,indent: 60,endIndent: 60),
//                 SizedBox(height: 10),
//                 Row(
//                   children: [
//                     Text("Don\'t have an account? "),
//                     TextButton(onPressed: (){
//                       Get.toNamed(RouteHelper.gotoSignup());
//                     }, child: Text("SignUp"))
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }