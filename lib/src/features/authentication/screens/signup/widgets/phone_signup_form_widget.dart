import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/utils/helper/helper_controller.dart';
import '../../../../../common_widgets/buttons/primary_button.dart';
import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../controllers/signup_controller.dart';
class PhoneSignupFormWidget extends StatelessWidget {
  const PhoneSignupFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    String userNumber = '';
    return Container(
      padding: const EdgeInsets.only(top: tFormHeight - 15, bottom: tFormHeight),
      child: Form(
        key: controller.phoneFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntlPhoneField(
              controller: controller.phoneNo,
              initialCountryCode: 'KH',
              decoration: const InputDecoration(
                  label: Text(tPhoneNo,style: TextStyle(color: tDarkColor),),
                  prefixIcon: Icon(LineAwesomeIcons.phone),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: tDarkColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: tDarkColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),

              ),
              onChanged: (val) {
                userNumber = val.completeNumber;
              },
            ),
            const SizedBox(height: tFormHeight - 10),
            Obx(
                  () => TPrimaryButton(
                // isLoading: controller.isLoading.value ? true : false,
                text: tSignup.tr,
                onPressed: controller.isFacebookLoading.value || controller.isGoogleLoading.value
                    ? () {}
                    : controller.isLoading.value
                    ? () {}
                    : () => controller.createPhoneUser(userNumber),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

