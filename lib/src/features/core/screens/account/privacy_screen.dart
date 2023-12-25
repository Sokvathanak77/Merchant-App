import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/text_strings.dart';
import '../../../../constants/colors.dart';
class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
    Scaffold(
        appBar: AppBar(title: Text("Privacy Policy",style: TextStyle(color: tDarkColor,fontSize: 18),),
          // actions: <Widget> [
          //   IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart)),
          // ],

        ),
        body: Center(
      child: Container(
        child: Text("Privacy Policy"),
      ),
    )));
  }
}
