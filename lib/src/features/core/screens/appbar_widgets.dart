import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/text_strings.dart';
class AppBarMain extends StatefulWidget {
  const AppBarMain({Key? key}) : super(key: key);

  @override
  State<AppBarMain> createState() => _AppBarMainState();
}

class _AppBarMainState extends State<AppBarMain> {
  @override
  Widget build(BuildContext context) {
    return AppBar(title: Text(tAppName,style: TextStyle(color: tDarkColor,fontSize: 24),),
      actions: <Widget> [
        IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart)),
      ],);
  }
}
