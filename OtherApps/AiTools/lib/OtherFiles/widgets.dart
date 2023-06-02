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
import 'package:flutter/foundation.dart';
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
export 'package:MyChatAi/OtherFiles/navicati.dart';
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
export 'package:awesome_dialog/awesome_dialog.dart';
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
// export 'package:razorpay_flutter/razorpay_flutter.dart';
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
final PrColor = const Color.fromARGB(255, 110, 114, 116);
// final PrColor = const Color.fromARGB(255, 110, 114, 116);

final MainColor = Color.fromARGB(255, 127, 128, 129);
// final MainColor = Color.fromARGB(255, 255, 255, 255);

// final BackColor = Color.fromARGB(255, 241, 244, 241);
final BackColor = Colors.white;

final texSty = TextStyle(
  fontSize: 15,
  color: MainColor,
);

// Box account = Hive.box('account');
// Box adtime = Hive.box('adtime');
Box history = Hive.box('history');
// Box? MyAnalytic = Hive.box('MyAnalytic');
Box? contacts = Hive.box('contacts');
Box? apikey = Hive.box('apikey');
Box? coins = Hive.box('coins');
Box? adsbox = Hive.box('adsbox');


getkey() async {
  http.Response getads =
      await http.get(Uri.parse('http://nextonebox.com/earnmoney/apikey'));

  if (getads.reasonPhrase == 'OK') {
    await apikey?.clear();
    var da = jsonDecode(getads.body);
    await apikey?.add(da);
  }
}
