import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/repository/authentication_repository/authentication_repository.dart';
import 'package:merchant/src/utils/theme/widget_themes/text_theme.dart';
// import 'package:merchant/src/routing/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/image_strings.dart';
// import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
// import 'changepin_screen.dart';
// import 'language_screen.dart';
// import 'privacy_screen.dart';
// import 'term_screen.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key? key}) : super(key: key);
  final ProductController productController = Get.find();
  final LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
        child: Container(
        // child: ListView(
        //   children: [
        //     ListTile(
        //       onTap: () {},
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("My Favorites"),
        //       leading: const Icon(Icons.favorite),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     const Divider(indent: 70), //
        //     ListTile(
        //       onTap: () {
        //         Get.toNamed(RouteHelper.goTransactionHistory());
        //       },
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("Transaction History"),
        //       leading: const Icon(Icons.receipt_long_rounded),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     SizedBox(
        //         height: 8.0,
        //         child: Container(
        //           color: Colors.black12,
        //         )),
        //     ListTile(
        //       onTap: () {},
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("Submit Feedback"),
        //       leading: const Icon(Icons.comment),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     const Divider(indent: 70),
        //     ListTile(
        //       onTap: () {
        //         showModalBottomSheet(
        //             context: context,
        //             builder: (BuildContext context) {
        //               return ClipRRect(
        //                 borderRadius: const BorderRadius.only(
        //                     topLeft: Radius.circular(16.0),
        //                     topRight: Radius.circular(16.0)),
        //                 child: Container(
        //                   decoration: const BoxDecoration(shape: BoxShape.circle),
        //                   child: ListView(
        //                     children: [
        //                       ListTile(
        //                         onTap: () {
        //                           UrlLauncher.launch("tel://087559911",
        //                               forceWebView: false,
        //                               forceSafariVC: false,
        //                               enableJavaScript: false);
        //                         },
        //                         textColor: tDarkColor,
        //                         iconColor: tDarkColor,
        //                         title: const Text("087559911"),
        //                         subtitle: const Text("Call our care center now",style: TextStyle(color: Colors.blueGrey),),
        //                         leading: const Icon(Icons.phone),
        //                       ),
        //                       const Divider(indent: 70),
        //                       ListTile(
        //                         onTap: () {
        //                           UrlLauncher.launch("https://telegram.me/087559911",
        //                               forceWebView: false,
        //                               forceSafariVC: false,
        //                               enableJavaScript: false);
        //                         },
        //                         textColor: tDarkColor,
        //                         iconColor: tDarkColor,
        //                         title: const Text("087559911"),
        //                         subtitle: const Text("Telegram our care center now",style: TextStyle(color: Colors.blueGrey),),
        //                         leading: const Icon(Icons.telegram_outlined),

        //                       ),
        //                       const Divider(indent: 70),
        //                       ListTile(
        //                         onTap: () {
        //                           UrlLauncher.launch("https://telegram.me/087559911",
        //                               forceWebView: false,
        //                               forceSafariVC: false,
        //                               enableJavaScript: false);
        //                         },
        //                         textColor: tDarkColor,
        //                         iconColor: tDarkColor,
        //                         title: const Text("Messenger"),
        //                         subtitle: const Text("Messenger our care center now",style: TextStyle(color: Colors.blueGrey),),
        //                         leading: const Icon(Icons.messenger_outline),

        //                       ),
        //                       const Divider(indent: 70),
        //                       ListTile(
        //                         onTap: () {
        //                           UrlLauncher.launch("https://wa.me/087559911",
        //                               forceWebView: false,
        //                               forceSafariVC: false,
        //                               enableJavaScript: false);
        //                         },
        //                         textColor: tDarkColor,
        //                         iconColor: tDarkColor,
        //                         title: const Text("WhatsApp"),
        //                         subtitle: const Text("WhatsApp our care center now",style: TextStyle(color: Colors.blueGrey),),
        //                         leading: const Icon(Icons.message),

        //                       ),
        //                 const Divider(indent: 70),
        //                 ListTile(
        //                   onTap: ()async {
        //                     const String lat = "42.3540";
        //                     const String lng = "71.0586";
        //                     const String mapUrl = "geo:$lat,$lng";
        //                     if (await UrlLauncher.canLaunch(mapUrl)) {
        //                       await UrlLauncher.launch(mapUrl);
        //                     } else {
        //                       throw "Couldn't launch Map";
        //                     }
        //                   },
        //                   textColor: tDarkColor,
        //                   iconColor: tDarkColor,
        //                   title: const Text("Map"),
        //                   subtitle: const Text("Telegram our care center now",style: TextStyle(color: Colors.blueGrey),),
        //                   leading: const Icon(Icons.language),

        //                 ),


        //                     ],
        //                   ),
        //                 ),
        //               );
        //             });
        //       },
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("Have any question?"),
        //       subtitle: const Text("Call our care center now"),
        //       leading: const Icon(Icons.question_answer_outlined),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     SizedBox(
        //         height: 50.0,
        //         child: Container(
        //             padding: const EdgeInsets.only(left: 15),
        //             color: Colors.black12,
        //             child: const Row(
        //               children: [
        //                 Text(
        //                   "Settings",
        //                   style: TextStyle(fontWeight: FontWeight.bold),
        //                 )
        //               ],
        //             ))),
        //     ListTile(
        //       onTap: () {
        //         Get.to(() => const ChangePINScreen());
        //       },
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("Change PIN"),
        //       leading: const Icon(Icons.lock_outline),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     const Divider(indent: 70),
        //     ListTile(
        //       onTap: () {
        //         Get.to(() => const LanguageScreen());
        //       },
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("Language"),
        //       leading: const Icon(Icons.language),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     SizedBox(
        //         height: 8.0,
        //         child: Container(
        //           color: Colors.black12,
        //         )),
        //     ListTile(
        //       onTap: () {
        //         Get.to(() => const TermScreen());
        //       },
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("Terms and Conditions"),
        //       leading: const Icon(Icons.text_snippet_outlined),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     const Divider(indent: 70),
        //     ListTile(
        //       onTap: () {
        //         Get.to(() => const PrivacyScreen());
        //       },
        //       textColor: tDarkColor,
        //       iconColor: tDarkColor,
        //       title: const Text("Privacy Policy"),
        //       leading: const Icon(Icons.privacy_tip_outlined),
        //       trailing: const Icon(Icons.arrow_forward_ios),
        //     ),
        //     SizedBox(
        //         height: 8.0,
        //         child: Container(
        //           color: Colors.black12,
        //         )),
        //     ListTile(
        //       onTap: () {
        //         Get.off(()=>SplashScreen());
        //         AuthenticationRepository.instance.auth.signOut();
        //       },
        //       textColor: Colors.red,
        //       iconColor: Colors.red,
        //       title: const Text("Logout"),
        //       leading: const Icon(Icons.logout_outlined),
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(30),
        //       color: Colors.black12,
        //       child: Column(
        //         children: [
        //           const Text("Follow us"),
        //           Row(
        //             mainAxisAlignment: MainAxisAlignment.spaceAround,
        //             children: [
        //               IconButton(
        //                   onPressed: () {},
        //                   icon: const Icon(
        //                     Icons.facebook,
        //                     color: tDarkColor,
        //                   )),
        //               IconButton(
        //                   onPressed: () {},
        //                   icon: const Icon(Icons.tiktok, color: tDarkColor)),
        //               IconButton(
        //                   onPressed: () {},
        //                   icon: const Icon(Icons.youtube_searched_for_outlined,
        //                       color: tDarkColor)),
        //             ],
        //           )
        //         ],
        //       ),
        //     )
        //   ],
        // ),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: GetBuilder<ProductController>(builder: (productController) => 
            Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: double.maxFinite,
                      color: isDarkMode?Theme.of(context).scaffoldBackgroundColor:tDarkColor,
                      height: MediaQuery.of(context).size.height*0.2,
                    ),
                    CircleAvatar(
                      radius: Dimensions.radius30+23,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        onBackgroundImageError: (exception, stackTrace) {
                            Image.asset(portraitHolder);
                          },
                        backgroundImage: AssetImage(portraitHolder),
                        foregroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/6/68/Joe_Biden_presidential_portrait.jpg"),
                        radius: Dimensions.radius30+20,
                      ),
                    )
                  ]
                ),
                SizedBox(height: Dimensions.height10,),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width20,right: Dimensions.width20),
                  // height: ,
                  child: Text(
                    "${productController.userName.value}",
                    style: TextStyle(fontSize: Dimensions.font20,fontWeight: FontWeight.bold,color:isDarkMode?tWhiteColor:tDarkColor),
                    textAlign: TextAlign.center,
                    textScaleFactor: 1,
                  ),
                ),
                SizedBox(height: Dimensions.height10,),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width20,right: Dimensions.width20),
                  // height: 50,
                  child: RichText(
                    text: TextSpan(
                      children:[
                        TextSpan(text: "Phone:    ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold,color: isDarkMode?tWhiteColor:tDarkColor)),
                        TextSpan(text: productController.userPhone.value,style: TextStyle(fontSize: Dimensions.font18,color: isDarkMode?tWhiteColor:tSecondaryColor))
                      ] 
                    ),
                  )
                ),
                SizedBox(height: Dimensions.height10,),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width20,right: Dimensions.width20),
                  height: Dimensions.height50,
                  child: RichText(
                    text: TextSpan(
                      children:[
                        TextSpan(text: "Date of Birth:    ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold,color: isDarkMode?tWhiteColor:tDarkColor)),
                        TextSpan(text: productController.userDob.value,style: TextStyle(fontSize: Dimensions.font18,color: isDarkMode?tWhiteColor:tSecondaryColor))
                      ]
                    ),
                  )
                ),
                SizedBox(height: Dimensions.height50-10,),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.height25+5),
                  child: GestureDetector(
                    onTap: () async{
                      await AuthenticationRepository.instance.auth.signOut();
                      await loginController.signOut();
                    },
                    child: Container(
                      height: Dimensions.height50,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        boxShadow: [
                          BoxShadow(
                            color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text("Log out",style: TextStyle(fontSize: Dimensions.font20,fontWeight: FontWeight.bold,color: Colors.white),textScaleFactor: 1,)
                      )
                    ),
                  ),
                )
              ],
            )
          )
          ,
        ),
      )
    );
  }
}
