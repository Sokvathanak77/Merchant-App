import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/features/core/screens/home/model/product_model.dart';

class SearchProductController extends GetxController{
  ProductController productController = Get.put(ProductController(productRepo: Get.find()));
  RxList? foundProduct = [].obs;

  @override
  void onInit() {
    foundProduct!.value = productController.productList!;
    super.onInit();
  }
  @override
  void onReady() {
    super.onReady();
  }
  @override
  void onClose() {
    super.onClose();
  }
  void filterProduct (String productName){
      List result = [];
      if(productName.isEmpty){
        result = productController.productList!;
      }else{
        result = productController.productList!.where((element) => element.products.name.toString().toLowerCase().contains(productName.toLowerCase())).toList();
      }
      foundProduct!.value = result;
  }

}