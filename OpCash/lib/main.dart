import 'dart:async';
import 'package:youget/HomePage.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:youget/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import 'notification.dart';
import 'package:facebook_app_events/facebook_app_events.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final FacebookAppEvents facebookAppEvents = FacebookAppEvents();
Box? promotionlinks = Hive.box('promotionlinks');
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title2
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
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp();
  initializeNotifications();
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  UnityAds.isInitialized();
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
  var data = await Hive.openBox('wallet');
  var promotionlinks = await Hive.openBox('promotionlinks');
  var leaderboa = await Hive.openBox('leaderboa');
  var widrawreq = await Hive.openBox('widrawreq');
  var account = await Hive.openBox('account');
  var tasks = await Hive.openBox('tasks');
  var coins = await Hive.openBox('coins');
  var vid = await Hive.openBox('vid');
  var adsbox = await Hive.openBox('adsbox');
  var boo = await Hive.openBox('boo');
  var superspin = await Hive.openBox('superspin');
  var ads = await Hive.openBox('ads');
  var socialmedia = await Hive.openBox('socialmedia');
  var limits = await Hive.openBox('limits');
  var VIP = await Hive.openBox('VIP');
  var localballance = await Hive.openBox('localballance');

  if (VIP.isEmpty) {
    VIP.put('VIP', false);
  }

  if (limits.isEmpty) {
    limits.put('pro', false);
    limits.put('watchad', 25);
    limits.put('spin', 20);
    limits.put('sac', 15);
  }
  if (boo.isEmpty) {
    boo.put('bool', false);
  }

  if (superspin.isEmpty) {
    superspin.put('superunlocked', false);
    ads.put('loaded', false);
    superspin.put('click', 0);
    superspin.put('luckspinbalance', 0);
  }

  if (socialmedia.isEmpty) {
    socialmedia.put('shahidapp', false);
    socialmedia.put('yt', false);
    socialmedia.put('notjoin', false);
  }

  if (adsbox.isEmpty) {
    adsbox.put(40, {'clicks': 0});
    adsbox.put(21, {'clicks': 0});
    adsbox.put(20, {'lastclick': DateTime.now()});
    adsbox.put(1, {'clicks': 0});
    adsbox.put(2, {'lastclick': DateTime.now()});

    adsbox.put(4, {'clicks': 0});
    adsbox.put(3, {'lastclick': DateTime.now()});

    adsbox.put(5, {'clicks': 0});
    adsbox.put(6, {'lastclick': DateTime.now()});

    adsbox.put(7, {'clicks': 0});
    adsbox.put(8, {'lastclick': DateTime.now()});

    adsbox.put(9, {'clicks': 0});
    adsbox.put(10, {'lastclick': DateTime.now()});
    adsbox.put('re', {
      'day1': false,
      'day2': false,
      'day3': false,
      'day4': false,
      'day5': false,
      'day6': false,
      'day7': false,
      'day8': false,
      'day9': false,
      'day10': false,
    });
    adsbox.put('reward', {
      'd1': true,
      'd2': false,
      'd3': false,
      'd4': false,
      'd5': false,
      'd6': false,
      'd7': false,
      'd8': false,
      'd9': false,
      'd10': false,
    });
  }
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  DateTime pre_backpress = DateTime.now();

  getd() async {
    http.Response taskget =
        await http.get(Uri.parse('https://realcash.nextonebox.com/what'));
    if (taskget.reasonPhrase == 'OK') {
      adsbox!.put(200, taskget.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    getd();
    return MaterialApp(
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      title: 'You Get',

      // home: notificationn(),
      home: AuthService().handleAuthState(),
    );
  }
}
