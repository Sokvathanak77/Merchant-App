import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/features/authentication/controllers/on_boarding_controller.dart';
import 'package:merchant/src/features/authentication/controllers/otp_controller.dart';
import 'package:merchant/src/features/authentication/controllers/signup_controller.dart';
import 'package:merchant/src/features/core/screens/authentication/controller/auth_controller.dart';
import 'package:merchant/src/features/core/screens/authentication/repository/auth_repo.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/repository/api_cart_repo.dart';
import 'package:merchant/src/features/core/screens/cart/repository/cart_repo.dart';
import 'package:merchant/src/features/core/screens/home/controller/category_controller.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/features/core/screens/home/controller/search_controller.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:merchant/src/features/core/screens/home/repository/category_repo.dart';
import 'package:merchant/src/features/core/screens/home/repository/product_repo.dart';
import 'package:merchant/src/repository/user_repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../repository/authentication_repository/authentication_repository.dart';

class InitialBinding extends Bindings{
  @override
  Future<void> dependencies() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    Get.lazyPut(() => sharedPreferences,);
    Get.lazyPut(() => AuthenticationRepository(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);

    Get.lazyPut(() => OnBoardingController(), fenix: true);

    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => OTPController(), fenix: true);


    
    //api call
    Get.lazyPut(()=> ApiService(appBaseUrl: AppConstant.BASE_URL), fenix: true);
    Get.lazyPut(() => AuthRepo(apiService: Get.find(), sharedPreferences: Get.find()), fenix : true);

    //repository
    Get.lazyPut(() => ProductRepo(apiService: Get.find()), fenix: true);
    Get.lazyPut(() => CartRepo(sharedPreferences: sharedPreferences), fenix : true);
    Get.lazyPut(() => ApiCartRepo(apiService: Get.find()), fenix : true);
    Get.lazyPut(() => CategoryRepo(apiService: Get.find()), fenix : true);


    //controller
    Get.lazyPut(() => AuthController(authRepo: Get.find()), fenix : true);
    Get.lazyPut(() => ProductController(productRepo: Get.find()), fenix: true);
    Get.lazyPut(() => SearchProductController(), fenix: true);
    Get.lazyPut(() => CartController(cartRepo: Get.find()), fenix : true);
    Get.lazyPut(() => ApiCartController(apiCartRepo: Get.find()), fenix : true);
    Get.lazyPut(() => CategoryController(categoryRepo: Get.find()), fenix : true);
    
    
  }

}