import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/text_strings.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/features/core/screens/cart/model/api_cart_model.dart';
import 'package:merchant/src/features/core/screens/cart/model/cart_model.dart';
import 'package:merchant/src/features/core/screens/home/home_screen.dart';
import 'package:merchant/src/features/core/screens/home/model/product_model.dart';
import 'package:merchant/src/routing/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  ProductController productController = Get.find();
  ApiCartController cartController = Get.find();

  // @override
  // void initState() {
  //   cartController.getCartData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return SafeArea(
        child: Scaffold(
          // backgroundColor: Colors.white,
          // Theme.of(context).colorScheme.background,
          appBar: AppBar(
            title: Text(
              "Cart",
              style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold,color: isDarkMode?tWhiteColor:tDarkColor),
              textScaleFactor: 1,
            ),
        // actions: <Widget> [
        //   IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart)),
        // ],
          ),
          body: RefreshIndicator(
            onRefresh: () => cartController.refreshCart(),
            child: GetBuilder<ApiCartController>(
              builder: (cartController) => 
              cartController.isloaded.value==false?Center(child: CircularProgressIndicator(),):
                Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
                child:ListView.builder(
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
                          Dismissible(
                            key: ValueKey(index),
                            background: Container(
                              child: Icon(Icons.delete,color: Colors.white,size: Dimensions.iconsize30,),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radius5),color: Colors.red,),
                            ),
                            confirmDismiss: (direction) async {
                              cartController.deleteCartDialog(product,context);
                              return null;
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.96,
                              height: Dimensions.height99,
                              decoration: BoxDecoration(
                                color: Theme.of(context).dialogBackgroundColor,
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
                                          AppConstant.BASE_IMAGE_URL + cartController.productList![index].apiproducts.image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.width10),
                                  Expanded(
                                    child: Container(
                                      // color: Colors.red,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                // color: Colors.red,
                                                width: Dimensions.width190,
                                                child: Text("${cartController.productList![index].apiproducts.name}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: Dimensions.font15,
                                                  fontWeight: FontWeight.bold
                                                ),
                                                maxLines: 1,
                                                textScaleFactor: 1,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(right: Dimensions.width10, top: Dimensions.height10/2),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    cartController.deleteCartDialog(product,context);
                                                  },
                                                  child: Container(
                                                    width: Dimensions.width25,
                                                    height: Dimensions.height25,
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.red[400],
                                                      size: Dimensions.iconsize25,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Container(
                                            child: Text(
                                              "\$${cartController.productList![index].unitPrice}",
                                              style: TextStyle(fontSize: Dimensions.font13),
                                              textScaleFactor: 1,
                                            )
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "total: \$${cartController.productList![index].total}"
                                                 .toString(),
                                                 style: TextStyle(fontSize: Dimensions.font16),
                                                 textScaleFactor: 1,
                                              ),
                                              Container(
                                                child: Row(children: [
                                                  IconButton(
                                                    onPressed: () async{
                                                      // productController.setQuantity(
                                                      //     false, productLocal, product);
                                                      if(cartController.productList![index].qty<2){
                                                        cartController.deleteCartDialog(product,context);
                                                      }else{
                                                        showDialog(
                                                          context: context,
                                                          builder: (context)=>Center(child: CircularProgressIndicator(),),
                                                        );
                                                        await cartController.decreaseCart(product);
                                                        if(cartController.isloaded.value==true){
                                                          Navigator.of(context).pop();
                                                        }
                                                      }
                                                                                      
                                                    },
                                                    icon:Icon(Icons.remove_circle_rounded,
                                                        size: Dimensions.iconsize25+3,
                                                        color: isDarkMode==true ? Colors.grey[300] : tDarkColor,),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.width10,
                                                  ),
                                                  Text("${cartController.productList![index].qty.toInt()}",textScaleFactor: 1,style: TextStyle(fontSize: Dimensions.font16)),
                                                  SizedBox(
                                                    width: Dimensions.width10,
                                                  ),
                                                  IconButton(
                                                    onPressed: () async{
                                                      // productController.setQuantity(true, productLocal, product);
                                                      showDialog(
                                                        context: context,
                                                        builder: (context)=>Center(child: CircularProgressIndicator(),),
                                                      );
                                                      await cartController.increaseCart(product);
                                                      if(cartController.isloaded.value==true){
                                                        Navigator.of(context).pop();
                                                      }
                                                    },
                                                    icon: Icon(Icons.add_circle_rounded,
                                                      size: Dimensions.iconsize25+3,
                                                      color: isDarkMode==true ? Colors.grey[300] : tDarkColor,
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
          ),
        bottomNavigationBar: GetBuilder<ApiCartController>(builder: (cartController){
        return cartController.productList!.length>0 
        ? Container(
          width: double.infinity,
          height: Dimensions.height80,
          decoration: BoxDecoration(
              color: Theme.of(context).dialogBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius15), topRight: Radius.circular(Dimensions.radius15)),
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
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: Dimensions.width160,
                    height: Dimensions.height55,
                    decoration: BoxDecoration(
                        color: isDarkMode?tWhiteColor:tDarkColor,
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        
                    ),
                    padding: EdgeInsets.only(left: Dimensions.width5),
                    child: Row(
                      children: [
                        Text(
                          'Total: ',
                          style: TextStyle(fontSize: Dimensions.font16,color: isDarkMode?tDarkColor:tWhiteColor,fontWeight: FontWeight.bold),
                          textScaleFactor: 1,
                        ),
                        Text(
                          "\$${cartController.apiCartModel!.amount}",
                          style: TextStyle(fontSize: Dimensions.font16,color: isDarkMode?tSecondaryColor:tWhiteColor),
                          textScaleFactor: 1,
                        ),
                      ],
                    ),
                  ),
                   
                    InkWell(
                    onTap: () {
                      Get.toNamed(RouteHelper.goPlaceOrder());
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
                          'Check Out',
                          style: TextStyle(fontSize: Dimensions.font16,color: isDarkMode?tDarkColor:tWhiteColor,fontWeight: FontWeight.bold),
                          textScaleFactor: 1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ):Container();
            })
          ));
  }
}
