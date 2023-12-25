import 'dart:async';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/constant.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/image_strings.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/features/core/screens/home/home_page.dart';

import '../../../../../routing/route_helper.dart';

class HomeSlider extends StatefulWidget {
  const HomeSlider({Key? key}) : super(key: key);

  @override
  State<HomeSlider> createState() => _HomeSliderState();
}

class _HomeSliderState extends State<HomeSlider> {
  PageController pageController =
  PageController(viewportFraction: 0.85, initialPage: 0);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.slideContainerHeight;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  // final List<Map<String, dynamic>> listSliders = [
  //   {
  //     "title": "Apple",
  //     "Price": "\$1200",
  //     "images":
  //     "https://s.alicdn.com/@img/imgextra/i1/O1CN012j7G3z1edV7yyj85o_!!6000000003894-0-tps-990-400.jpg"
  //   },
  //   {
  //     "title": "Apple",
  //     "Price": "\$1200",
  //     "images":
  //     "https://s.alicdn.com/@img/imgextra/i1/O1CN01WG9ium1L0akmTVntZ_!!6000000001237-2-tps-990-400.png"
  //   },
  //   {
  //     "title": "Apple",
  //     "Price": "\$1200",
  //     "images":
  //     "https://s.alicdn.com/@img/imgextra/i2/O1CN01rYC4hI1lJzSxuJUm1_!!6000000004799-2-tps-990-400.png"
  //   },
  //   {
  //     "title": "Apple",
  //     "Price": "\$1200",
  //     "images":
  //     "https://s.alicdn.com/@img/imgextra/i3/O1CN01kMy6dM1CEUFgfJPiR_!!6000000000049-2-tps-990-400.png"
  //   },
  //   {
  //     "title": "Apple",
  //     "Price": "\$1200",
  //     "images":
  //     "https://s.alicdn.com/@img/imgextra/i1/O1CN01eyOijx29Ci0VRMdyq_!!6000000008032-0-tps-990-400.jpg"
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return GetBuilder<ProductController>(builder: (slideController)=>
      Column(
      children: [
        Container(
          height: _height,
          child: PageView.builder(
              controller: pageController,
              itemCount: slideController.lstSlide.length,
              itemBuilder: (context, index) {
                return _buildPageItem(index);
              }),
        ),
        DotsIndicator(
          dotsCount: slideController.lstSlide.isEmpty?1: slideController.lstSlide.length,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: isDarkMode?tWhiteColor:tDarkColor,
            size: Size.square(Dimensions.height9),
            activeSize: Size(Dimensions.width18, Dimensions.height9),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius5)),
          ),
        ),
      ],
    )
    );
  }

    Widget _buildPageItem(int index) {
      Matrix4 matrix = new Matrix4.identity();
      if (index == _currPageValue.floor()) {
        var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
        var currTrans = _height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, currTrans, 0);
      } else if (index == _currPageValue.floor() + 1) {
        var currScale =
            _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
        var currTrans = _height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1);
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, currTrans, 0);
      } else if (index == _currPageValue.floor() - 1) {
        var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
        var currTrans = _height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1);
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, currTrans, 0);
      } else {
        var currScale = 0.8;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
      }
     
      return GetBuilder<ProductController>(builder: (slideController){
        var slide = slideController.lstSlide[index];
        // print(AppConstant.BASE_IMAGE_URL+slide.image);
        return Transform(
        transform: matrix,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.gotoPageSlider(index));
              },
              child: Container(
                height: _height,
                margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  // color: Colors.red,
                  image: DecorationImage(
                    image: NetworkImage(AppConstant.BASE_IMAGE_URL+slide.image),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      Image.asset(
                        HolderError,
                      fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                decoration: BoxDecoration(
                  // color: tDarkColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven ? tDarkColor : const Color(0xFF9294cc),
                  image: DecorationImage(
                    image: AssetImage(PlaceHolderImage,),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      Image.asset(
                        HolderError,
                      fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                
                // child: FadeInImage.assetNetwork(
                //     placeholder: PlaceHolderImage,
                //     placeholderFit: BoxFit.cover,
                //     fit: BoxFit.cover,
                //     image: AppConstant.BASE_IMAGE_URL+slide.image,
                //     imageErrorBuilder: (context, error, stackTrace) => Image.asset(
                //       HolderError,
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ),
            ),
          ],
        ),
      );
      });
    }
  }

