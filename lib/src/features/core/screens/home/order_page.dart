import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';

import '../../../../constants/constant.dart';

class OrderPage extends StatefulWidget {
  OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin<OrderPage>{
  ApiCartController apiCartController = Get.find<ApiCartController>();

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GetBuilder<ApiCartController>(builder: (cartController){
      return cartController.isOrderEmpty == false? 
      
      Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView.builder(
          itemCount: cartController.cartOrdered.length,
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
          itemBuilder: (_,index){
            var carts = cartController.cartOrdered[index];
            return Column(
              children: [
                SizedBox(height: Dimensions.height10,),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius10),
                  boxShadow: [
                    BoxShadow(
                      color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  color: Theme.of(context).dialogBackgroundColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: Dimensions.height4+1),
                        height: Dimensions.height10*4,
                        child: Text('Invoice: #${cartController.invoiceNumber[index]}',style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold,color: isDarkMode?tWhiteColor:tDarkColor),textScaleFactor: 1,),
                      ),
                      Divider(thickness: 2,),
                      SizedBox(height: Dimensions.height10,),
                      ListView.builder(
                        key: PageStorageKey<String>("page"),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: carts.length,
                        itemBuilder: (_,index){
                          return Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                height: Dimensions.height80,
                                decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(
                                                  Dimensions.radius10),
                                          color: Theme.of(context)
                                              .dialogBackgroundColor,
                                          ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: Dimensions.width10 * 9,
                                      height: double.maxFinite,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                AppConstant.BASE_IMAGE_URL + carts[index].product.image),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(Dimensions.radius10),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width5,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${carts[index].product.name} ",
                                              style: TextStyle(
                                                fontSize: Dimensions.font15,
                                              ),
                                              textScaleFactor: 1,
                                              maxLines: 1),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                width: Dimensions.width25,
                                                height: Dimensions.height25,
                                                child: Text('x${carts[index].qty}',textScaleFactor: 1,)
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
                                                "\$${carts[index].unitPrice}",
                                                style: TextStyle(fontSize: Dimensions.font13),
                                                textScaleFactor: 1,
                                              )),
                                              
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Dimensions.height10,)
                            ],
                          );
                      }),
                      Divider(thickness: 2,),
                      Container(
                        // padding: EdgeInsets.only(top: 5),
                        height: Dimensions.height10*4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total:',style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold,color: isDarkMode?tWhiteColor:tDarkColor),textScaleFactor: 1,),
                            Text("\$${cartController.totalAmount[index]}",textScaleFactor: 1,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.height10,)
              ],
            );
          }
        ),
      ):Container(color: Theme.of(context).scaffoldBackgroundColor,child: Center(child: Text('Order is empty',style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold),textScaleFactor: 1,),));
    });
  }
}