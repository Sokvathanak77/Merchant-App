import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:merchant/src/constants/colors.dart';
import 'package:merchant/src/constants/dimenstion.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  
  
  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Container(
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
                    color: isDarkMode == true ? tWhiteColor : tDarkColor),textScaleFactor: 1,),
            subtitle: Text("Call our care center now",style: TextStyle(color: isDarkMode==true?tWhiteColor: Colors.blueGrey),textScaleFactor: 1,),
            leading: Icon(Icons.phone,color: isDarkMode == true ? tWhiteColor : tDarkColor,),
          ),
          Divider(indent: Dimensions.width10*7),
          ListTile(
            onTap: () {
              UrlLauncher.launch("https://telegram.me/087559911",
                  forceWebView: false,
                  forceSafariVC: false,
                  enableJavaScript: false);
            },
            title: Text("087559911",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor),textScaleFactor: 1,),
            subtitle: Text("Telegram our care center now",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey),textScaleFactor: 1,),
            leading: Icon(Icons.telegram_outlined,color: isDarkMode == true ? tWhiteColor : tDarkColor,),

          ),
          Divider(indent: Dimensions.width10*7),
          ListTile(
            onTap: () {
              UrlLauncher.launch("https://telegram.me/087559911",
                  forceWebView: false,
                  forceSafariVC: false,
                  enableJavaScript: false);
            },
            title: Text("Messenger",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor),textScaleFactor: 1,),
            subtitle: Text("Messenger our care center now",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey),textScaleFactor: 1,),
            leading: Icon(Icons.messenger_outline,color:isDarkMode == true ? tWhiteColor : tDarkColor),

          ),
          Divider(indent: Dimensions.width10*7),
          ListTile(
            onTap: () {
              UrlLauncher.launch("https://wa.me/087559911",
                  forceWebView: false,
                  forceSafariVC: false,
                  enableJavaScript: false);
            },
            title: Text("WhatsApp",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor),textScaleFactor: 1,),
            subtitle: Text("WhatsApp our care center now",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey),textScaleFactor: 1,),
            leading: Icon(Icons.message,color: isDarkMode == true ? tWhiteColor : tDarkColor,),

          ),
          Divider(indent: Dimensions.width10*7,),
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
            title: Text("Map",style: TextStyle(color: isDarkMode == true ? tWhiteColor : tDarkColor),textScaleFactor: 1,),
            subtitle: Text("Come to our Shop",style: TextStyle(color: isDarkMode == true ? tWhiteColor : Colors.blueGrey),textScaleFactor: 1,),
            leading: Icon(Icons.pin_drop_outlined,color: isDarkMode == true ? tWhiteColor : tDarkColor,),

          ),


        ],
      ),
    );
  }
}