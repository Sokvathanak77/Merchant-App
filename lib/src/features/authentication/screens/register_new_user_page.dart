import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:merchant/src/common_widgets/buttons/primary_button.dart';
import 'package:merchant/src/common_widgets/form/form_header_widget.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/image_strings.dart';
import 'package:merchant/src/constants/sizes.dart';
import 'package:merchant/src/constants/text_strings.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/features/core/screens/home/home_screen.dart';

class NewUserPage extends StatelessWidget {
  final String phone,pass;
  
  NewUserPage({super.key, required this.phone, required this.pass});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    var nameController = TextEditingController();
    var dateController = TextEditingController().obs;
    Future<void> _selectDate() async{
    DateTime? _picked = await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(1900), 
      lastDate: DateTime(2300),
      );

      if(_picked != null){
        dateController.value.text = _picked.toString().split(" ")[0];
      }
    }


    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        
        body: Container(
          padding: EdgeInsets.all(Dimensions.width10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Dimensions.height50,),
                FormHeaderWidget(image: tWelcomeScreenImage, title: "SetUp Your Profile", subTitle: tLoginSubTitle, imageHeight: 0.2,),
                SizedBox(height: Dimensions.height20,),
                Form(
                key: controller.profileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      maxLength: 30,
                      controller: nameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        label: Text("Full Name",textScaleFactor: 1,),
                        
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Enter User Name";
                        }
                      },
                    ),
                    SizedBox(height: Dimensions.height20),
                    TextFormField(
                      controller: dateController.value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.date_range),
                        hintText: "Date of Birth",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          borderSide: BorderSide(color: Colors.grey)
                        )
                      ),
                      readOnly: true,
                      onTap: _selectDate,
                      validator: (value) {
                        if(value!.isEmpty){
                          return "Select Date of Birth";
                        }
                      },
                    ),
                    SizedBox(height: Dimensions.height20),
                  Obx(() =>   
                    TPrimaryButton(
                      text: "Save",
                      textStyle: TextStyle(fontSize: Dimensions.font16,fontWeight: FontWeight.bold),
                      isLoading: loginController.isNewUserLoading.value,
                      onPressed: () {
                        loginController.isNewUserLoading.value==false
                        ?
                        controller.createNewUser(phone, nameController.text, dateController.value.text,pass)
                        :null;
                        // Navigator.pushAndRemoveUntil(
                        //   context, 
                        //   MaterialPageRoute(
                        //     builder: (context) => HomeScreen()
                        //   ), 
                        // ModalRoute.withName("/Home")
                        // );
                      }
                    )),
                  ],
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}