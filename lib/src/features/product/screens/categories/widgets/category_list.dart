import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../../constants/colors.dart';
import '../../../../../constants/image_strings.dart';
import '../../../../../constants/text_strings.dart';
import 'package:merchant/src/constants/sizes.dart';


class CategoryList extends StatelessWidget {
  CategoryList({
    Key? key,
    required this.txtTheme,
    required this.isDark,
  }) : super(key: key);

  final TextTheme txtTheme;
  final bool isDark;

  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://transcode-v2.app.engoo.com/image/fetch/f_auto,c_lfill,w_300,dpr_3/https://assets.app.engoo.com/images/0caH3cLF2j2t2CfYlm9KNY.jpeg"
    },

    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://img.traveltriangle.com/blog/wp-content/uploads/2019/04/cover-for-Angkor-Wat-In-Cambodia.jpg"
    },

    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://blog.goway.com/globetrotting/wp-content/uploads/2018/08/Colourful-sunrise-in-Angkor-Wat-Siem-Reap-Cambodia-_679734163.jpg"
    },

    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/63/fe.jpg"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://globalcastaway.com/wp-content/uploads/2019/11/the-ultimate-guide-for-visiting-Angkor-Wat.jpg"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://www.tourismcambodia.com/img/pictures/angkor-wat-lakeview.jpg"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://i.guim.co.uk/img/media/473f6fb563f9805ddc614c8793408ac6e1c66aa7/0_47_6144_3688/master/6144.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=ab2118c33286f76490c78c2b0de0bd50"
    },
    {
      "title": "Samsung Galaxy 11 Pro",
      "price": "\$279",
      "images":
          "https://media.tacdn.com/media/attractions-splice-spp-674x446/06/70/63/fe.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {

    
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 320),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: gridMap.length,
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),color: tDarkColor),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0)),
                    child: Image.network(
                      "${gridMap.elementAt(index)['images']}",
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${gridMap.elementAt(index)['title']}",style: TextStyle(color: tWhiteColor,fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8.0,),
                      Text("${gridMap.elementAt(index)['price']}",style: TextStyle(color: tWhiteColor,fontWeight: FontWeight.bold),),
                    ],
                  ),
                ),
                const SizedBox(height: 8.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.share),color: tWhiteColor,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart),color: tWhiteColor)
                  ],
                )
              ],
            ),
          );
        });
  }
}
