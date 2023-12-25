// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/utils/helper/helper_controller.dart';
import '../../../../../common_widgets/buttons/primary_button.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
class PhoneLoginFormWidget extends StatelessWidget {
  const PhoneLoginFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    String userNumber = '';
    return Container(
      padding: const EdgeInsets.only(top: tFormHeight - 15, bottom: tFormHeight),
      child: Form(
        key: controller.phoneFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntlPhoneField(
              disableLengthCheck: true,
              initialCountryCode: 'KH',
              decoration: InputDecoration(
                label: Text(tPhoneNo,style: TextStyle(color: Theme.of(context).hintColor,fontSize: Dimensions.font16),textScaleFactor: 1,),
                prefixIcon: Icon(LineAwesomeIcons.phone),
                enabledBorder: OutlineInputBorder(
                  
                  borderSide: BorderSide(color: Theme.of(context).primaryColorLight,width: Dimensions.width3-1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius20),
                  ),
                  
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColorLight, width: Dimensions.width3-1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.radius20),
                  ),
                ),
              ),
              onChanged: (val) {
                userNumber = val.completeNumber;
              },
            ),
            SizedBox(height: Dimensions.height20),
            Obx(
              () => TPrimaryButton(
            isLoading: controller.isPhoneLoading.value,
            text: tLogin.tr,
            textStyle: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold),
            onPressed: () {
              controller.isPhoneLoading.value==false
              ?
              controller.phoneLoginSignUp(userNumber)
              :
              null;
            } 
            // controller.isFacebookLoading.value || controller.isGoogleLoading.value
            //     ? () {}
            //     : controller.isLoading.value
            //     ? () {}
            //     : 
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
