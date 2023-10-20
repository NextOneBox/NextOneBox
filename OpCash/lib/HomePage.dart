import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:flutter/services.dart';
import 'package:youget/contactu_us.dart';
import 'package:youget/edit_profile.dart';
import 'package:youget/leaderboard.dart';
import 'package:youget/ReferFriend.dart';
import 'package:youget/utils.dart';
import 'package:youget/webview.dart';
import 'package:youget/withdrawal.dart';
import 'package:youget/withdrawalhistory.dart';
import 'package:quantupi/quantupi.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'luckyspin.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'main.dart';
import 'SpinWheel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'SuperSpin.dart';

// JAKAINBBDLG
Box? adsbox = Hive.box('adsbox');
Box? account = Hive.box('account');
Box? ads = Hive.box('ads');
Box? socialmedia = Hive.box('socialmedia');
Box? localballance = Hive.box('localballance');
var appbarcolor = c1;

class homepage extends StatefulWidget {
  const homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

Widget listTile({
  IconData? icon,
  String? title,
}) {
  return Column(
    children: [
      Divider(),
      ListTile(
        leading: Icon(
          icon,
          color: c1,
        ),
        title: Text(
          title!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: c1,
          size: 15,
        ),
      ),
    ],
  );
}

class _homepageState extends State<homepage> {
  bool isLoading = false;
  var allcoin = account!.get(0)['Ballance'];
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  DateTime pre_backpress = DateTime.now();
  loadunityad() {
    UnityAds.load(
      placementId: 'intrestial_ad_',
      onComplete: (placementId) {
        ads?.put('loaded', true);
      },
    );
  }

