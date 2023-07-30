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
export 'package:awesome_notifications/awesome_notifications.dart';
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
final FacebookAppEvents facebookAppEvents = FacebookAppEvents();

Box user = Hive.box('user');
Box? task = Hive.box('tasks');
Box? widrawstaus = Hive.box('widrawstaus');
Box? leadboard = Hive.box('LeaderBoard');
Box? videos = Hive.box('videos');
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

class showMessage {
  static void show(BuildContext context, String MYmessage) {
    final overlay = Overlay.of(context);

    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            child: Card(
              color: Colors.black54,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  MYmessage,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Remove the toast after a short delay
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

void buyVip(BuildContext context, String MYmessage) {
  QuickAlert.show(
    context: context,
    title: '✅Become Vip at just ₹149',
    type: QuickAlertType.confirm,
    text: '✅withdraw Your money in 1 minute\n'
        '✅ 50 watch ads per day\n'
        '✅ Super Spin Unlocked\n'
        '✅ Lucky Spin Unlocked\n'
        '✅ 24/7 Costumer Support\n'
        '✅ Unlimted Spin\n'
        '✅ Unlimted Scratch\n'
        '✅ Daily withdraw upto ₹1000',
    confirmBtnText: 'Pay ₹149',
    onConfirmBtnTap: () {
      Navigator.of(
        context,
      ).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Pay(
                  link: 'https://cosmofeed.com/vp/64a93f8e6a2973002b110c91',
                  price: 149.0,
                  type: 'vip',
                )),
      );
    },
    cancelBtnText: 'Cancel',
    onCancelBtnTap: () {
      Navigator.of(
        context,
      ).pop('dialog');

      showMessage.show(context, '😔You are missing big earning opportunity');
    },
    confirmBtnColor: Colors.green,
  );
}

void buyMessage(BuildContext context, String MYmessage) {
  QuickAlert.show(
    context: context,
    title: '✅Try pro to earn 10x faster now',
    type: QuickAlertType.confirm,
    text:
        '\n\nCurrent \n10 Watch ads per day only \n10 SpinWin per day only\n10 ScratchCard per day only\n\n Pro\n✅\n₹700 - ₹1000 earn daily \n Unlimited Watch ads ✅\nUnlimited Spin&Win✅\nUnlimited ScratchCard✅\nFast task tracking✅\nInstant Withdrawal ✅ \nLucky chance to win Iphone 14.📱✅\n',
    confirmBtnText: '😃Pro ₹89 only',
    onConfirmBtnTap: () {
      Navigator.of(
        context,
      ).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Pay(
                  link: 'https://cosmofeed.com/vp/64a93f8e6a2973002b110c91',
                  price: 89.0,
                  type: 'Pro',
                )),
      );
    },
    cancelBtnText: 'Cancel',
    onCancelBtnTap: () {
      Navigator.of(
        context,
      ).pop('dialog');

      showMessage.show(context, '😔You are missing big earning opportunity');
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

HowEarnPoster() async {
  http.Response response =
      await http.get(Uri.parse('https://fogcash.nextonebox.com/poster'));
  var da = jsonDecode(response.body);
  adsbox!.put(1001, {'image': da[0]['image']});
  GetRequest('https://fogcash.nextonebox.com/videos', videos!);
}

SendAllData() async {
  if (user.isNotEmpty) {
    http.Response response = await http
        .get(Uri.parse('https://fogcash.nextonebox.com/profile/$email/'));

    if (response.reasonPhrase == 'OK') {
      await user.clear();
      var da = jsonDecode(response.body);
      await user.add(da);
      await localballance!.put(0, da['Ballance']);
    }

    GetRequest(
        'https://www.nextonebox.com/earnmoney/NotGetUrls/AppTasks', task!);

    GetRequest('https://www.nextonebox.com/earnmoney/NotGetUrls/LeaderBoardReq',
        leadboard!);
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();

    if (user.get(0)['MessageKey'] != token) {
      http.Response response = await http.put(
          Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
          body: {
            'Email': email.toString(),
            'MessageKey': token.toString(),
          });
      print(response.body);
    }

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
    title: '✅Try Mystry Scratch now',
    type: QuickAlertType.confirm,
    text: 'Win upto ₹150 in one Scratch',
    confirmBtnText: '₹39 only',
    onConfirmBtnTap: () {
      Navigator.of(
        context,
      ).pop('dialog');
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const Pay(
                link: 'https://cosmofeed.com/vp/64a93f8e6a2973002b110c91',
                price: 39.0,
                type: 'Scratch Card')),
      );
    },
    cancelBtnText: 'Cancel',
    onCancelBtnTap: () {
      Navigator.of(
        context,
      ).pop('dialog');

      showMessage.show(context, 'You are Losing out ₹150');
    },
    confirmBtnColor: Colors.green,
  );
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      this.color = Colors.white,
      this.backgroundColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: color),
      ));
}
