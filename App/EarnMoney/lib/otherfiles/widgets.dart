export 'dart:io';
export 'dart:async';
export 'dart:convert';
export 'package:hive/hive.dart';
import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:earnmoney/otherfiles/widgets.dart';
import 'package:earnmoney/screens/account.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:firebase_auth/firebase_auth.dart';
export 'package:flutter/services.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:hive/hive.dart';
export 'package:flutter/material.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:getwidget/getwidget.dart';
export 'package:earnmoney/screens/explore.dart';
export 'package:earnmoney/screens/leadboard.dart';
export 'package:earnmoney/screens/loginopen.dart';
export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:earnmoney/screens/wallet.dart';
export 'package:flash/flash.dart';
export 'package:earnmoney/screens/web.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:firebase_auth/firebase_auth.dart';
export '../main.dart';
export 'package:earnmoney/screens/accountsetting.dart';
export 'package:earnmoney/screens/notification.dart';
export 'package:flutter/material.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:getwidget/components/avatar/gf_avatar.dart';
export 'package:getwidget/components/list_tile/gf_list_tile.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:flash/flash.dart';
export 'package:flutter/material.dart';
export 'package:getwidget/getwidget.dart';
export 'package:earnmoney/screens/loginopen.dart';
export '../otherfiles/navicati.dart';
export 'package:clipboard/clipboard.dart';
export 'package:share_plus/share_plus.dart';
export 'package:earnmoney/screens/tasksdetaile.dart';
export 'package:animated_splash_screen/animated_splash_screen.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_messaging/firebase_messaging.dart';
export 'package:flutter/material.dart';
export 'package:earnmoney/notificationservice/local_notification_service.dart';
export 'package:hive/hive.dart';
export 'package:path_provider/path_provider.dart';
export 'package:double_back_to_close/double_back_to_close.dart';
export 'package:flutter/services.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:webview_cookie_manager/webview_cookie_manager.dart';
export 'package:earnmoney/screens/loginotp.dart';
export 'package:flutter/gestures.dart';
export 'package:earnmoney/screens/leaddeatail.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:earnmoney/screens/leads.dart';
export 'package:firebase_analytics/firebase_analytics.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';
export 'package:another_flushbar/flushbar.dart';
export 'package:earnmoney/screens/settingotp.dart';
export 'package:gender_picker/gender_picker.dart';
export 'package:gender_picker/source/enums.dart';
export 'package:earnmoney/screens/task.dart';
export 'package:earnmoney/screens/pay.dart';
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
import 'package:http/http.dart' as http;
export 'package:awesome_dialog/awesome_dialog.dart';
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
      Uri.parse('https://www.nextonebox.com/earnmoney/NotGetUrls/Analytics'),
      body: {
        'analytics': MyAnalytic!.toMap().toString(),
        'email': email,
      });
  if (response.body == 'don') {
    await MyAnalytic!.clear();
  }
}

void showMessage(BuildContext context, String MYmessage) {
  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text(MYmessage),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

final UseBorder = BoxDecoration(
  border: Border.all(color: PrColor),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

// {showMessage(context, 'Copied'); }
// final PrColor = Color.fromARGB(255, 34, 151, 247);
final PrColor = const Color.fromARGB(255, 110, 114, 116);

final MainColor = Color.fromARGB(255, 76, 175, 80);
// final MainColor = Color.fromARGB(255, 255, 255, 255);

final BackColor = Color.fromARGB(255, 241, 244, 241);
// final BackColor = Color.fromARGB(255, 255, 235, 59);

final texSty = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w700,
);

Box user = Hive.box('user');
Box? pkacc = Hive.box('pkacc');
Box? lead = Hive.box('leads');
Box? tasks = Hive.box('tasks');
Box? refer = Hive.box('refer');
Box? leadsteps = Hive.box('leadsteps');
Box? widrawstaus = Hive.box('widrawstaus');
Box? MyAnalytic = Hive.box('MyAnalytic');
Box? profitlink = Hive.box('profitlink');
Box? leadboard = Hive.box('LeaderBoard');
Box? globalmessage = Hive.box('globalmessage');
Box? notif = Hive.box('notif');
Box? adsbox = Hive.box('adsbox');
Box? localballance = Hive.box('localballance');
Box? quiz = Hive.box('quiz');
Box? contacts = Hive.box('contacts');

dynamic email = user.get(0)['email'];
dynamic name = user.get(0)['name'];
dynamic Ballance = user.get(0)['Ballance'];
dynamic bal = user.put(1, Ballance);
dynamic Referby = user.get(0)['Referby'];
dynamic completed = user.get(0)['completed'];
dynamic age = user.get(0)['age'];
dynamic gender = user.get(0)['gender'];
dynamic AccountNumber = user.get(0)['Account'];
dynamic phonenumber = user.get(0)['phonenumber'];
dynamic Refercode = user.get(0)['Refercode'];
dynamic EMPremium = user.get(0)['EMPremium'];

void callbackDispatcher() {}

SendAllData() async {
  dynamic lastclick = adsbox!.get(3)['lastclick'];
  DateTime presenttime = DateTime.now();
  Duration difference = presenttime.difference(lastclick);
  if (difference.inHours > 24) {
    if (user.isNotEmpty) {
      http.Response response = await http.get(Uri.parse(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppEarnMoneyAccount?${email}'));
      if (response.reasonPhrase == 'OK') {
        await user.clear();
        await localballance!.clear();
        var da = jsonDecode(response.body);
        for (var a in da) {
          await user.add(a);
          await localballance!.put(0, int.parse(a['Ballance']));
        }
      }

      SendAnalytics();

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppLeads?$Refercode',
          lead!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppReferAndEarn?$Refercode',
          refer!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppWidrawStatus?$email',
          widrawstaus!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', tasks!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppGlobalMessages',
          globalmessage!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/LeaderBoardReq',
          leadboard!);

      // Timer(Duration(seconds: 35), () {
      //   GetRequest(
      //       'https://www.nextonebox.com/earnmoney/NotGetUrls/ShowQuiz?', quiz!);
      // });

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/ProfitLinkShow?$email',
          profitlink!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppUserMessages?$email',
          notif!);

      return Future.value(true);
    } else {}
    adsbox!.put(3, {'lastclick': DateTime.now()});
  }
}

Ontimecall() async {
  if (user.isNotEmpty) {
    http.Response response = await http.get(Uri.parse(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppEarnMoneyAccount?${email}'));
    if (response.reasonPhrase == 'OK') {
      await user.clear();
      await localballance!.clear();
      var da = jsonDecode(response.body);
      for (var a in da) {
        await user.add(a);
        await localballance!.put(0, int.parse(a['Ballance']));
      }
    }

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppLeads?$Refercode',
        lead!);

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppReferAndEarn?$Refercode',
        refer!);

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppWidrawStatus?$email',
        widrawstaus!);

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', tasks!);

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppGlobalMessages',
        globalmessage!);

    GetRequest('https://www.nextonebox.com/earnmoney/NotGetUrls/LeaderBoardReq',
        leadboard!);

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/ProfitLinkShow?$email',
        profitlink!);

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppUserMessages?$email',
        notif!);

    return Future.value(true);
  }
}



callnow()async{

 http.Response response = await http.get(Uri.parse(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppEarnMoneyAccount?${email}'));
    if (response.reasonPhrase == 'OK') {
      await user.clear();
      await localballance!.clear();
      var da = jsonDecode(response.body);
      for (var a in da) {
        await user.add(a);
        await localballance!.put(0, int.parse(a['Ballance']));
      }
    }


}