import 'dart:convert';

import 'package:cashapp/ComonScreens/sharnow.dart';
import 'package:cashapp/ComonScreens/widgets.dart';
export 'dart:io';
export 'package:hive/hive.dart';
export 'package:flutter/services.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:clipboard/clipboard.dart';
export 'package:share_plus/share_plus.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_messaging/firebase_messaging.dart';
export 'package:path_provider/path_provider.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:line_icons/line_icons.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
export 'package:quickalert/models/quickalert_type.dart';
export 'package:quickalert/widgets/quickalert_dialog.dart';
export 'package:google_nav_bar/google_nav_bar.dart';
export 'package:unity_ads_plugin/unity_ads_plugin.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:getwidget/getwidget.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:cashapp/AppScreens/accountsetting.dart';
export 'package:cashapp/AppScreens/account.dart';
export 'package:cashapp/AppScreens/task.dart';
export 'package:cashapp/AppScreens/proScreens/JackPot.dart';
export 'package:cashapp/AppScreens/contactus.dart';
export 'package:cashapp/AppScreens/home.dart';
export 'package:cashapp/AppScreens/leadboard.dart';

export 'package:cashapp/AppScreens/pay.dart';
export 'package:cashapp/AppScreens/proScreens/spin.dart';
export 'package:cashapp/AppScreens/wallet.dart';
export 'package:cashapp/ComonScreens/NavigationScreen.dart';
export 'package:cashapp/ComonScreens/login.dart';

export 'package:facebook_app_events/facebook_app_events.dart';

const MainColor = Color.fromARGB(255, 68, 138, 255);
const SecondaryColor = Color.fromARGB(255, 255, 255, 255);
const kprimarycolor = Color.fromARGB(255, 33, 150, 243);
const ksecondarycolor = Color.fromARGB(255, 114, 181, 235);
const kyellowcolor = Color(0xffFFC356);
final facebookAppEvents = FacebookAppEvents();


Box user = Hive.box('user');
Box? task = Hive.box('tasks');
Box? widrawstaus = Hive.box('widrawstaus');
Box? leadboard = Hive.box('LeaderBoard');
Box? adsbox = Hive.box('adsbox');
Box? localballance = Hive.box('localballance');




dynamic email = user.get(0)['Email'];
dynamic name = user.get(0)['Name'];
dynamic age = user.get(0)['Age'];
dynamic gender = user.get(0)['Gender'];
dynamic AccountNumber = user.get(0)['Account'];
dynamic phonenumber = user.get(0)['PhoneNumber'];


final UseBorder = BoxDecoration(
  border: Border.all(color: Colors.black),
  borderRadius: const BorderRadius.all(Radius.circular(10)),
);

const texSty = TextStyle(
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);

void addtocartfacebook() {
  FacebookAppEvents().logAddToCart(
    id: user.get(0)['email'].toString(),
    type: 'EMPremium',
    price: 79.0,
    currency: 'INR',
  );
}

void buysuccessfacebook() {
  FacebookAppEvents().logAddToCart(
    id: user.get(0)['email'].toString(),
    type: 'EMPremium',
    price: 79.0,
    currency: 'INR',
  );
}

void showMessage(BuildContext context, String MYmessage) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: '',
      message:MYmessage,
      contentType: ContentType.help,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void showWining(BuildContext context, String MYmessage) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: '😃',
      message: ' Your reward added to your wallet.',
      contentType: ContentType.success,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

void buyMessage(BuildContext context, String MYmessage) {
  QuickAlert.show(
    context: context,
    title:
        '✅Try pro to earn 10x faster',
    type: QuickAlertType.confirm,
    text:
        '\n\nCurrent \n8 Watch ads per day only \n8 SpinWin per day only\n8 ScrachCard per day only\n\n Pro\n✅\n₹500 - ₹1000 earn daily \n Unlimited Watch ads ✅\nUnlimited Spin&Win✅\nUnlimited ScrachCard✅\nFast task tracking✅\nInstant Withdrawal ✅ \nLucky chance to win Iphone 14.📱✅\n',
    confirmBtnText: '😃Pro ₹89',
    onConfirmBtnTap: () {
       Navigator.of(context,).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pay(link: 'https://cosmofeed.com/vp/64a93f8e6a2973002b110c91',price: 89.0,)),
      );
    },
    cancelBtnText: 'Cancel',
    onCancelBtnTap: () {
       Navigator.of(context,).pop('dialog');

      showMessage(context, '😔You are missing big earning opportunity');
    },
    confirmBtnColor: Colors.green,
  );
}


fallyoutube(BuildContext context,) {
    QuickAlert.show(
      context: context,
      title:
          'Subscribe us on Youtube \n\n\n Get instant 10 Coins \n\n Get latest updates',
      type: QuickAlertType.confirm,
      confirmBtnText: 'Subscribe',
      onConfirmBtnTap: () async {
      Navigator.of(context,).pop('dialog');
        var url = 'https://www.youtube.com/@nextonebox';
        if (await canLaunch(url)) {
          await launch(url);
        }
          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShareNow()),
                        );
      },
      cancelBtnText: 'Later',
      onCancelBtnTap: () {
         Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShareNow()),
                        );
                  
         Navigator.of(context,).pop('dialog');
      },
      confirmBtnColor: Colors.green,
    );
  }

Future GetRequest(String url, Box DataBox) async {
  http.Response response = await http.get(Uri.parse(url));
  print(response.reasonPhrase);
  if (response.reasonPhrase == 'OK') {
    await DataBox.clear();
    var da = jsonDecode(response.body);
    for (var a in da) {
      await DataBox.add(a);
    }
  }
}



SendAllData() async {
    if (user.isNotEmpty) {
      
      http.Response response = await http.get(Uri.parse(
          'https://fogcash.nextonebox.com/profile/$email/'));
    
      if (response.reasonPhrase == 'OK') {
        await user.clear();
        var da = jsonDecode(response.body);
        await user.add(da);
       await localballance!.put(0, da['Ballance']);
      }
      

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', task!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/LeaderBoardReq',
          leadboard!);

     return Future.value(true);
    } 
      facebookAppEvents.setAdvertiserTracking(enabled: true);
      if (user.isNotEmpty) {
        FacebookAppEvents().logEvent(
          name: 'login',
          parameters: {
            'user': user.get(0)['Email'],
          },
        );
      }
      
  }

void MystryMessage(BuildContext context, String MYmessage) {
  QuickAlert.show(
    context: context,
    title:
        '✅Try Mystry Scrach',
    type: QuickAlertType.confirm,
    text:
        'Win upto ₹150 in one scrach',
    confirmBtnText: '😃Pro ₹19',
    onConfirmBtnTap: () {
       Navigator.of(context,).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Pay(link: 'https://cosmofeed.com/vp/64a93f8e6a2973002b110c91',price: 19.0,)),
      );
    },
    cancelBtnText: 'Cancel',
    onCancelBtnTap: () {
       Navigator.of(context,).pop('dialog');

      showMessage(context, '😔You are missing big earning opportunity');
    },
    confirmBtnColor: Colors.green,
  );
}