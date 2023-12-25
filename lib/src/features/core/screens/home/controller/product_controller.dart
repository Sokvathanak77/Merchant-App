
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/model/cart_model.dart';
import 'package:merchant/src/features/core/screens/home/model/product_model.dart';
import 'package:merchant/src/features/core/screens/home/model/slide_model.dart';
import 'package:merchant/src/features/core/screens/home/model/user_profile_model.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:merchant/src/features/core/screens/home/repository/product_repo.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {

  @override
  void onInit() async{
    getProductList();
    getSlide();
    getUserProfile();
    super.onInit();
  }
  final ApiService apiService = Get.find();
  final ProductRepo productRepo;
  

  ProductController( {required this.productRepo});
  // CartController _cart =Get.find();
  // ApiCartController _apiCart = Get.find();
  RxList _productList = [].obs;
  RxList? get productList => _productList;

  RxBool _isLoaded = RxBool(false);
  RxBool get isLoaded=> _isLoaded;

  RxString userName ="".obs,userPhone="".obs,userDob="".obs;
  double _quantity = 0;
  double get quantity => _quantity;
  double _incartItems= 0;
  double get incartItems => _incartItems+_quantity;

  

  Future<void> getProductList() async {
   Response response = await productRepo.getPopularProductList();
   final res = jsonEncode(response.body);
   if (response.statusCode == 200) {
    ProductModel productData = ProductModel.fromJson(jsonDecode(res));
    _productList.value = productData.data!;
    _isLoaded.value = true;
    update();
   } else {
    print(response.body);
    print('home page Error');
   }
  }

  Future<void> refreshData() async {
  // Simulate a delay for fetching new data
    await Future.delayed(Duration(seconds: 2));
  // Generate new data
    await getProductList();
    await getSlide();
  }

  RxBool _slideLoaded=false.obs;
  RxBool get slideLoaded=> _slideLoaded;
  List<dynamic> lstSlide = [];

  Future<void> getSlide() async {
    _slideLoaded.value=false;
   try { 
   Response response = await productRepo.getSlideShow();
   final res = jsonEncode(response.body);
    if (response.statusCode == 200) {
      SlideModel slideModel = SlideModel.fromJson(jsonDecode(res));
      lstSlide = slideModel.data!;
      // print(response.body["data"][0]["image"]);
      if(lstSlide.isEmpty){
        lstSlide=[];
      }
      _slideLoaded.value = true;
    } else {
      print('slide Error');
    }
  } on Exception catch (e) {
    print(e);
  }
   update();
  }

  Future<void> getUserProfile() async{
    Response res = await productRepo.getUserProfile();
    UserProfileModel userProfileModel = UserProfileModel.fromJson(res.body);
    if(userProfileModel.success==true){
      userName.value = userProfileModel.data!.name!;
      userPhone.value = userProfileModel.data!.phone!;
      userDob.value = userProfileModel.data!.dob!;
      AppConstant.USER_ID = userProfileModel.data!.id.toString();
    }else{
      print("user profile error");
    }
    update();
  }
  
  // void setQuantity(bool isIncrement, CartModel productLocal, Data product){
  //   if(isIncrement){
  //     productLocal.quantity = checkQuantity(productLocal.quantity!+ 1,productLocal);
  //   }
  //   else{
  //     productLocal.quantity  = checkQuantity(productLocal.quantity!-1,productLocal);
      
  //   }
  //   _cart.addItemsInCart(productLocal.quantity!,product, productLocal);
  //   update();
  // }
  // double checkQuantity(double quantity,CartModel productLocal){

  //   if(quantity<1){
  //     _cart.removeItem(productLocal);
  //     quantity =1;
  //   }
  //   return quantity;
  // }


  // void addItem(Data product){
  //   double productQty = 1;
  //   _cart.addItem(product, productQty);
  //   update();
  // }

  // double get getTotalItem{
  //   return _cart.totalItem;
  // }

  
  // List<CartModel> get getItems{
  //   return _cart.getItems;
  // }
 
  // double totalAmountPerCart (double buy, double qty) {
  //   return _cart.totalAmountPerCart(buy, qty);
  // }

  // void getProductId(Data product){
  //   _apiCart.getProductId(product);
  // }

  // void callProductId(){
  //   _apiCart.callProductId;
  // }
}
