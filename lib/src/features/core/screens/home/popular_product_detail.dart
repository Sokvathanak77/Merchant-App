import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/routing/route_helper.dart';

import '../../../../constants/constant.dart';

class PopularProductDetail extends StatelessWidget {
  final int pageId;
  PopularProductDetail({super.key, required this.pageId});
  final ApiCartController apiCartController = Get.find();


  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductController>().productList![pageId];
    // ApiData productInCart = Get.find<ApiCartController>().productList![pageId];
    var w =MediaQuery.of(context).size.width;
    var h =MediaQuery.of(context).size.height;
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return 
      Scaffold(
        appBar: AppBar(
          backgroundColor: isDarkMode?Theme.of(context).scaffoldBackgroundColor:tDarkColor,
          iconTheme: const IconThemeData(color: tWhiteColor),
          title: Text("Product Detail",style: TextStyle(fontSize: Dimensions.font20),textScaleFactor: 1,),
          actions: [
            Obx(() => 
              GestureDetector(
                onTap: () => apiCartController.amountqty!.value>0?Get.toNamed(RouteHelper.goToCart()):() => null,
                child: Stack(
                  children: [
                    Container(
                      width: Dimensions.width45,
                      height: Dimensions.height55+5,
                      child: Icon(Icons.shopping_cart,size: Dimensions.iconsize18,color: tWhiteColor,),
                    ),
                    Positioned(
                      right: Dimensions.width5,
                      top: Dimensions.height10,
                      child: Container(
                        child: apiCartController.amountqty!.value> 0
                            ? Container(
                                width: Dimensions.width15,
                                height: Dimensions.height15,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red[300]),
                                child: Center(
                                    child: Text(
                                  apiCartController.amountqty!.value.toString(),
                                  style: TextStyle(fontSize: Dimensions.font13-3),
                                  textScaleFactor: 1,
                                )),
                              )
                            : Container()
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: h*0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(
                      AppConstant.BASE_IMAGE_URL + product.products.image
                      /*product.products.image*/
                      )
                    )
                    // color: Colors.red
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(Dimensions.width15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(product.products.name,style: TextStyle(fontSize: Dimensions.font20,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Color: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("",style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Model: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("${product.products.name}",style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,)
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Buy Price: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("\$${product.unitPrice}",style: TextStyle(fontSize: Dimensions.font16,color: Colors.redAccent),textScaleFactor: 1,),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sell Price: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("\$${product.products.price}",style: TextStyle(fontSize: Dimensions.font16,color: Colors.redAccent),textScaleFactor: 1,),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Margin: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("\$${product.margin}",style: TextStyle(fontSize: Dimensions.font16,color: Colors.redAccent),textScaleFactor: 1,),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ram: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("${product.products.ram}",style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Storage: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("${product.products.storage}",style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Stock: ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),textScaleFactor: 1,),
                          Text("${product.products.stock.toInt()}",style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,),
                        ],
                      ),
                      SizedBox(height: Dimensions.height10,),
                      Text(
                        "Description: \t",
                        style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),
                        textScaleFactor: 1,
                      ),
                      Text(
                        "${product.products.description}",
                        style: TextStyle(fontSize: Dimensions.font16),
                        // maxLines: 2,
                        textScaleFactor: 1,
                      ),
                    ],
                  )
                ),
          
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: w,
          height: Dimensions.height10*7,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height4+1),
          decoration: BoxDecoration(
            color: isDarkMode?Theme.of(context).scaffoldBackgroundColor:tWhiteColor,
            boxShadow: [
              BoxShadow(
                color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                spreadRadius: 3,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]
          ),
          child: GetBuilder<ApiCartController>(builder: (apiCartController) => 
            // apiCartController.isloaded.value==true?
              Container(
              width: Dimensions.width100,
              child: ElevatedButton(
                onPressed: () async{
                  showDialog(
                    context: context, 
                    builder: (context)=>Center(child: CircularProgressIndicator(),),
                  );
                  await apiCartController.postCartData(product);
                  if(apiCartController.isloaded==true){
                    Navigator.of(context).pop();
                  }
                    
                },
                child: Text("ADD TO CART",style: TextStyle(
                  fontSize: Dimensions.font16,fontWeight: FontWeight.bold),textScaleFactor: 1,),
              )
            )
            // :Center(
            //   child: Container(child: CircularProgressIndicator()),
            // )
          )
      //     child: GetBuilder<ApiCartController>(builder: (cartController){
      //       bool isZero = false;
      //       if(cartController.productList![pageId].qty==null){
      //         isZero = true;
      //       }
      //       return
      //     Row(children: [
      //       GestureDetector(
      //         onTap: () {
      //           // productController.setQuantity(
      //           //     false, productLocal, product);
      //             cartController.decreaseCart(productInCart);
                
      //         },
      //         child: Container(
      //           width: Dimensions.width25,
      //           height: Dimensions.height25,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             color: Colors.blue[300],
      //           ),
      //           child: Icon(Icons.remove,
      //               size: Dimensions.iconsize18),
      //         ),
      //       ),
      //       SizedBox(
      //         width: Dimensions.width15,
      //       ),
      //       Text( isZero==false?
      //           "${cartController.productList![pageId].qty.toInt()}":"0"),
      //       SizedBox(
      //         width: Dimensions.width15,
      //       ),
      //       GestureDetector(
      //         onTap: () {
      //           // productController.setQuantity(true, productLocal, product);
      //           cartController.increaseCart(productInCart);
      //         },
      //         child: Container(
      //           width: Dimensions.width25,
      //           height: Dimensions.height25,
      //           decoration: BoxDecoration(
      //             shape: BoxShape.circle,
      //             color: Colors.blue[300],
      //           ),
      //           child: Icon(Icons.add,
      //               size: Dimensions.iconsize18),
      //         ),
      //       ),
      //     ]
      //   );}
      // ),
    ),
  );
  }
}