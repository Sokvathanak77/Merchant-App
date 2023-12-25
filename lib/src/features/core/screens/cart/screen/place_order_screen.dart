import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/features/core/screens/home/home_screen.dart';
import 'package:merchant/src/features/core/screens/cart/model/api_cart_model.dart';
import 'package:merchant/src/routing/route_helper.dart';

class PlaceOrder extends StatefulWidget {
  const PlaceOrder({super.key});

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  String dropDownValue="ABA";

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Place Order",
            style: TextStyle(color: isDarkMode?tWhiteColor:tDarkColor,fontSize: Dimensions.font18),
            textScaleFactor: 1.0,
          ),
    
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.toNamed(RouteHelper.goAddressScreen());
                  //   },
                  //   child: Container(
                  //     padding: EdgeInsets.all(15),
                  //     width: double.maxFinite,
                  //     height: 100,
                  //     child: Container(
                  //       decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10),boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.grey.withOpacity(0.5),
                  //           spreadRadius: 3,
                  //           blurRadius: 7,
                  //           offset: Offset(0, 3), // changes position of shadow
                  //         ),
                  //       ]),
                  //       padding: EdgeInsets.symmetric(horizontal: 10),
                  //       child: Row(
                  //         children: [
                  //           Icon(Icons.pin_drop,size: 25,),
                  //           SizedBox(width: 5,),
                  //           Text('Add shipping address',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                  //           SizedBox(width: 100,),
                  //           Icon(Icons.arrow_forward_ios),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Container(
                    width: MediaQuery.of(context).size.width*0.96,
                    height: Dimensions.height80,
                    decoration: BoxDecoration(
                      color: isDarkMode?Theme.of(context).dialogBackgroundColor:tWhiteColor,borderRadius: BorderRadius.circular(Dimensions.radius10),boxShadow: [
                      BoxShadow(
                        color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),]
                    ),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: Container(
                      // color: Colors.red,
                      child: Row(
                        children: [
                          Icon(Icons.payment,size: Dimensions.iconsize25,),
                          SizedBox(width: Dimensions.width5,),
                          Text(
                            'Choose PaymentMethod',
                            style: TextStyle(fontSize: Dimensions.font15,fontWeight: FontWeight.bold),
                            textScaleFactor: 1,
                          ),
                          SizedBox(width: Dimensions.width10,),
                          DropdownButton(
                            iconSize: Dimensions.iconsize20,
                            items: [
                              DropdownMenuItem(
                                child: Text('ABA',style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,),
                                value: "ABA",
                              ),
                              DropdownMenuItem(
                                child: Text('Acleda',style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,),
                                value: "Acleda",
                              ),
                              DropdownMenuItem(
                                child: Text('Wing',style: TextStyle(fontSize: Dimensions.font16),textScaleFactor: 1,),
                                value: "Wing",
                              ),
                            ],
                            value: dropDownValue,
                            onChanged: (newitem){
                              setState(() {
                                dropDownValue = newitem!;
                              });
                            }
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: Dimensions.height20,),
                  Text('Product Details',
                    style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold),
                    textScaleFactor: 1.0,
                  ),
                  SizedBox(height: Dimensions.height20,),
                  GetBuilder<ApiCartController>(
                    builder: (cartController) => 
                    cartController.isloaded.value==false?Center(child: CircularProgressIndicator(),):
                      Container(
                      width: double.infinity,
                      
                      child:ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: cartController.productList!.length,
                        itemBuilder: (context, index) {
                          // var productLocal = productController.getItems[index];
                          ApiData product = cartController.productList![index];
                          // var grandTotal = cartController.getItems[index] + grandeTotal;
                          
                          return GestureDetector(
                            onTap: () {
                              // var productIndex = Get.find<ProductController>().productList!.indexOf(productLocal.product);
                              // var popularProductIndex = Get.find<ProductController>().productList!.indexOf(productlocal.product);
                            },
                            child: Column(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  height: Dimensions.height80,
                                  decoration: BoxDecoration(
                                    color: isDarkMode?Theme.of(context).dialogBackgroundColor:tWhiteColor,
                                      border: Border.all(color: Theme.of(context).dialogBackgroundColor),
                                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ]
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: Dimensions.width10 * 9,
                                        height: double.maxFinite,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://images.unsplash.com/photo-1614722338273-d232c02b32b3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VycyUyMGdpZnR8ZW58MHx8MHx8fDA%3D&w=1000&q=80'),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                              BorderRadius.circular(Dimensions.radius10),
                                        ),
                                      ),
                                      SizedBox(width: Dimensions.width10),
                                      Expanded(
                                        child: Container(
                                          // padding: EdgeInsets.symmetric(vertical: 4),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(cartController.productList![index].apiproducts.name ?? "",
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: Dimensions.font15,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                    textScaleFactor: 1.0,
                                                    maxLines: 1),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(right: Dimensions.width10),
                                                    child: Text(
                                                      "x${cartController.productList![index].qty.toInt()}",
                                                      style: TextStyle(fontSize: Dimensions.font16),
                                                      textScaleFactor: 1.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: Dimensions.height10 / 2,
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                      child: Text(
                                                    "\$${cartController.productList![index].unitPrice}",
                                                    style: TextStyle(fontSize: Dimensions.font13),
                                                    textScaleFactor: 1.0,
                                                  )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: Dimensions.height20,)
                              ],
                            ),
                          );
                        },
                      )
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
        
        bottomNavigationBar: GetBuilder<ApiCartController>(builder: (cartController){
          var product = cartController.productList!;
        return Container(
          width: MediaQuery.of(context).size.width,
          height: Dimensions.height180,
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius15),
                  topRight: Radius.circular(Dimensions.radius15)
              ),
              boxShadow: [
                BoxShadow(
                  color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]
          ),
          padding: EdgeInsets.all(Dimensions.height10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.94,
                    height: Dimensions.height50-10,
                    decoration: BoxDecoration(
                        color: isDarkMode?tWhiteColor:tDarkColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius15)),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'SubTotal: ',
                          style: TextStyle(fontSize: Dimensions.font14,fontWeight: FontWeight.bold,      color: isDarkMode?tDarkColor:tWhiteColor),
                          textScaleFactor: 1.0,
                        ),
                        Text(
                          "\$${cartController.apiCartModel!.amount}",
                          style: TextStyle(fontSize: Dimensions.font14,color: isDarkMode?tSecondaryColor:tWhiteColor),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.94,
                    height: Dimensions.height50-10,
                    decoration: BoxDecoration(
                        color: isDarkMode?tWhiteColor:tDarkColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius15)),
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tax Fee: ',
                          style: TextStyle(fontSize: Dimensions.font14,fontWeight: FontWeight.bold,color: isDarkMode?tDarkColor:tWhiteColor),
                          textScaleFactor: 1.0,
                        ),
                        Text(
                          "\$0.0",
                          style: TextStyle(fontSize: Dimensions.font14,color: isDarkMode?tSecondaryColor:tWhiteColor),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Dimensions.width160,
                    height: Dimensions.height55,
                    decoration: BoxDecoration(
                        color: isDarkMode?tWhiteColor:tDarkColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius15)),
                    padding: EdgeInsets.only(left: Dimensions.width5),
                    child: Row(
                      children: [
                        Text(
                          'Total: ',
                          style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold,color: isDarkMode?tDarkColor:tWhiteColor),
                          textScaleFactor: 1.0,
                        ),
                        Text(
                          "\$${cartController.apiCartModel!.amount}",
                          style: TextStyle(fontSize: Dimensions.font16,color: isDarkMode?tSecondaryColor:tWhiteColor),
                          textScaleFactor: 1.0,
                        ),
                      ],
                    ),
                  ),
                   
                    GestureDetector(
                      onTap: () async{
                        cartController.submitOrder(dropDownValue,product);
                      },
                      child: Container(
                        width: Dimensions.width100,
                        height: Dimensions.height55,
                        decoration: BoxDecoration(
                            color: isDarkMode?tWhiteColor:tDarkColor,
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            boxShadow: [
                              BoxShadow(
                                color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ]
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold,color: isDarkMode?tDarkColor:tWhiteColor),
                            textScaleFactor: 1,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ],
          )
        );
      })
      ),
    );
  }
}