import 'dart:convert';

import 'package:cashapp/ComonScreens/widgets.dart';
export 'dart:io';
// export 'dart:async';
// export 'dart:convert';
export 'package:hive/hive.dart';
// export 'package:flutter/material.dart';
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
// export 'package:cashapp/ComonScreens/widgets.dart';
export 'package:awesome_dialog/awesome_dialog.dart';
export 'package:google_nav_bar/google_nav_bar.dart';

export 'package:unity_ads_plugin/unity_ads_plugin.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:getwidget/getwidget.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';

export 'package:cashapp/AppScreens/accountsetting.dart';
export 'package:cashapp/AppScreens/account.dart';
export 'package:cashapp/AppScreens/task.dart';
export 'package:cashapp/AppScreens/Superspin.dart';
export 'package:cashapp/AppScreens/contactus.dart';
export 'package:cashapp/AppScreens/home.dart';
export 'package:cashapp/AppScreens/leadboard.dart';
export 'package:cashapp/AppScreens/notification.dart';
export 'package:cashapp/AppScreens/pay.dart';
export 'package:cashapp/AppScreens/spin.dart';
export 'package:cashapp/AppScreens/wallet.dart';
export 'package:cashapp/ComonScreens/NavigationScreen.dart';
export 'package:cashapp/ComonScreens/loginopen.dart';

export 'package:cashapp/slot/gamescreen.dart';

final MainColor = Color.fromARGB(255, 68, 138, 255);
final SecondaryColor = Color.fromARGB(255, 255, 255, 255);
const kprimarycolor = Color.fromARGB(255, 33, 150, 243);
const ksecondarycolor = Color.fromARGB(255, 8, 51, 85);
const kyellowcolor = Color(0xffFFC356);

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

final UseBorder = BoxDecoration(
  border: Border.all(color: Colors.black),
  borderRadius: BorderRadius.all(Radius.circular(10)),
);

final texSty = TextStyle(
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.w700,
);

void showMessage(BuildContext context, String MYmessage) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: MYmessage,
      message: '',
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
  AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "✅Try pro to earn 10x faster.\n✅₹1000  ➡️ ₹10,000 😃\n✅10k+ of users already earning.\n\nCurrent \n😔15 Watch ads per day only \n😔15 SpinWin per day only\n😔Earn upto  ₹1000 per month only\n\n Pro\n😃Unlimited Watch ads ✅\n😃Unlimited Spin&Win✅\n😃1 hours Task tracking ✅\n😃Withdraw within 1 minute ✅\n😃Fast task tracking✅\n😃Unlimited Slot Machine wining✅\n😃Unlimited Super Spin ✅ \n😃Earn upto  ₹10,000 per month✅ \n😃Lucky chance to win Iphone 14.📱✅\n",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      keyboardAware: true,
      btnOkText: "Pro ₹39",
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
