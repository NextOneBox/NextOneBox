export 'dart:io';
export 'package:chatai/App/voic.dart';
export 'dart:async';
export 'dart:convert';
export 'package:hive/hive.dart';
import 'dart:convert';
import 'dart:ffi';
import 'package:chatai/OtherFiles/widgets.dart';
import 'package:chatai/App/home.dart';
import 'package:chatai/OtherFiles/account.dart';
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
export 'package:chatai/OtherFiles/loginopen.dart';
export 'package:flash/flash.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:firebase_auth/firebase_auth.dart';
export '../main.dart';
export 'package:chatai/OtherFiles/accountsetting.dart';
export 'package:flutter/material.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:getwidget/components/avatar/gf_avatar.dart';
export 'package:getwidget/components/list_tile/gf_list_tile.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:flash/flash.dart';
export 'package:flutter/material.dart';
export 'package:getwidget/getwidget.dart';
export 'package:chatai/OtherFiles/loginopen.dart';
export 'package:chatai/OtherFiles/navicati.dart';
export 'package:clipboard/clipboard.dart';
export 'package:share_plus/share_plus.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:firebase_messaging/firebase_messaging.dart';
export 'package:flutter/material.dart';
export 'package:chatai/OtherFiles/local_notification_service.dart';
export 'package:hive/hive.dart';
export 'package:path_provider/path_provider.dart';

export 'package:flutter/services.dart';
export 'package:webview_flutter/webview_flutter.dart';
export 'package:chatai/OtherFiles/loginotp.dart';
export 'package:flutter/gestures.dart';
export 'package:cloud_firestore/cloud_firestore.dart';

export 'package:firebase_core/firebase_core.dart';
export 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
export 'package:awesome_notifications/awesome_notifications.dart';
import 'package:http/http.dart' as http;
export 'package:flutter_tts/flutter_tts.dart';
export 'package:chatai/OtherFiles/history.dart';
export 'package:quickalert/quickalert.dart';
export 'package:quickalert/widgets/quickalert_dialog.dart';
export 'package:chatai/App/image.dart';
export 'package:awesome_notifications/awesome_notifications.dart';
export 'package:chatai/OtherFiles/history.dart';
export 'package:chatai/App/home.dart';
export 'package:chatai/App/voic.dart';
export 'package:http/http.dart';
export 'package:speech_to_text/speech_to_text.dart';
export 'package:unity_ads_plugin/unity_ads_plugin.dart';

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

void showMessage(BuildContext context, String MYmessage) {
  final snackBar = SnackBar(
    backgroundColor: Colors.black,
    content: Text(MYmessage),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

final UseBorder = BoxDecoration(
  border: Border.all(color: PrColor),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

final PrColor = Color.fromARGB(255, 143, 177, 194);
final MainColor = Color.fromARGB(255, 133, 135, 137);
final BackColor = Colors.grey[100]!;

final texSty = TextStyle(
  fontSize: 15,
  color: MainColor,
);

Box account = Hive.box('account');
Box adtime = Hive.box('adtime');
Box history = Hive.box('history');
Box? MyAnalytic = Hive.box('MyAnalytic');
Box? contacts = Hive.box('contacts');
Box? apikey = Hive.box('apikey');

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
      getkey();
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

getkey() async {
  http.Response getads =
      await http.get(Uri.parse('http://nextonebox.com/earnmoney/apikey'));

  if (getads.reasonPhrase == 'OK') {
    await apikey?.clear();
    var da = jsonDecode(getads.body);
    await apikey?.add(da);
  }
}
