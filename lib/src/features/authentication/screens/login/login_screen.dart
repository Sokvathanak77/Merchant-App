import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merchant/src/common_widgets/form/form_header_widget.dart';
import 'package:merchant/src/common_widgets/form/social_footer.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/image_strings.dart';
import 'package:merchant/src/constants/text_strings.dart';
import 'package:merchant/src/features/authentication/screens/login/widgets/phone_login_form_widget.dart';
import 'package:merchant/src/features/authentication/screens/signup/signup_screen.dart';
import '../../../../common_widgets/form/form_divider_widget.dart';
import '../../../../constants/sizes.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(Dimensions.width20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.height55+5,),
                  const FormHeaderWidget(image: tWelcomeScreenImage, title: tLoginTitle, subTitle: tLoginSubTitle),
                  const PhoneLoginFormWidget(),
                  // const TFormDividerWidget(),
                  // SocialFooter(text1: tDontHaveAnAccount, text2: tSignup, onPressed: () => Get.off(() => const SignupScreen())),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
