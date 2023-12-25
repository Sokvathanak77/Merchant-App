import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:merchant/src/common_widgets/buttons/button_loading_widget.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:merchant/src/constants/image_strings.dart';
import 'package:merchant/src/constants/text_strings.dart';
import 'package:merchant/src/features/authentication/controllers/login_controller.dart';
import 'package:merchant/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:merchant/src/features/core/screens/account/changepin_screen.dart';
import 'package:merchant/src/features/core/screens/account/language_screen.dart';
import 'package:merchant/src/features/core/screens/account/term_screen.dart';
import 'package:merchant/src/features/core/screens/home/category_page.dart';
import 'package:merchant/src/features/core/screens/cart/controller/api_cart_controller.dart';
import 'package:merchant/src/features/core/screens/cart/controller/cart_controller.dart';
import 'package:merchant/src/features/core/screens/home/contact_page.dart';
import 'package:merchant/src/features/core/screens/home/controller/product_controller.dart';
import 'package:merchant/src/features/core/screens/home/order_page.dart';
import 'package:merchant/src/repository/authentication_repository/authentication_repository.dart';
import 'package:merchant/src/routing/route_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../account/account_screen.dart';
import '../account/privacy_screen.dart';
import 'home_page.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

  CartController cartController = Get.find<CartController>();
  ApiCartController apiCartController = Get.find();
  LoginController loginController = Get.put(LoginController());
  ProductController productController = Get.find();
  
  
class _HomeScreenState extends State<HomeScreen> {

  // @override
  // void initState() { 
  //   super.initState();
  //   apiCartController.getCartData();
  //   productController.getUserProfile();
  // }
  
