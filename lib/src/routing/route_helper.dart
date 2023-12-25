import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:merchant/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:merchant/src/features/authentication/screens/register_new_user_page.dart';
import 'package:merchant/src/features/core/screens/account/transaction_history.dart';
import 'package:merchant/src/features/core/screens/authentication/login_page.dart';
import 'package:merchant/src/features/core/screens/authentication/otp_page.dart';
import 'package:merchant/src/features/core/screens/authentication/signup_page.dart';
import 'package:merchant/src/features/core/screens/home/category_item_page.dart';
import 'package:merchant/src/features/core/screens/home/home_page.dart';
import 'package:merchant/src/features/core/screens/home/home_screen.dart';
import 'package:merchant/src/features/core/screens/home/popular_product_detail.dart';
import 'package:merchant/src/features/core/screens/home/slider_detail_page.dart';

import '../features/core/screens/cart/screen/address_screen.dart';
import '../features/core/screens/cart/screen/cart_screen.dart';
import '../features/core/screens/cart/screen/place_order_screen.dart';

class RouteHelper{
  static String initial = '/';
  static String sliderpage = '/page-slider';
  static String cart = '/cart';
  static String placeOrder= '/place-order';
  static String addressScreen= '/address-screen';
  static String transactionHistory= '/transaction-history';
  static String login= '/login-page';
  static String signup= '/signup-page';
  // static String otp= '/otp-page';
  static String popularProductDetail= '/popular-product';
  static String categoryItem= '/category-item';
  static String otp_screen= '/otp-screen';
  static String newUserPage= '/new-user-page';

  

  
  static gotoInitial() => "$initial";
  static gotoLogin() => "$login";
  static gotoSignup() => "$signup";
  // static gotoOTP(String email) => "$otp?email=$email";
  static gotoPageSlider(int pageId) => "$sliderpage?pageId=$pageId";
  static gotoPopularProductDetail(int pageId) => "$popularProductDetail?pageId=$pageId";
  static goToCart() => "$cart";
  static goPlaceOrder() => "$placeOrder";
  static goAddressScreen() => "$addressScreen";
  static goTransactionHistory() => "$transactionHistory";
  static gotoCategoryItem() => "$categoryItem";
  static gotoOtpScreen(String phone) => "$otp_screen?phone=$phone";
  static gotoNewUserPage(String phone,pass) {
    String formattedPhone = "+$phone";
    "$newUserPage?phone=$formattedPhone&pass=$pass";
  }


  static List<GetPage> routes =[
    GetPage(name: initial, page:(){
      return HomeScreen();
    } ),
    
    // GetPage(name: login, page:(){
    //   return LoginPage();
    // } ),

    GetPage(name: signup, page:(){
      return SignUpPage();
    } ),

    // GetPage(name: otp, page:(){
    //   var email = Get.parameters["email"];
    //   return OTPPage(email: email.toString());
    // } ),

    GetPage(name: sliderpage, page: (){
      var pageId = Get.parameters['pageId'];
      return SliderDetail(pageId: int.parse(pageId!));
    }),
    
    GetPage(name: popularProductDetail, page: (){
      var pageId = Get.parameters['pageId'];
      return PopularProductDetail(pageId: int.parse(pageId!));
    }),
    
    GetPage(name: otp_screen, page: (){
      var phone = Get.parameters['phone'];
      return OTPScreen(phone: phone!,);
    }),

    GetPage(name: cart, page: (){
      return CartScreen();
    }),

    GetPage(name: placeOrder, page: (){
      return PlaceOrder();
    }),

    GetPage(name: addressScreen, page: (){
      return AddressScreen();
    }),

    GetPage(name: newUserPage, page:() { 
      var phone = Get.parameters["phone"];
      var pass = Get.parameters["pass"];
      
      return NewUserPage(phone: phone!,pass: pass!);
      }
    ),

    GetPage(name: transactionHistory, page:()=> TransactionHistoryScreen()),
    GetPage(name: categoryItem, page:()=> CategoryItemPage()),
    
  ];
}