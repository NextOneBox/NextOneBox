export 'dart:io';
export 'package:MyChatAi/App/voic.dart';
export 'dart:async';
export 'dart:convert';
export 'package:hive/hive.dart';
import 'dart:convert';
import 'dart:ffi';
import 'package:another_flushbar/flushbar.dart';
import 'package:MyChatAi/OtherFiles/widgets.dart';
import 'package:MyChatAi/App/home.dart';
import 'package:MyChatAi/OtherFiles/account.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter/services.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:hive/hive.dart';
export 'package:flutter/material.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:getwidget/getwidget.dart';
export 'package:MyChatAi/OtherFiles/loginopen.dart';

export 'package:flash/flash.dart';
export 'package:MyChatAi/OtherFiles/web.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:firebase_auth/firebase_auth.dart';
export '../main.dart';
export 'package:MyChatAi/OtherFiles/accountsetting.dart';

export 'package:flutter/material.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:getwidget/components/avatar/gf_avatar.dart';
export 'package:getwidget/components/list_tile/gf_list_tile.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:flash/flash.dart';
export 'package:flutter/material.dart';
export 'package:getwidget/getwidget.dart';
export 'package:MyChatAi/OtherFiles/loginopen.dart';
export '../OtherFiles/navicati.dart';
export 'package:clipboard/clipboard.dart';
export 'package:share_plus/share_plus.dart';

export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_messaging/firebase_messaging.dart';
export 'package:flutter/material.dart';
export 'package:MyChatAi/OtherFiles/local_notification_service.dart';
export 'package:hive/hive.dart';
export 'package:path_provider/path_provider.dart';
export 'package:double_back_to_close/double_back_to_close.dart';
export 'package:flutter/services.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:webview_cookie_manager/webview_cookie_manager.dart';
export 'package:MyChatAi/OtherFiles/loginotp.dart';
export 'package:flutter/gestures.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

export 'package:firebase_core/firebase_core.dart';
export 'package:another_flushbar/flushbar.dart';
export 'package:gender_picker/gender_picker.dart';
export 'package:gender_picker/source/enums.dart';
// export 'package:unity_ads_plugin/ad/unity_banner_ad.dart';
// export 'package:unity_ads_plugin/unity_ads.dart';
export 'package:google_mobile_ads/google_mobile_ads.dart';
export 'package:month_year_picker/month_year_picker.dart';
// export 'package:facebook_audience_network/facebook_audience_network.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:workmanager/workmanager.dart';
export 'package:awesome_notifications/awesome_notifications.dart';
export 'package:workmanager/workmanager.dart';
export 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
export 'package:flutter_tts/flutter_tts.dart';

Future GetRequest(String url, Box DataBox) async {
  http.Response response = await http.get(Uri.parse(url));
  if (response.reasonPhrase == 'OK') {
    await DataBox.clear();
    var da = jsonDecode(response.body);
    for (var a in da) {
      await DataBox.add(a);
    }
  }
}

SetAnalytic(String KeyNumber) {
  int value = MyAnalytic?.get(KeyNumber, defaultValue: 0);
  print(value);
  MyAnalytic!.put(KeyNumber, value + 1);
}

Future SendAnalytics() async {
  http.Response response = await http.post(
      Uri.parse('https://www.nextonebox.com/nobi/NotGetUrls/Analytics'),
      body: {
        'analytics': MyAnalytic!.toMap().toString(),
        'email': email,
      });
  if (response.body == 'don') {
    await MyAnalytic!.clear();
  }
}




void showMessage(BuildContext context, String MYmessage) {
  showFlash(
      context: context,
      duration: Duration(seconds: 3),
      builder: (_, c) {
        return Flash.bar(
          barrierDismissible: true,
          controller: c,
          backgroundColor: Colors.black,
          position: FlashPosition.top,
          margin: EdgeInsets.all(50),
          borderRadius: BorderRadius.circular(20),
          child: FlashBar(
            padding: EdgeInsets.all(20),
            content: Text(
              MYmessage,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      });
}




final UseBorder = BoxDecoration(
  border: Border.all(color: PrColor),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

// {showMessage(context, 'Copied'); }
final PrColor = const Color.fromARGB(255, 110, 114, 116);
// final PrColor = const Color.fromARGB(255, 110, 114, 116);

final MainColor = Color.fromARGB(255, 127, 128, 129);
// final MainColor = Color.fromARGB(255, 255, 255, 255);

// final BackColor = Color.fromARGB(255, 241, 244, 241);
final BackColor = Colors.white;

final texSty = TextStyle(
  fontSize: 16,
  color: MainColor,
  fontWeight: FontWeight.w700,
);

Box account = Hive.box('account');
Box adtime = Hive.box('adtime');
Box history = Hive.box('history');
Box? MyAnalytic = Hive.box('MyAnalytic');
Box? contacts = Hive.box('contacts');
// Box? getmyads = Hive.box('getmyads');

dynamic email = account.get(0)['email'];
dynamic name = account.get(0)['name'];
dynamic age = account.get(0)['age'];
dynamic gender = account.get(0)['gender'];
dynamic phonenumber = account.get(0)['phonenumber'];
dynamic Refercode = account.get(0)['Refercode'];
dynamic ChatAiPrem = account.get(0)['ChatAiPrem'];

void callbackDispatcher() {}

SendAllData() async {
  dynamic lastclick = adtime.get(3)['lastclick'];
  DateTime presenttime = DateTime.now();
  Duration difference = presenttime.difference(lastclick);
  if (difference.inHours > 24) {
    if (account.isNotEmpty) {
      SendAnalytics();
      // callmyadsnow();
      Ontimecall();
      adtime!.put(3, {'lastclick': DateTime.now()});
      return Future.value(true);
    } else {}
    adtime!.put(3, {'lastclick': DateTime.now()});
  }
}

Ontimecall() async {
  if (account.isNotEmpty) {
    http.Response response = await http.get(Uri.parse(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppEarnMoneyAccount?${email}'));
    if (response.reasonPhrase == 'OK') {
      await account.clear();

      var da = jsonDecode(response.body);
      for (var a in da) {
        await account.add(a);
      }
    }
  }
}

// callmyadsnow() async {
//   http.Response getads =
//       await http.get(Uri.parse('https://www.nextonebox.com/MyAds'));
//   if (getads.reasonPhrase == 'OK') {
//     await getmyads?.clear();

//     var da = jsonDecode(getads.body);
//     for (var a in da) {
//       await getmyads?.add(a);
//     }
//   }
// }



//write for loop and reset at 5 





