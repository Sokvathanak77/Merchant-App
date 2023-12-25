import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/routing/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/constant.dart';
import 'controller/search_controller.dart';
import 'widgets/home_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductController productController = Get.find<ProductController>();
  SearchProductController searchProductController =
      Get.find<SearchProductController>();
  CartController cartController = Get.find<CartController>();
  ApiCartController apiCartController = Get.find<ApiCartController>();
  ScrollController _scrollController = ScrollController();
  // final List<Map<String, dynamic>> gridMap = [
  //   {
  //     "title": "Samsung Galaxy 11 Pro",
  //     "subtitle":"world phone",
  //     "color":"red",
  //     "buy":"\$200",
  //     "price": "\$279",
  //     "margin":"\$79",
  //     "images":
  //         "https://images.unsplash.com/photo-1614722338273-d232c02b32b3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VycyUyMGdpZnR8ZW58MHx8MHx8fDA%3D&w=1000&q=80"
  //   },
  //   {
  //     "title": "Samsung Galaxy 11 Pro",
  //     "subtitle":"",
  //     "color":"red",
  //     "buy":"\$200",
  //     "price": "\$279",
  //     "margin":"\$79",
  //     "images":
  //         "https://www.petalrepublic.com/wp-content/uploads/2022/03/15-Best-Types-of-Flowers-for-Birthday-Gifts.jpeg"
  //   },
  //   {
  //     "title": "Samsung Galaxy 11 Pro",
  //     "subtitle":"",
  //     "color":"red",
  //     "buy":"\$200",
  //     "price": "\$279",
  //     "margin":"\$79",
  //     "images":
  //         "https://eskacreative.com/wp-content/uploads/2022/08/My-Dear-Bouquet.jpg"
  //   },
  //   {
  //     "title": "Samsung Galaxy 11 Pro",
  //     "subtitle":"",
  //     "color":"red",
  //     "buy":"\$200",
  //     "price": "\$279",
  //     "margin":"\$79",
  //     "images":
  //         "https://cdn.shopify.com/s/files/1/0430/1514/3581/products/everlasting-rose-flower-bouquet-real-preserved-roses-and-dried-flowerslimited-stocks-947150.jpg?v=1676212660"
  //   },
  //   {
  //     "title": "Samsung Galaxy 11 Pro",
  //     "subtitle":"",
  //     "color":"red",
  //     "buy":"\$200",
  //     "price": "\$279",
  //     "margin":"\$79",
  //     "images":
  //         "https://images.squarespace-cdn.com/content/v1/5bfd17c63e2d090b269114b9/85d68cc3-a0d4-4373-a5b9-5b9fa4245f3b/ArcadeFlowers-Artisan-Floristry-Ringwood-Hampshire-Wedding-Flowers-www.arcadeflowers.co.uk.jpg?format=1500w"
  //   },
  //   {
  //     "title": "Samsung Galaxy 11 Pro",
  //     "subtitle":"",
  //     "color":"red",
  //     "buy":"\$200",
  //     "price": "\$279",
  //     "margin":"\$79",
  //     "images":
  //         "https://www.petalrepublic.com/wp-content/uploads/2022/04/Do-Flowers-Make-Good-Gifts-for-Friends-1024x683.jpeg"
  //   },
  // ];

  bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 760;
  }

  bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 760;
  }

  
  var isSearch = "".obs;
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    
    // _scrollController.jumpTo(homePageScrollPosition);
    return RefreshIndicator(
        onRefresh: () => productController.refreshData(),
        child: Obx(
          () =>
              // productController.isLoaded.value?
              // apiCartController.isloaded.value==true?
              GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              body: SingleChildScrollView(
                controller: _scrollController,
                
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height8,
                    ),
                    Container(
                      width: double.infinity,
                      height: Dimensions.height50,
                      padding:
                        EdgeInsets.symmetric(horizontal: Dimensions.height10),
                      child: TextField(
                        onChanged: (value) => {
                          isSearch.value = value,
                          searchProductController.filterProduct(value),
                        },
                        decoration: InputDecoration(
                          hintText: 'Search Products',
                          hintStyle: TextStyle(fontSize: 16),
                          prefixIcon: Icon(
                            Icons.search,
                          ),
                        ),
                    ),
                    ),
                    SizedBox(
                      height: Dimensions.height8,
                    ),
                    isSearch.value.length == 0
                        ? const HomeSlider()
                        : Container(),
                    SizedBox(
                      height: Dimensions.height8,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.all(Dimensions.height8),
                      child: Text(
                        "Trend Products",
                        style: TextStyle(
                            fontSize: Dimensions.font20,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode?tWhiteColor:tDarkColor
                            ),
                        textScaleFactor: 1,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.all(Dimensions.height8),
                        child: _listProduct()),
                  ],
                ),
              ),
            ),
          ),
          // ):Center(
          //   child: Container(
          //     color: Colors.transparent,
          //     child: CircularProgressIndicator(
          //       color: Colors.blue[500],
          //     ),
          //   ),
        )
        // :Center(
        //   child: CircularProgressIndicator(),
        // )

        );
  }
  
  Widget _listProduct() {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Obx(() => productController.isLoaded.value
        ?
        // apiCartController.isloaded.value==false?
        // SingleChildScrollView(
        //   child: Container(
        //     height: double.maxFinite,
        //     child: CircularProgressIndicator(
        //       color: Colors.blue[500],
        //     ),
        //   ),
        // ):
        GridView.builder(
            // key: PageStorageKey<String>("Gridview"),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 2
                      : 3,
              crossAxisSpacing: Dimensions.height10 + 2,
              mainAxisSpacing: Dimensions.width10 + 2,
              mainAxisExtent: Dimensions.height290,
            ),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: searchProductController.foundProduct!.length,
            itemBuilder: (_, index) {
              var product = productController.productList![index];
              return GestureDetector(
                onTap: () =>
                    Get.toNamed(RouteHelper.gotoPopularProductDetail(index)),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius8),
                      color: Theme.of(context).dialogBackgroundColor,
                      border: Border.all(width: 1, color: Theme.of(context).primaryColorLight)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius8),
                            topRight: Radius.circular(Dimensions.radius8),
                          ),
                          child: Image.network(
                            AppConstant.BASE_IMAGE_URL + searchProductController.foundProduct![index].products.image,
                            height: Dimensions.height150,
                            width: double.infinity,
                            fit: BoxFit.contain,
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                          top: Dimensions.height8,
                          right: Dimensions.width8,
                          left: Dimensions.width8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                searchProductController.foundProduct![index].products.name ?? "",
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font16
                                ),
                                textScaleFactor: 1,
                              ),
                            ),
                            SizedBox(
                              height: Dimensions.height3,
                            ),
                            Text(
                              "Buy : \$${searchProductController.foundProduct![index].unitPrice}",
                              style: TextStyle(
                                  color: isDarkMode==false?Colors.brown:Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.font15),
                              textScaleFactor: 1,
                            ),
                            SizedBox(
                              height: Dimensions.height4,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Sell : \$${searchProductController.foundProduct![index].products.price}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font15),
                                  textScaleFactor: 1,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.width8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                // color: Colors.red,
                                width: Dimensions.width109,
                                child: Text(
                                  "Margin : \$${searchProductController.foundProduct![index].margin}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.font15),
                                  textScaleFactor: 1,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  showDialog(
                                    // barrierDismissible: false,
                                    context: context,
                                    builder: (context) => Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                  await apiCartController.postCartData(product);
                                  if (apiCartController.isloaded == true) {
                                    Navigator.of(context).pop();
                                  }
                                  // apiCartController.showOverlay(context,apiCartController.isloaded);
                                },
                                icon: Icon(
                                  Icons.add_circle_rounded,
                                  size: Dimensions.iconsize30,
                                ),
                                color: isDarkMode==true ? Colors.grey[300] : tDarkColor,
                                ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            })
        : Padding(
            padding: EdgeInsets.only(top: Dimensions.height10 * 7),
            child: CircularProgressIndicator(
              color: Colors.blue[500],
            ),
          ));
  }

}
