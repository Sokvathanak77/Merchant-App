import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:merchant/src/constants/colors.dart';


class ButtonLoadingWidget extends StatelessWidget {
  ButtonLoadingWidget({Key? key, 
    this.color,
  }) : super(key: key);
  final Color? color;
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: isDarkMode?tDarkColor:tWhiteColor),
        ),
        SizedBox(width: 10),
        Text("Loading...")
      ],
    );
  }
}
