import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/core/screens/cart/model/cart_history_model.dart';
import 'package:merchant/src/features/core/screens/cart/model/cart_model.dart';
import 'package:merchant/src/features/core/screens/cart/repository/api_cart_repo.dart';
import 'package:merchant/src/features/core/screens/home/model/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:merchant/src/features/core/screens/home/repository/api_service.dart';
import '../model/api_cart_model.dart';

class ApiCartController extends GetxController{
  final ApiCartRepo apiCartRepo;

  ApiCartController({required this.apiCartRepo});

  RxList<dynamic>? _cartList = [].obs;
  RxList? get productList => _cartList;
  ApiCartModel? apiCartModel = ApiCartModel();
  RxBool isloaded = false.obs;
  String paymentMethod="ABA";
  List<int> lstCart=[];
  bool? isSuccess ;
  RxInt? amountqty=0.obs;
  // late Response cartJson;

  @override
  void onInit() {
    getCartData();
    getCartHistory();
    super.onInit();
  }
  
  Future<void> postCartData(Data product) async{
    try {
      // isloaded.value = false;
      await apiCartRepo.postProductToCart(product,AppConstant.ADD_TO_CART);
        
      await getCartData();
      isloaded.value = true;
    } catch (e) {
      print(e);
    }
    update();
  }

  Future<void> getCartData() async {
    
      isloaded.value=false;
    try { 
      Response response = await apiCartRepo.getApiCartList();
      final res = jsonEncode(response.body);
      ApiCartModel _apiCartModel = ApiCartModel.fromJson(jsonDecode(res));
      if (response.statusCode == 200) {
          
          if(_apiCartModel.success == false){
            _cartList?.value=[];
            amountqty!.value=0;
            isloaded.value = true;
            Get.back();
          }else{

            _cartList?.value = _apiCartModel.data!;
            apiCartModel = _apiCartModel;
            
            amountqty!.value = _apiCartModel.amountQty!;
            isSuccess = _apiCartModel.success;
            
            isloaded.value = true;
            update();
          }
        } else {
          print(response.body);
          print('cart Error');
        }
    } on Exception catch (e) {
      print(e);
    }
   update();
  }

  Future<void> refreshCart() async {
  // Simulate a delay for fetching new data
    await Future.delayed(Duration(seconds: 2));
  // Generate new data
    await getCartData();
    // await getCartHistory();
  }

  Future<void> increaseCart(ApiData product) async{
    isloaded.value=false;
    try {
      await apiCartRepo.quantityCart(product,AppConstant.ADD_TO_CART);

      await getCartData();
      isloaded.value=true;
      update();
    } catch (e) {
      print(e); 
    }
    update();
  }

  Future<void> decreaseCart(ApiData product) async{
    isloaded.value=false;
    try {
      await apiCartRepo.quantityCart(product,AppConstant.DECREASE_CART);
        
      await getCartData();
      isloaded.value=true;
      update();
    } catch (e) {
      print(e); 
    }
    update();
  }

  void deleteCart(ApiData product) async{
    try {
      await apiCartRepo.deleteCartData(product,AppConstant.DELETE_CART).then((res) => {

        getCartData()
      }); 
    } catch (e) {
      print(e);
    }
    update();
  }