  showunityad() {
    UnityAds.showVideoAd(
      placementId: 'intrestial_ad_',
      onSkipped: (placementId) {
        setState(() {
          ads?.put('loaded', false);
        });
      },
      onFailed: (placementId, error, errorMessage) {
        setState(() {
          ads?.put('loaded', false);
        });
      },
      onComplete: (placementId) {
        setState(() {
          ads?.put('loaded', false);
        });
      },
    );
    Fluttertoast.showToast(
        msg: "Ad loading",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  void initState() {
    UnityAds.init(
      gameId: '5423529',
    );

    if (socialmedia?.get('notjoin') == true) {
      Future.delayed(Duration(seconds: 3), () {
        AwesomeDialog(
          context: context,
          keyboardAware: true,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          btnCancelText: "Skip",
          btnOkColor: c1,
          btnOkText: " Join now",
          //  title:               '✅ Make Daily ₹500 use Maga Spin. Many users are daily Earning ₹500 using Maga Spin , Do not miss the big earning opportunity',
          title: 'Join Youtube',
          desc:
              'Get Daily Update In our Youtube channel join our Youtube family',
          btnCancelOnPress: () {
            setState(() {
              socialmedia?.put('notjoin', false);
            });

            Fluttertoast.showToast(
                msg: "You missed the big earning opportunity",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0);
          },
          btnOkOnPress: () async {
            setState(() {
              socialmedia?.put('notjoin', false);
            });

            String youtube = 'https://www.youtube.com/@realcashapp';
            if (await canLaunch(youtube)) {
              await launch(youtube);
            } else {
              throw "Error occured trying to call that number.";
            }
          },
        ).show();
      });
    }
    ;
    getConnectivity();
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == "false") {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  // this function is for when internet is of show alert diolog box
  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == "false") {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

  getuserdata() async {
    var email = account!.get(0)['email'];
    http.Response data = await http.get(
        Uri.parse('https://realcash.nextonebox.com/ShowAccountData?$email'));
    if (data.reasonPhrase == 'OK') {
      await account!.clear();
      var da = jsonDecode(data.body);

      for (var a in da) {
        await account!.add(a);

        await localballance!.put(0, int.parse(a['Ballance']));

        if (a['SuperSpin'] == 'true') {
          superspin!.put('superunlocked', true);
        } else {
          limits!.put('superunlocked', false);
        }
        if (a['Pro'] == 'true') {
          limits!.put('pro', true);
        } else {
          limits!.put('pro', false);
        }

        superspin!.put('luckspinbalance', int.parse(a['LuckySpin']));
      }
    }
  }

  var loading = false;
  //unity
  Rewardedunityad() {
    UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) {
        setState(() {
          loading = false;
        });
        UnityAds.showVideoAd(
            placementId: 'Rewarded_Android',
            onComplete: (placementId) async {
              int clicks = adsbox!.get(7)['clicks'];
              adsbox!.put(7, {'clicks': clicks + 1});
              adsbox!.put(8, {'lastclick': DateTime.now()});
              Fluttertoast.showToast(
                  msg: "You won 5 coins, it take time to update balance",
                  toastLength: Toast.LENGTH_SHORT,
                  backgroundColor: c6,
                  textColor: c3,
                  fontSize: 16.0);
              var ran = 10;

              http.Response response = await http.post(
                  Uri.parse('https://realcash.nextonebox.com/UpdateBallance'),
                  body: {
                    'email': account!.get(0)['email'].toString(),
                    'amount': ran.toString(),
                  });
              setState(() {
                localballance!.put(0, localballance!.get(0) + 10);
              });
            },
            onFailed: (placementId, error, message) => {});
      },
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
  }

  final FacebookAppEvents facebookAppEvents = FacebookAppEvents();

  var repeescolor = c1;
  paymentkro() async {
    try {
      Quantupi zupi = Quantupi(
        receiverUpiId: 'nextonebox@sbi',
        receiverName: 'NextOneBoxCEO',
        transactionRefId: '',
        transactionNote: 'Op',
        amount: 89,
      );
      final response = await zupi.startTransaction();

      // Split the response string into individual key-value pairs
      List<String> keyValuePairs = response.split('&');

      // Iterate over each key-value pair
      for (String pair in keyValuePairs) {
        // Split the pair into key and value
        List<String> keyValuePair = pair.split('=');
        String key = keyValuePair[0];
        String value = keyValuePair[1];

        // Check if the key is "Status"
        if (key == "Status") {
          if (value == 'SUCCESS') {
            setState(() {
              limits?.put('pro', true);
              limits?.put('watchad', 50);
              AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                headerAnimationLoop: false,
                dialogType: DialogType.info,
                showCloseIcon: true,
                title: 'Succes',
                desc: 'Congratulation you are upgraded please restart the app',
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                onDismissCallback: (type) {},
              ).show();
            });

            http.Response response = await http
                .put(Uri.parse('https://realcash.nextonebox.com/pro'), body: {
              'email': account!.get(0)['email'].toString(),
              'Pro': 'true',
            });
            await http.post(
                Uri.parse('https://realcash.nextonebox.com/paymentEmail'),
                body: {
                  'email': account!.get(0)['email'].toString(),
                });
            facebookAppEvents.logPurchase(amount: 9, currency: "INR");
          }
          break;
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Payment Cancel Or App not Found UPI')));
    }
  }

  VipPaymentkro() async {
    try {
      Quantupi zupi = Quantupi(
        receiverUpiId: 'nextonebox@sbi',
        receiverName: 'NextOneBox CEO',
        transactionRefId: '',
        transactionNote: 'Op',
        amount: 129,
      );
      final response = await zupi.startTransaction();

      // Split the response string into individual key-value pairs
      List<String> keyValuePairs = response.split('&');

      // Iterate over each key-value pair
      for (String pair in keyValuePairs) {
        // Split the pair into key and value
        List<String> keyValuePair = pair.split('=');
        String key = keyValuePair[0];
        String value = keyValuePair[1];

        // Check if the key is "Status"
        if (key == "Status") {
          if (value == 'SUCCESS') {
            setState(() {
              facebookAppEvents.logPurchase(amount: 10, currency: "INR");
              VIP?.put('VIP', true);
              superspin?.put('superunlocked', true);
              superspin?.put('luckspinbalance', 50);
              adsbox?.put(40, {'clicks': 0});
              superspin?.put('click', 0);
              limits?.put('watchad', 40);

              AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                showCloseIcon: true,
                title: 'Succes',
                desc: 'Congratulation you are upgraded please restart the app',
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                onDismissCallback: (type) {},
              ).show();
            });
            await http.put(
                Uri.parse('https://realcash.nextonebox.com/superSpin'),
                body: {
                  'email': account!.get(0)['email'].toString(),
                  'SuperSpin': 'true',
                });

            await http.put(
                Uri.parse('https://realcash.nextonebox.com/luckySpin'),
                body: {
                  'email': account!.get(0)['email'].toString(),
                  'LuckySpin': '100',
                });
            await http.post(
                Uri.parse('https://realcash.nextonebox.com/paymentEmail'),
                body: {
                  'email': account!.get(0)['email'].toString(),
                });
          }
          break; // Exit the loop since we have found the Status key
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Payment canceled Or no UPI app found in device.')));
    }
  }

  ///clicks cheack
  clickscheack() {
    dynamic lastclick = adsbox!.get(8)['lastclick'];
    DateTime presenttime = DateTime.now();
    Duration difference = presenttime.difference(lastclick);
    int clicks = adsbox!.get(7)['clicks'];

    if (clicks == limits?.get('watchad')) {
      AwesomeDialog(
        context: context,
        keyboardAware: true,
        dismissOnBackKeyPress: false,
        dialogType: DialogType.success,
        animType: AnimType.bottomSlide,
        btnCancelText: "Cancel",
        btnOkColor: c1,
        btnOkText: "Use",
        title: 'Unlock Spin Super at just ₹79',
        desc:
            'Earn Daily ₹600 by unlocking Spin Super. Dont miss the big earning opportunity. many users are already earning by unlocking superspin',
        btnCancelOnPress: () {
          Fluttertoast.showToast(
              msg: "You missed the big earning opportunity",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: c6,
              textColor: Colors.black,
              fontSize: 16.0);
        },
        btnOkOnPress: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SuperSpin()));
        },
      ).show();

      if (difference.inHours > 10) {
        Rewardedunityad();
        adsbox!.put(7, {'clicks': 0});
        adsbox!.put(8, {'lastclick': DateTime.now()});
      } else {
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: c1,
              content: Text(
                  'You have exceed your Watch limits. Please try after :${10 - difference.inHours} Hours : ${60 - difference.inMinutes} Minutes.')));
        }
      }
    } else {
      Rewardedunityad();
    }
  }

  bool superlocked = superspin?.get('superunlocked');
  bool upgraded = limits?.get('pro');
  bool vip = VIP?.get('VIP');
  @override
  Widget build(BuildContext context) {
    var nam = account!.get(0)['name'];
    var na = nam.split(' ');
    var newname = na[0];
    getuserdata();
    var tasksshow = tasks?.values.toList();

    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          Fluttertoast.showToast(
              msg: "Press Back button again to Exit",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: c6,
              textColor: c3,
              fontSize: 16.0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 187, 214, 236),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 47,
                      child: Container(
                          width: 40,
                          height: 40,
                          child: Image(image: AssetImage('images/youget.png'))),
                    ),
                    Container(
                      // width: 250,
                      height: 50,

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${account!.get(0)['name']}',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${account!.get(0)['email']}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ]),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => editprofile())),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            radius: 16,
                            backgroundColor: c1),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                ),
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => withdrawal()));
                  },
                  child: listTile(
                    icon: FontAwesomeIcons.wallet,
                    title: "Wallet",
                  )),

              // !listTiles-----------------------------ReferPage-------------------
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ReferFriend()));
                  },
                  child: listTile(
                      icon: Icons.copy_all_outlined, title: "Refer Earn")),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => contactus()));
                  },
                  child: listTile(icon: Icons.phone, title: "Contact Us")),

              // !listTiles------------------------------------------------

              GestureDetector(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LeaderBoard()));
                },
                child: listTile(
                    icon: FontAwesomeIcons.trophy, title: "LeaderBord"),
              ),

              // !listTiles------------------------------------------------

              GestureDetector(
                  onTap: () async {
                    String youtube = 'https://www.youtube.com/@realcashapp';
                    if (await canLaunch(youtube)) {
                      await launch(youtube);
                    } else {
                      throw "Error occured trying to call that number.";
                    }
                  },
                  child: listTile(
                    icon: Icons.monetization_on,
                    title: "How To Earn",
                  )),
              SizedBox(
                height: 50,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => privacy()));
                      },
                      child: Text('PrivacyPolicy')),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => termcondation()));
                      },
                      child: Text('Terms&Cond.')),
                ],
              ),
            ],
          ),
        ),
        backgroundColor: c6,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: c1,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          bool result =
                              await InternetConnectionChecker().hasConnection;
                          if (result == true) {
                            AwesomeDialog(
                              context: context,
                              keyboardAware: true,
                              dismissOnBackKeyPress: false,
                              dialogType: DialogType.success,
                              animType: AnimType.bottomSlide,
                              btnCancelText: "Cancel",
                              btnOkText: "Upgrade",
                              btnOkColor: c1,
                              body: Center(
                                  child: Text(
                                'Current plan\n'
                                '*25 watch ads per day\n'
                                '*15 Spin per day\n'
                                '*Withdraw within 5 days\n'
                                '*Spin Super locked\n\n'
                                'Upgrade Pro at just ₹89\n'
                                '✅ Instant withdraw Your money\n'
                                '✅ 30 watch ads per day\n'
                                '✅ Unlimted Spin \n'
                                '✅ No Ads\n'
                                '✅ Daily withdraw',
                              )),
                              btnCancelOnPress: () {
                                Fluttertoast.showToast(
                                    msg:
                                        "You missed the big earning opportunity",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                              },
                              btnOkOnPress: () {
                                paymentkro();
                                facebookAppEvents.logAddToCart(
                                  id: '$email',
                                  type: 'pro',
                                  price: 9.0,
                                  currency: 'INR',
                                );
                              },
                            ).show();
                          } else {
                            Fluttertoast.showToast(
                                msg: "No Iternet Connection",
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: c1,
                                textColor: c6,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width / 4.5,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 193, 7),
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text('upgrade',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white)))),
                      ),
                    ],
                  ),
                ],
              ),
              InkWell(
                onTap: (() {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => withdrawal()));
                }),
                child: Column(
                  children: [
                    Text(
                      '₹${localballance!.get(0) / 10}',
                      style: TextStyle(
                          color: c6, fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'YOUR BALANCE',
                      style: TextStyle(
                          color: c6, fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                    Slider(
                      inactiveColor: Colors.white,
                      activeColor: Colors.green,
                      value: (localballance!.get(0) / 10 <= 250)
                          ? localballance!.get(0) / 10
                          : 250,
                      min: 0,
                      max: 250,
                      onChanged: (newValue) {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //this is small cards

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Card(
                  elevation: elevation,
                  shadowColor: elecolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    // height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Watch&Earn',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  bool result =
                                      await InternetConnectionChecker()
                                          .hasConnection;
                                  if (result == true) {
                                    setState(() {
                                      loading = true;
                                    });
                                    clickscheack();
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "No Iternet Connection",
                                        toastLength: Toast.LENGTH_SHORT,
                                        backgroundColor: c3,
                                        textColor: c6,
                                        fontSize: 16.0);
                                  }
                                },
                                child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 4.5,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        color: c1,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Center(
                                        child: loading
                                            ? Text('loading',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white))
                                            : Icon(Icons.play_arrow,
                                                color: c6))),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (upgraded == true) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SpinWheel()));
                                  } else {
                                    loadunityad();
                                    if (ads?.get('loaded') == true) {
                                      showunityad();
                                    }
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SpinWheel()));
                                  }
                                },
                                child: Card(
                                  elevation: elevation,
                                  shadowColor: elecolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // SizedBox(
                                        //   height: 14,
                                        // ),
                                        Text('Spin Win',
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500)),
                                        // SizedBox(
                                        //   height: 18,
                                        // ),
                                        Container(
                                            width: 50,
                                            height: 50,
                                            child: Image(
                                                image: AssetImage(
                                                    'images/spw.png'))),
                                        Text('Earn Upto ₹6000',
                                            style: TextStyle(
                                                color: c1,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    // SizedBox(height: 0),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (upgraded == true) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SuperSpin()));
                              } else {
                                loadunityad();

                                if (ads?.get('loaded') == true) {
                                  showunityad();
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SuperSpin()));
                              }
                            },
                            child: Card(
                              elevation: elevation,
                              shadowColor: elecolor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SizedBox(
                                    //   height: 10,
                                    // ),
                                    Text('Spin Super',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    Container(
                                        width: 100,
                                        height: 100,
                                        child: Image(
                                            image: AssetImage(
                                                'images/superspin.png'))),
                                    // sh(7),
                                    Text('Earn Upto ₹10000',
                                        style: TextStyle(
                                            color: c1,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => luckySpinWheel()));
                          },
                          child: Card(
                            elevation: elevation,
                            shadowColor: elecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Text('MagaSpin',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  // SizedBox(
                                  //   height: 17,
                                  // ),
                                  Container(
                                      width: 100,
                                      height: 100,
                                      child: Image(
                                          image: AssetImage(
                                              'images/luckyspin.png'))),
                                  // SizedBox(height: 10),
                                  Text('Earn Upto ₹30000',
                                      style: TextStyle(
                                          color: c1,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
              Container(
                height: 500,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tasksshow!.length,
                    itemBuilder: (context, index) {
                      final doucment = tasksshow[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Card(
                          elevation: elevation,
                          shadowColor: elecolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 15),
                            width: MediaQuery.of(context).size.width,
                            // height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: 55,
                                          height: 55,
                                          child: Image.network(tasksshow[index]
                                                  ['image'] ??
                                              'https://play-lh.googleusercontent.com/PCpXdqvUWfCW1mXhH1Y_98yBpgsWxuTSTofy3NGMo9yBTATDyzVkqU580bfSln50bFU')),
                                      Column(
                                        children: [
                                          Text(tasksshow[index]['name'],
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          Container(
                                            width: 100,
                                            child: Text(
                                                tasksshow[index]['description'],
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          String link =
                                              tasksshow[index]['referlink'];

                                          Share.share('$link');
                                        },
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: c1,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Center(
                                                child: Text(
                                                    '  Redeem\n  ₹${tasksshow[index]['price']} ',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.white)))),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
