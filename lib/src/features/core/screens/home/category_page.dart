import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/core/screens/home/controller/category_controller.dart';
import 'package:merchant/src/routing/route_helper.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);

  final CategoryController categoryController = Get.find();

  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle": "world phone",
      "color": "red",
      "buy": "\$200",
      "price": "\$279",
      "margin": "\$79",
      "images":
          "https://images.unsplash.com/photo-1614722338273-d232c02b32b3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8Zmxvd2VycyUyMGdpZnR8ZW58MHx8MHx8fDA%3D&w=1000&q=80"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle": "",
      "color": "red",
      "buy": "\$200",
      "price": "\$279",
      "margin": "\$79",
      "images":
          "https://www.petalrepublic.com/wp-content/uploads/2022/03/15-Best-Types-of-Flowers-for-Birthday-Gifts.jpeg"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle": "",
      "color": "red",
      "buy": "\$200",
      "price": "\$279",
      "margin": "\$79",
      "images":
          "https://eskacreative.com/wp-content/uploads/2022/08/My-Dear-Bouquet.jpg"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle": "",
      "color": "red",
      "buy": "\$200",
      "price": "\$279",
      "margin": "\$79",
      "images":
          "https://cdn.shopify.com/s/files/1/0430/1514/3581/products/everlasting-rose-flower-bouquet-real-preserved-roses-and-dried-flowerslimited-stocks-947150.jpg?v=1676212660"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle": "",
      "color": "red",
      "buy": "\$200",
      "price": "\$279",
      "margin": "\$79",
      "images":
          "https://images.squarespace-cdn.com/content/v1/5bfd17c63e2d090b269114b9/85d68cc3-a0d4-4373-a5b9-5b9fa4245f3b/ArcadeFlowers-Artisan-Floristry-Ringwood-Hampshire-Wedding-Flowers-www.arcadeflowers.co.uk.jpg?format=1500w"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "subtitle": "",
      "color": "red",
      "buy": "\$200",
      "price": "\$279",
      "margin": "\$79",
      "images":
          "https://www.petalrepublic.com/wp-content/uploads/2022/04/Do-Flowers-Make-Good-Gifts-for-Friends-1024x683.jpeg"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => categoryController.refreshCategoryList(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              // const SizedBox(
              //   height: 8.0,
              // ),
              // HomeSlider(),
              // const SizedBox(
              //   height: 8.0,
              // ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(Dimensions.height8),
                child: Text(
                  "Trend Category",
                  style: TextStyle(
                      // color: tDarkColor,
                      fontSize: Dimensions.font20,
                      fontWeight: FontWeight.bold),
                  textScaleFactor: 1,
                ),
              ),
              Container(margin: EdgeInsets.all(Dimensions.height8), child: _listProduct(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listProduct(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (categoryController)=>
    GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).orientation == Orientation.portrait? 2:3,
          crossAxisSpacing: Dimensions.height10+2,
          mainAxisSpacing: Dimensions.width10+2,
          mainAxisExtent: Dimensions.height190,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categoryController.categoryLst.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () {
              categoryController.getCategoryItems(categoryController.categoryLst[index].id);
              Get.toNamed(RouteHelper.gotoCategoryItem());
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius8),
                color: Theme.of(context).dialogBackgroundColor,
                // border: Border.all(width: Dimensions.width5-4, color: Theme.of(context).primaryColorLight),
                image: DecorationImage(
                    image:
                        NetworkImage(AppConstant.BASE_IMAGE_URL + categoryController.categoryLst[index].image)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radius8),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 2,
                    sigmaY: 2,
                  ),
                  child: Center(
                    child: Text(categoryController.categoryLst[index].name.toUpperCase(),
                      style: TextStyle(color: tWhiteColor, fontSize: Dimensions.font20,fontWeight: FontWeight.bold),
                      textScaleFactor: 1,
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
