import 'package:flutter/material.dart';
import 'button_loading_widget.dart';

class TPrimaryButton extends StatelessWidget {
  const TPrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textStyle,
    this.isLoading,
    this.isFullWidth = true,
    this.width = 100.0,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final bool? isLoading;
  final bool isFullWidth;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: isLoading==true
            ? ButtonLoadingWidget()
            : Text(text.toUpperCase(),style: textStyle,textScaleFactor: 1,),
      ),
    );
  }
}
