export 'dart:io';
export 'dart:async';
export 'dart:convert';
export 'package:hive/hive.dart';
import 'package:earnmoney/otherfiles/widgets.dart';
export 'package:flutter/services.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:hive/hive.dart';
export 'package:flutter/material.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:getwidget/getwidget.dart';
export 'package:earnmoney/screens/leadboard.dart';
export 'package:earnmoney/screens/loginopen.dart';
export 'package:earnmoney/screens/wallet.dart';
export 'package:flash/flash.dart';
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
export 'package:cloud_firestore/cloud_firestore.dart';

export 'package:firebase_core/firebase_core.dart';
export 'package:another_flushbar/flushbar.dart';
export 'package:gender_picker/gender_picker.dart';
export 'package:gender_picker/source/enums.dart';
export 'package:earnmoney/screens/task.dart';
export 'package:earnmoney/screens/pay.dart';
export 'package:earnmoney/slot/gameservice.dart';
export 'package:earnmoney/slot/gamescreen.dart';
export 'package:earnmoney/slot/coinchangewidget.dart';
export 'package:google_mobile_ads/google_mobile_ads.dart';
export 'package:month_year_picker/month_year_picker.dart';
export 'package:flutter_localizations/flutter_localizations.dart';
export 'package:awesome_notifications/awesome_notifications.dart';
export 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
export 'package:awesome_dialog/awesome_dialog.dart';
export 'package:line_icons/line_icons.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

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
    /// need to set following properties for best effect of awesome_snackbar_content
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'On Snap!',
      message: MYmessage,

      /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
      contentType: ContentType.failure,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);

  // final snackBar = SnackBar(
  //   backgroundColor: Color.fromARGB(255, 68, 138, 255),
  //   content: Text(MYmessage),
  // );
  // ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showWining(BuildContext context, String MYmessage) {
  AwesomeDialog(
          context: context,
          animType: AnimType.scale,
          dialogType: DialogType.success,
          body: Center(
            child: Text(
              '😃 Your reward added to your wallet.',
            ),
          ),
          keyboardAware: true,
          title: 'Claim now',
          padding: const EdgeInsets.all(5.0),
          btnOkOnPress: () async {})
      .show();
}

void buyMessage(BuildContext context, String MYmessage) {
  AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      dialogType: DialogType.success,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Confirm you are really interested in earning.\n Not a scam user to earn 10x faster.\n😔₹500 ==> ₹10,000 😃\n\nCurrent \n😔15 Watch ads per day only \n😔15 SpinWin per day only\n😔Earn upto  ₹500 per month only\n\nAfter\n😃Unlimited Watch ads per day ✅\n😃Unlimited Spin&Win per day✅\n😃1 hours Task tracking ✅\n😃Withdraw within 1 minute ✅\n😃Slot Machine wining✅\n😃Super Spin ✅ \n😃Earn upto  ₹10,000 per month✅ \n😃Lucky chance to win Iphone 14.📱✅\n",
                style: TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Text(
                    '✅ Confirm just in ₹39 ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '₹129',
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough, fontSize: 18),
                  ),
                  Text(
                    ' limited offer',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Text(
                "✅It will be added to your ballance it's just for confirmation.😃 \n✅Thousands of users already enjoying earning.",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
        ),
      ),
      keyboardAware: true,
      btnOkText: "Confirm ₹39",
      title: 'Continue to pay ₹39 rupees',
      padding: const EdgeInsets.all(5.0),
      btnCancelOnPress: () {
        showMessage(context, 'You missed the big earning opportunity');
      },
      btnOkOnPress: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Pay()),
        );
      }).show();
}

final UseBorder = BoxDecoration(
  border: Border.all(color: Colors.black),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

// {showMessage(context, 'Copied'); }
// final PrColor = Color.fromARGB(255, 34, 151, 247);
// final PrColor = const Color.fromARGB(255, 110, 114, 116);

// final MainColor = Color.fromARGB(255, 76, 175, 80);
final PrColor = Color.fromARGB(255, 33, 150, 243);
final MainColor = Color.fromARGB(255, 33, 150, 243);

final BackColor = Color.fromARGB(255, 241, 244, 241);
// final BackColor = Color.fromARGB(255, 255, 235, 59);
const kprimarycolor = Color.fromARGB(255, 33, 150, 243);
const ksecondarycolor = Color.fromARGB(255, 8, 51, 85);
const kyellowcolor = Color(0xffFFC356);

final texSty = TextStyle(
  fontSize: 16,
  color: Colors.black,
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

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppReferAndEarn?$Refercode',
          refer!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', tasks!);

      GetRequest(
          'https://www.nextonebox.com/earnmoney/NotGetUrls/LeaderBoardReq',
          leadboard!);

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
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppReferAndEarn?$Refercode',
        refer!);

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', tasks!);

    return Future.value(true);
  }
}

callnow() async {
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
