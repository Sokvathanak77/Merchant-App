// import 'dart:convert';

import 'package:get/get.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/core/screens/home/model/product_model.dart';
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../cart/model/api_cart_model.dart';
// import 'package:http/http.dart' as http;

class ApiCartRepo extends GetxService{
  final ApiService apiService;
  
  ApiCartRepo({required this.apiService});

@override
  void onInit() {
    getUserID();
    super.onInit();
  }

  Future getUserID() async{
    var pref = await SharedPreferences.getInstance();
    AppConstant.USER_ID = pref.getString("user_id")??"";
  }
  Map<String, String> body={
    "user_id":AppConstant.USER_ID
  };

  Future<Response> postProductToCart(Data product,String urlEndPoint) async {
    Map<String,String> body={
      "user_id":AppConstant.USER_ID,
      "product_id":product.productId.toString()
    };
    return apiService.postData(urlEndPoint,body);
  }
  
  Future<Response> quantityCart(ApiData product,String urlEndPoint) async {
    Map<String,String> body={
      "user_id":AppConstant.USER_ID,
      "product_id":product.productId.toString()
    };
    return apiService.postData(urlEndPoint,body);
  }
  
  Future<Response> getApiCartList() async{

    return apiService.getData(AppConstant.LIST_CART,body);

  }

  Future<Response> deleteCartData(ApiData product ,String urlEndPoint) async{
    Map<String,String> body={
      "user_id":AppConstant.USER_ID,
      "product_id":product.productId.toString()
    };
    return apiService.deleteData(urlEndPoint,body);
  }

  Future<Response> submitOrder(String payment,String urlEndPoint) async {
    Map<String,String> body={
      "user_id":AppConstant.USER_ID,
      "address_id":"1",
      "pay_by":payment
    };
  
    return apiService.postData(urlEndPoint,body);
  }
  
  Future<Response> submitOrderDetail(String urlEndPoint,List cartProduct,String orderId) async {
    List<Map<String,String>> body=[];
    cartProduct.forEach((element) {
      Map<String,String> data = {
      "order_id": orderId,
      "product_id": element.productId.toString(),
      "qty":element.qty.toString(),
      "discount": "10",
      "unit_price": element.unitPrice.toString(),
      };
      body.add(data);
     });
    
    // print("this is "+ body.toString());
    
    return apiService.submitOrderDetail(urlEndPoint,body);
  }

  Future<Response> getCartHistory() async{
    return apiService.getData(AppConstant.LIST_ORDERED,body);

  }
}