  int _selectedIndex = 0;
  //late PersistentTabController _controller;
  List<Widget> pages = [
    HomePage(),
    CategoryPage(),
    OrderPage(),
    ContactPage(),
    AccountScreen(),
  ];

  

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  // launch function
  void launchlink(String link) async {
  if (await canLaunch(link)) {
    await launch(link);
  } else {
    throw 'Could not launch $link';
  }
}
  
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      appBar: AppBar(
        backgroundColor: isDarkMode?Theme.of(context).scaffoldBackgroundColor:tDarkColor,
        iconTheme: const IconThemeData(color: tWhiteColor),
        title: Text(
          tAppName,
          style: TextStyle(fontSize: Dimensions.font18),
          textScaleFactor: 1,
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Dimensions.radius16),
                            topRight: Radius.circular(Dimensions.radius16)),
                        child: Container(
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ListView(
                            children: [
                              ListTile(
                                onTap: () {
                                  UrlLauncher.launch("tel://087559911",
                                      forceWebView: false,
                                      forceSafariVC: false,
                                      enableJavaScript: false);
                                },
                                // textColor: tDarkColor,
                                // iconColor: tDarkColor,
                                title: Text("087559911",
                                  style: TextStyle(
                                    color: isDarkMode == true ? tWhiteColor : tDarkColor,
                                    fontSize: Dimensions.font16
                                  ),
                                  textScaleFactor: 1,
                                ),
                                subtitle: Text("Call our care center now",style: TextStyle(color: isDarkMode==true?tWhiteColor: Colors.blueGrey,fontSize: Dimensions.font14),
                                textScaleFactor: 1,
                                ),
                                leading: Icon(Icons.phone,color: isDarkMode == true ? tWhiteColor : tDarkColor,size: Dimensions.iconsize24,),
                              ),
                              Divider(indent: Dimensions.width70),
                              ListTile(
                                onTap: () {
                                  UrlLauncher.launch("https://telegram.me/087559911",
                                      forceWebView: false,
                                      forceSafariVC: false,
                                      enableJavaScript: false);
                                },
                                title: Text("087559911",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor,fontSize: Dimensions.font16),textScaleFactor: 1,),
                                subtitle: Text("Telegram our care center now",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey,fontSize: Dimensions.font14),textScaleFactor: 1,),
                                leading: Icon(Icons.telegram_outlined,color: isDarkMode == true ? tWhiteColor : tDarkColor,size: Dimensions.iconsize24,),

                              ),
                              Divider(indent: Dimensions.width10*7),
                              ListTile(
                                onTap: () {
                                  UrlLauncher.launch("https://telegram.me/087559911",
                                      forceWebView: false,
                                      forceSafariVC: false,
                                      enableJavaScript: false);
                                },
                                title: Text("Messenger",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor,fontSize: Dimensions.font16),textScaleFactor: 1,),
                                subtitle: Text("Messenger our care center now",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey,fontSize: Dimensions.font14),textScaleFactor: 1,),
                                leading: Icon(Icons.messenger_outline,color:isDarkMode == true ? tWhiteColor : tDarkColor,size: Dimensions.iconsize24,),

                              ),
                              Divider(indent: Dimensions.width10*7),
                              ListTile(
                                onTap: () {
                                  UrlLauncher.launch("https://wa.me/087559911",
                                      forceWebView: false,
                                      forceSafariVC: false,
                                      enableJavaScript: false);
                                },
                                title: Text("WhatsApp",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor,fontSize: Dimensions.font16),textScaleFactor: 1,),
                                subtitle: Text("WhatsApp our care center now",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey,fontSize: Dimensions.font14),textScaleFactor: 1,),
                                leading: Icon(Icons.message,color: isDarkMode == true ? tWhiteColor : tDarkColor,size: Dimensions.iconsize24,),

                              ),
                              Divider(indent: Dimensions.width10*7),
                              ListTile(
                                onTap: ()async {
                                  const String lat = "42.3540";
                                  const String lng = "71.0586";
                                  const String mapUrl = "geo:$lat,$lng";
                                  if (await canLaunch(mapUrl)) {
                                    await launch(mapUrl);
                                  } else {
                                    throw "Couldn't launch Map";
                                  }
                                },
                                title: Text("Map",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor,fontSize: Dimensions.font16),textScaleFactor: 1,),
                                subtitle: Text("Come to our Shop",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey,fontSize: Dimensions.font14),textScaleFactor: 1,),
                                leading: Icon(Icons.pin_drop_outlined,color: isDarkMode == true ? tWhiteColor : tDarkColor,size: Dimensions.iconsize24,),

                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.phone_in_talk_outlined,color: tWhiteColor,size: Dimensions.iconsize18,)),
            GetBuilder<ApiCartController>(builder: (apiCartController) => 
              GestureDetector(
                onTap: () => apiCartController.amountqty!.value>0
                ?
                Get.toNamed(RouteHelper.goToCart())
                :
                () => null,
                child: Stack(
                  children: [
                    Container(
                      width: Dimensions.width25+20,
                      height: Dimensions.height10*6,
                      child: Icon(Icons.shopping_cart,size: Dimensions.iconsize18,color: tWhiteColor,),
                    ),
                    Positioned(
                      right: Dimensions.width5,
                      top: Dimensions.height10,
                      child: Container(
                        child: apiCartController.amountqty!.value> 0
                            ? Container(
                                width: Dimensions.width15,
                                height: Dimensions.height15,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red[300],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 3,
                                      blurRadius: 7,
                                      offset: Offset(4, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Text(
                                  apiCartController.amountqty!.value.toString(),
                                  style: TextStyle(fontSize: Dimensions.font10,color: tWhiteColor),
                                  textScaleFactor: 1,
                                )),
                              )
                            : Container()
                      ),
                    ),
                  ],
                ),
              )
            )
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          // child: ListView(
          //   padding: EdgeInsets.zero,
          //   children: [
          //     Obx(() => 
                // UserAccountsDrawerHeader(
                //   decoration: BoxDecoration(color: tDarkColor,),
                //   accountName: Text(productController.userName.value), 
                //   accountEmail: Text(productController.userPhone.value),
                  // currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/6/68/Joe_Biden_presidential_portrait.jpg"),),
        
                // ),
              // ),
              
          //     ListTile(
          //       onTap: () {
          //         // debugPrint(userProfileController.userName.value);
          //       },
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("My Favorites"),
          //       leading: const Icon(Icons.favorite),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     Divider(indent: Dimensions.width10*7), //
          //     ListTile(
          //       onTap: () {},
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("Transaction History"),
          //       leading: const Icon(Icons.receipt_long_rounded),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     SizedBox(
          //       height: Dimensions.height8,
          //       child: Container(
          //         color: Colors.black12,
          //       )),
          //     ListTile(
          //       onTap: () {},
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("Submit Feedback"),
          //       leading: const Icon(Icons.comment),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     Divider(indent: Dimensions.width10*7),
          //     ListTile(
          //       onTap: () {},
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("Have any question?"),
          //       subtitle: const Text("Call our care center now"),
          //       leading: const Icon(Icons.question_answer_outlined),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     SizedBox(
          //         height: Dimensions.height50,
          //         child: Container(
          //             padding: EdgeInsets.only(left: Dimensions.width15),
          //             color: Colors.black12,
          //             child: const Row(
          //               children: [
          //                 Text(
          //                   "Settings",
          //                   style: TextStyle(fontWeight: FontWeight.bold),
          //                 )
          //               ],
          //             ))),
          //     ListTile(
          //       onTap: () {
          //         Get.to(() => const ChangePINScreen());
          //       },
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("Change PIN"),
          //       leading: const Icon(Icons.lock_outline),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     Divider(indent: Dimensions.width10*7),
          //     ListTile(
          //       onTap: () {
          //         Get.to(() => const LanguageScreen());
          //       },
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("Language"),
          //       leading: const Icon(Icons.language),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     SizedBox(
          //         height: Dimensions.height8,
          //         child: Container(
          //           color: Colors.black12,
          //         )),
          //     ListTile(
          //       onTap: () {
          //         Get.to(() => const TermScreen());
          //       },
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("Terms and Conditions"),
          //       leading: const Icon(Icons.text_snippet_outlined),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     Divider(indent: Dimensions.width10*7),
          //     ListTile(
          //       onTap: () {
          //         Get.to(() => const PrivacyScreen());
          //       },
          //       textColor: tDarkColor,
          //       iconColor: tDarkColor,
          //       title: const Text("Privacy Policy"),
          //       leading: const Icon(Icons.privacy_tip_outlined),
          //       trailing: const Icon(Icons.arrow_forward_ios),
          //     ),
          //     SizedBox(
          //         height: Dimensions.height8,
          //         child: Container(
          //           color: Colors.black12,
          //         )),
          //     ListTile(
          //       onTap: () async{
          //         var pref = await SharedPreferences.getInstance();
          //         await AuthenticationRepository.instance.auth.signOut();
          //         await loginController.signOut();
          //         await pref.remove("user_token");
          //         Get.offAll(()=>SplashScreen());
          //       },
          //       textColor: Colors.red,
          //       iconColor: Colors.red,
          //       title: const Text("Logout"),
          //       leading: const Icon(Icons.logout_outlined),
          //     ),
          //     Container(
          //       padding: EdgeInsets.all(Dimensions.width10*3),
          //       color: Colors.black12,
          //       child: Column(
          //         children: [
          //           const Text("Follow us"),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceAround,
          //             children: [
          //               IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(
          //                     Icons.facebook,
          //                     color: tDarkColor,
          //                   )),
          //               IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(Icons.tiktok, color: tDarkColor)),
          //               IconButton(
          //                   onPressed: () {},
          //                   icon: const Icon(Icons.youtube_searched_for_outlined,
          //                       color: tDarkColor)),
          //             ],
          //           )
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: GetBuilder<ProductController>(builder: (productController) => 
              Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        color: isDarkMode?Theme.of(context).scaffoldBackgroundColor:tDarkColor,
                        height: MediaQuery.of(context).size.height*0.2,
                      ),
                      CircleAvatar(
                        radius: Dimensions.radius30+23,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          onBackgroundImageError: (exception, stackTrace) {
                            Image.asset(portraitHolder);
                          },
                          backgroundImage: AssetImage(portraitHolder),
                          foregroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/6/68/Joe_Biden_presidential_portrait.jpg"),
                          radius: Dimensions.radius30+20,
                        ),
                      )
                    ]
                  ),
                  SizedBox(height: Dimensions.height10),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width20,right: Dimensions.width20),
                    // height: ,
                    child: Text(
                      "${productController.userName.value}",
                      style: TextStyle(fontSize: Dimensions.font20,fontWeight: FontWeight.bold,color: isDarkMode?tWhiteColor:tDarkColor),
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width20,right: Dimensions.width20),
                    // height: 50,
                    child: RichText(
                      text: TextSpan(
                        children:[
                          TextSpan(text: "Phone:    ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold, color: isDarkMode?tWhiteColor:tDarkColor)),
                          TextSpan(text: productController.userPhone.value,style: TextStyle(fontSize: Dimensions.font18,color: isDarkMode?tWhiteColor:Colors.blue))
                        ] 
                      ),
                    )
                  ),
                  SizedBox(height: Dimensions.height10,),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(top: Dimensions.height10,left: Dimensions.width20,right: Dimensions.width20),
                    height: Dimensions.height50,
                    child: RichText(
                      text: TextSpan(
                        children:[
                          TextSpan(text: "Date of Birth:    ",style: TextStyle(fontSize: Dimensions.font18,fontWeight: FontWeight.bold,color: isDarkMode?tWhiteColor:tDarkColor)),
                          TextSpan(text: productController.userDob.value,style: TextStyle(fontSize: Dimensions.font18,color: isDarkMode?tWhiteColor:Colors.blue))
                        ]
                      ),
                    )
                  ),
                  SizedBox(height: Dimensions.height50-10,),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width25+5),
                    child: GestureDetector(
                      onTap: () async{
                        await AuthenticationRepository.instance.auth.signOut();
                        await loginController.signOut();
                      },
                      child: Container(
                        height: Dimensions.height50,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(Dimensions.radius15),
                          boxShadow: [
                            BoxShadow(
                              color: isDarkMode==false?Colors.grey.withOpacity(0.5):Colors.black12,
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Obx(() => 
                        Center(
                          child: loginController.isLogoutLoading.value==false
                          ?
                          Text(
                            "Log out",
                            style: TextStyle(
                              fontSize: Dimensions.font20,fontWeight: FontWeight.bold,color: Colors.white),
                            textScaleFactor: 1,
                          )
                          :
                          ButtonLoadingWidget()
                        )
                      ),
                    ),
                  ))
                ],
              )
            )
            ,
          ),
        ),
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Fixed
          backgroundColor: isDarkMode?Theme.of(context).scaffoldBackgroundColor:tDarkColor, // <-- This works for fixed
          selectedItemColor: tWhiteColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: Dimensions.font13,
          unselectedFontSize: Dimensions.font13,
          currentIndex: _selectedIndex,
          onTap: onTapNav,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.discount_outlined), label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_outlined), label: "Order"),
            BottomNavigationBarItem(
                icon: Icon(Icons.support_agent), label: "Contact"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_rounded), label: "Account"),
          ]),
      
      floatingActionButton: _selectedIndex >0?Container():
      Container(
        margin: EdgeInsets.only(bottom: Dimensions.height10*3),
        child: SpeedDial(
          backgroundColor: isDarkMode?Colors.grey[300]:tSecondaryColor,
          animatedIcon: AnimatedIcons.menu_close,
          spacing: Dimensions.height4+1,
          children: [
            SpeedDialChild(
              child: Icon(Icons.phone),
              label: 'Phone',
              onTap: (){
                String phoneLink = 'tel://0967087889';
                launch(phoneLink);
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.telegram),
              label: 'Telegram',
              onTap: (){
                String telegramLink = 'https://t.me/vathanax';
                launch(telegramLink);
              }
            ),
            SpeedDialChild(
              child: new Icon(MdiIcons.facebookMessenger),
              label: 'Messenger',
              onTap: (){
                String messengerLink = 'https://m.me/boymini.noheart';
                launch(messengerLink);
              }
            ),
            
            SpeedDialChild(
              child: new Icon(MdiIcons.whatsapp),
              label: 'Whats App',
              onTap: (){
                String whatsappLink= 'https://wa.me/qr/SRBZQNCSJ7RDF1';
                launch(whatsappLink);
              }
            )
          ],
             ),
      ),
    );
  }
}
