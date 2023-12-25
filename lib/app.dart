import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/features/authentication/controllers/otp_controller.dart';
import 'package:merchant/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/features/core/screens/home/home_page.dart';
import 'package:merchant/src/features/core/screens/home/home_screen.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:merchant/src/features/core/screens/home/repository/product_repo.dart';
import 'package:merchant/src/routing/route_helper.dart';
import 'package:merchant/src/utils/app_bindings.dart';
import 'package:merchant/src/utils/theme/theme.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
      return GetBuilder<OTPController>(builder: (_){
        return GetMaterialApp(
          /// -- README(Docs[3]) -- Bindings
          // initialBinding: InitialBinding(),
          initialRoute: RouteHelper.gotoInitial(),
          home: Scaffold(body: Center(child: CircularProgressIndicator(),),),
          getPages: RouteHelper.routes,
          themeMode: ThemeMode.system,
          theme: TAppTheme.lightTheme,
          darkTheme: TAppTheme.darkTheme,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.rightToLeftWithFade,
          transitionDuration: Duration(milliseconds: 300),
          /// -- README(Docs[4]) -- To use Screen Transitions here
          /// -- README(Docs[5]) -- Home Screen or Progress Indicator
        );
      });
    });
  }
}

