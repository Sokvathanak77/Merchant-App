import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:merchant/firebase_options.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/repository/authentication_repository/authentication_repository.dart';
import 'package:merchant/src/utils/app_bindings.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'firebase_options.dart';
import 'app.dart';

void main() async{
  // WidgetsBinding widgetsBinding =
  await WidgetsFlutterBinding.ensureInitialized();
    // await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
    // );
  await Firebase.initializeApp(name: "merchant",options: DefaultFirebaseOptions.currentPlatform)
      .then((_) => Get.put(AuthenticationRepository()));
  await InitialBinding().dependencies();
  
  runApp( App());
  
}