  void deleteCartDialog(ApiData product, BuildContext context){
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    Get.dialog(
      Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius20),color: Theme.of(context).dialogBackgroundColor,),
          padding: EdgeInsets.only(top: Dimensions.height10*2),
          width: Dimensions.width100*3,
          height: Dimensions.height180,
          child: Column(
            children: [
              Container(
                child: Text(
                  'Do you want to delete this item?',
                  style: TextStyle(
                    color: isDarkMode?tWhiteColor:tDarkColor,
                    fontSize: Dimensions.font18,
                    fontWeight: FontWeight.bold,
                    inherit: false
                  ),
                  textScaleFactor: 1,
                )
              ),
              SizedBox(height: Dimensions.height20*2,),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                        deleteCart(product);
                        Get.back();
                        update();
                      },
                      child: Text('Yes',style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold,color: tWhiteColor),textScaleFactor: 1,)
                    ),
                    SizedBox(width: Dimensions.width20+30,),
                    ElevatedButton(
                      onPressed: () {
                        
                        Get.back();
                      },
                      child: Text('No',style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold),textScaleFactor: 1,)
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
        transitionDuration: Duration(milliseconds: 200),
    );
    update();
  }

  Future<void> submitOrder(String payment,List<dynamic> product) async{
    String orderId='';
    try {
      await apiCartRepo.submitOrder(payment,AppConstant.ORDER).then((res) => {
        // if(ApiCartModel.fromJson(res.body).success!){
          orderId = res.body['data']['id'].toString(),
          submitOrderDetail(orderId),
          Get.back()
        // }
        // else{
        //   print('failed to delete')
        // }  
      });
    } catch (e) {
      print(e); 
      
    }
    update();
  }
  
  void submitOrderDetail(String orderId) async{
    update();
    try {
      await apiCartRepo.submitOrderDetail(AppConstant.ORDER_DETAIL,_cartList!,orderId).then((res) => {
       getCartData(),
       getCartHistory()
        // if(ApiCartModel.fromJson(res.body).success!){
          // print(res.body)
        // }
        // else{
        //   print('failed to delete')
        // }
      });
    } catch (e) {
      print(e); 
    }
    update();
  }

  List<List<dynamic>> cartOrdered=[];
  List<dynamic> invoiceNumber=[];
  List<dynamic> totalAmount=[];
  RxBool isOrderEmpty=true.obs;

  Future<void> getCartHistory() async{

    Response response = await apiCartRepo.getCartHistory();
    var res = jsonDecode(jsonEncode(response.body));
    if (res["success"] == true) {
      isOrderEmpty.value=false;
      try {
        
        // var res = json.decode(json.encode(response.body));
        // if(res.data.){
        //   cartOrdered =[];
        // }else{
        //   // for(int i=0;i<response.body['data'].length;i++){
        //   //   cartOrdered.add(response.body['data'][0]);
        //   // }
        //   // response.body['data'].forEach((element){
        //   // cartOrdered = element;
        //   // });
        //   cartOrdered = res["data"];
        //   cartOrdered = cartOrdered.reversed.toList();
        
        //   invoiceNumber = res['invoice'];
        //   invoiceNumber = invoiceNumber.reversed.toList();
        
        //   totalAmount = res['total'];
        //   totalAmount = totalAmount.reversed.toList();
        // }

          CartHistoryModel cartHistoryModel = CartHistoryModel.fromJson(response.body);
          cartOrdered = cartHistoryModel.data!;
          cartOrdered = cartOrdered.reversed.toList();

          invoiceNumber= cartHistoryModel.invoice!;
          invoiceNumber = invoiceNumber.reversed.toList();

          totalAmount = cartHistoryModel.total!;
          totalAmount = totalAmount.reversed.toList();
        
      } on Exception catch (e) {
        throw(e);
      }
      
    } else {
      isOrderEmpty.value = true;
      print('order page is empty ');
    }
    
   update();
  //  print(totalAmount[0]);
  }

  // void showOverlay(BuildContext context,RxBool isloaded) async{
  //   OverlayState overlayState = Overlay.of(context);
  //   OverlayEntry overlayEntry = OverlayEntry(
  //     opaque: true,
  //     builder: (context)=> Container(
  //       width: MediaQuery.of(context).size.width,
  //       height: MediaQuery.of(context).size.height,
  //       color: Colors.white.withOpacity(0.4),
  //       child: Center(
  //         child: CircularProgressIndicator()
  //       ),
  //     )
  //   );
  //   overlayState.insert(overlayEntry);
  //   if(isloaded.value==true){
  //     overlayEntry.remove();
  //   }
  // }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}


