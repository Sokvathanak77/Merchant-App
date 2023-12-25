import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/core/screens/home/controller/category_controller.dart';

class CategoryItemPage extends StatelessWidget {
  CategoryItemPage({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.find<CategoryController>();

  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle":"world phone",
      "color":"red",
      "buy":"\$200",
      "price": "\$279",
      "margin":"\$79",
      "images":
      "https://images.unsplash.com/photo-1614722338273-d232c02b32b3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VycyUyMGdpZnR8ZW58MHx8MHx8fDA%3D&w=1000&q=80"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle":"",
      "color":"red",
      "buy":"\$200",
      "price": "\$279",
      "margin":"\$79",
      "images":
      "https://www.petalrepublic.com/wp-content/uploads/2022/03/15-Best-Types-of-Flowers-for-Birthday-Gifts.jpeg"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle":"",
      "color":"red",
      "buy":"\$200",
      "price": "\$279",
      "margin":"\$79",
      "images":
      "https://eskacreative.com/wp-content/uploads/2022/08/My-Dear-Bouquet.jpg"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle":"",
      "color":"red",
      "buy":"\$200",
      "price": "\$279",
      "margin":"\$79",
      "images":
      "https://cdn.shopify.com/s/files/1/0430/1514/3581/products/everlasting-rose-flower-bouquet-real-preserved-roses-and-dried-flowerslimited-stocks-947150.jpg?v=1676212660"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle":"",
      "color":"red",
      "buy":"\$200",
      "price": "\$279",
      "margin":"\$79",
      "images":
      "https://images.squarespace-cdn.com/content/v1/5bfd17c63e2d090b269114b9/85d68cc3-a0d4-4373-a5b9-5b9fa4245f3b/ArcadeFlowers-Artisan-Floristry-Ringwood-Hampshire-Wedding-Flowers-www.arcadeflowers.co.uk.jpg?format=1500w"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle":"",
      "color":"red",
      "buy":"\$200",
      "price": "\$279",
      "margin":"\$79",
      "images":
      "https://www.petalrepublic.com/wp-content/uploads/2022/04/Do-Flowers-Make-Good-Gifts-for-Friends-1024x683.jpeg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Obx(() => 
    Scaffold(
      appBar: AppBar(
        title: Text( categoryController.isNoCategory.value ==true? "":
          categoryController.categoryName.value,
          style: TextStyle(color: tWhiteColor, fontSize: Dimensions.font18),
          textScaleFactor: 1,
          ),
        backgroundColor: isDarkMode?Theme.of(context).scaffoldBackgroundColor:tDarkColor,
        iconTheme: const IconThemeData(color: tWhiteColor),
      ),
      body: categoryController.isLoadedCategory.value==false
        ?
        Center(
          child: CircularProgressIndicator(
            color: Colors.blue[500],
          )
        )
        :
        categoryController.isNoCategory.value ==true
        ?
        Center(child: Text("No Product",style: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold),textScaleFactor: 1,),)
        :
        Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // const SizedBox(
              //   height: 8.0,
              // ),
              // HomeSlider(),
              // const SizedBox(
              //   height: 8.0,
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   margin: EdgeInsets.all(Dimensions.height8),
              //   child: Text("Trend Category",style: TextStyle(color: tDarkColor,fontSize: Dimensions.font20,fontWeight: FontWeight.bold),),
              // ),
              Container(margin: EdgeInsets.all(Dimensions.height8), child: _listProduct(context)),
    
            ],
          ),
        ),
      ),
    ));
  }

  Widget _listProduct(BuildContext context) {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Obx(() => 
    GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait? 2:3,
          crossAxisSpacing: Dimensions.height10+2,
          mainAxisSpacing: Dimensions.width10+2,
          mainAxisExtent: Dimensions.height290,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryController.categoryItem.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () async{
              // categoryController.getCategoryItems(index);
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius8),
                  color: Theme.of(context).dialogBackgroundColor,
                  border: Border.all(width: Dimensions.width5-4, color: Theme.of(context).primaryColorLight)),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius8),
                        topRight: Radius.circular(Dimensions.radius8),
                      ),
                      child: Image.network(
                        "${gridMap.elementAt(index)['images']}",
                        height: Dimensions.height130+20,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: Dimensions.height8,right: Dimensions.width8,left: Dimensions.width8,bottom: Dimensions.height3-1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(categoryController.categoryItem[index].products.name??"",
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
                          "Buy : \$${categoryController.categoryItem[index].unitPrice}",
                          style: TextStyle(
                            color: isDarkMode==false?Colors.brown:Colors.red, 
                            fontWeight: FontWeight.bold,fontSize: Dimensions.font15),
                            textScaleFactor: 1,
                        ),
                        SizedBox(
                          height: Dimensions.height4,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Sell : \$${categoryController.categoryItem[index].products.price}",
                              style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold,fontSize: Dimensions.font15),
                              textScaleFactor: 1,
                              
                            ),
                          ],)
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: Dimensions.width112,
                        child: Padding(
                          padding: EdgeInsets.only(left: Dimensions.width8-1),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              "Margin : \$${categoryController.categoryItem[index].products.margin}",
                              style: TextStyle(
                                    color: Colors.red, fontWeight: FontWeight.bold,fontSize: Dimensions.font15),
                              textScaleFactor: 1,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add_circle_rounded,
                          size: Dimensions.iconsize30,
                        ),
                        color: isDarkMode == true
                              ? Colors.grey[300]
                              : tDarkColor)
                    ],
                  )
                ],
              ),
            ),
          );
        }));
  }
}
