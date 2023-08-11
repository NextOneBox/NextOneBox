import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';

import 'package:path_provider/path_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'otherfiles/Authentication.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  var History = await Hive.openBox('History');
  var timework = await Hive.openBox('timework');
  var RealDemo = await Hive.openBox('RealDemo');
  var TradeHistory = await Hive.openBox('TradeHistory');
  var trade = await Hive.openBox('trade');
  var assets = await Hive.openBox('assets');
  var account = await Hive.openBox('account');
  var sendamount = await Hive.openBox('sendamount');
  var userdata = await Hive.openBox('userdata');
  var transhistory = await Hive.openBox('transhistory');
  var alertdata = await Hive.openBox('alertdata');
  var alertdata2 = await Hive.openBox('alertdata2');
  var transwithdralhistory = await Hive.openBox('transwithdralhistory');
  if (sendamount.isEmpty) {
    sendamount.put('depositamount', double.parse('100'));
  }
  if (assets.isEmpty) {
    assets.put('assetslected', false);
  }

  if (RealDemo.isEmpty) {
    RealDemo.put('real', 0);
    RealDemo.put('demo', 20000);
    RealDemo.put(0, false);
    RealDemo.put('tradeamount', 40);
  }
  if (trade.isEmpty) {
    trade.put('index1', 1);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FigTrade',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: handleAuthState(),
    );
  }
}
