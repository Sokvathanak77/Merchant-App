import 'dart:convert';

import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/features/core/screens/cart/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList){
    cart = [];
    var time = DateTime.now().toString();
    
    cartList.forEach((element){ 
      element.time = time;
      cart.add(jsonEncode(element));

      }
    );

    sharedPreferences.setStringList(AppConstant.CART_LIST, cart);
    // print(sharedPreferences.getStringList("cart-list"));
    // getCartList();
  }

  List<CartModel> getCartList(){
    List<String> carts=[];
    if(sharedPreferences.containsKey(AppConstant.CART_LIST)){
      carts = sharedPreferences.getStringList(AppConstant.CART_LIST)!;
    }
    List<CartModel> cartList = [];
    
    carts.forEach((element)=> cartList.add(CartModel.fromJson(jsonDecode(element))));
    // print(sharedPreferences.getStringList("cart-list"));
    return cartList;
  }

  void addToCartHistory(){
    if(sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)){
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;
    }

    for(int i=0; i<cart.length;i++){
      cartHistory.add(cart[i]);
    }
    removeLocal();
    sharedPreferences.setStringList(AppConstant.CART_HISTORY_LIST, cartHistory);
    getCartHistory();
  }

  List<CartModel> getCartHistory(){
    if(sharedPreferences.containsKey(AppConstant.CART_HISTORY_LIST)){
      cartHistory = [];
      cartHistory = sharedPreferences.getStringList(AppConstant.CART_HISTORY_LIST)!;

    }
    List<CartModel> cartListHistory=[];
    cartHistory.forEach((element) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartListHistory;
  }

  void removeLocal(){
    cart = [];
    sharedPreferences.remove(AppConstant.CART_LIST);
  }
  void removeHistory(){
    sharedPreferences.remove(AppConstant.CART_HISTORY_LIST);
  }
}