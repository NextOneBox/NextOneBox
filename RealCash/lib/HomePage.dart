import 'package:facebook_app_events/facebook_app_events.dart';
import 'package:quantupi/quantupi.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dailyreward.dart';
import 'luckyspin.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cash/welcome.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Widget.dart';
import 'quiz_file.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cash/TaskDetails.dart';
import 'package:hive/hive.dart';
import 'main.dart';
import 'sacratch_win.dart';
import 'package:firebase_database/firebase_database.dart';
import 'SpinWheel.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:io';
import 'Colors.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'SuperSpin.dart';

// JAKAINBBDLG
Box? adsbox = Hive.box('adsbox');
Box? account = Hive.box('account');
Box? ads = Hive.box('ads');
Box? socialmedia = Hive.box('socialmedia');
var appbarcolor = c1;

class homepage extends StatefulWidget {
  const homepage({
    Key? key,
  }) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
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
      gameId: '5366239',
    );

    if (socialmedia?.get('yt') == false) {
      Future.delayed(Duration(seconds: 2), () {
        AwesomeDialog(
          context: context,
          keyboardAware: true,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,

          btnCancelText: "Skip",
          btnOkText: " Join now",
          //  title:               '✅ Make Daily ₹500 use lucky spin. Many users are daily Earning ₹500 using lucky spin , Do not miss the big earning opportunity',
          title: 'Join Telegram',
          desc:
              'Get Daily Update In our Telegram channel join our Telegram family',
          btnCancelOnPress: () {
            setState(() {
              socialmedia?.put('yt', true);
              socialmedia?.put('notjoin', true);
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
              socialmedia?.put('yt', true);
            });

            String youtube = 'https://t.me/nextonebox';
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
                icon: '@mipmap/launcher_icon',
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
    print('object');
    var email = account!.get(0)['email'];
    http.Response data = await http.get(
        Uri.parse('https://realcash.nextonebox.com/ShowAccountData?$email'));
    if (data.reasonPhrase == 'OK') {
      await account!.clear();
      var da = jsonDecode(data.body);
      for (var a in da) {
        await account!.add(a);

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
              var ran = 5;
              http.Response response = await http.post(
                  Uri.parse('https://realcash.nextonebox.com/UpdateBallance'),
                  body: {
                    'email': account!.get(0)['email'].toString(),
                    'amount': ran.toString(),
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
        receiverUpiId: 'nextonebox.51084093@sbi',
        receiverName: 'NextOneBox CEO',
        transactionRefId: '',
        transactionNote: '${account!.get(0)['name']}.',
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
              limits?.put('watchad', 20);
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

            http.Response response = await http
                .put(Uri.parse('https://realcash.nextonebox.com/pro'), body: {
              'email': account!.get(0)['email'].toString(),
              'Pro': 'true',
            });
            await http.post(
                Uri.parse('https://fogcash.nextonebox.com/ContactUs'),
                body: {
                  'message': "${account!.get(0)['email']}",
                });
          }
          break;
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: c1, content: Text('Please select a UPI app for payment. \n Or no UPI app found in device .')));
    }
  }

  VipPaymentkro() async {
    try {
      Quantupi zupi = Quantupi(
        receiverUpiId: 'nextonebox.51084093@sbi',
        receiverName: 'NextOneBox CEO',
        transactionRefId: '',
        transactionNote: '${account!.get(0)['name']}.',
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
              VIP?.put('VIP', true);
              superspin?.put('superunlocked', true);
              superspin?.put('luckspinbalance', 50);
              adsbox?.put(40, {'clicks': 0});
              superspin?.put('click', 0);
              limits?.put('watchad', 35);

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
                Uri.parse('https://fogcash.nextonebox.com/ContactUs'),
                body: {
                  'message': "${account!.get(0)['email']}",
                });
          }
          break; // Exit the loop since we have found the Status key
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: c1, content: Text('Please select a UPI app for payment. \n Or no UPI app found in device .')));
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
        btnOkText: "Use",
        title: 'Unlock super spin at just ₹79',
        desc:
            'Earn Daily ₹600 by unlocking super spin. Dont miss the big earning opportunity. many users are already earning by unlocking superspin',
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
    var as = account!.get(0)['Ballance'];
    var a = int.parse(as);
    var b = a / 10;
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
        backgroundColor: c6,
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: c1,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'RealCash',
                style: TextStyle(color: c6, fontWeight: FontWeight.w700),
              ),
              Column(
                children: [
                  Text(
                    '₹${b}',
                    style: TextStyle(
                        color: c6, fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'YOUR BALANCE',
                    style: TextStyle(
                        color: c6, fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ],
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              //this is small cards
              Container(
                height: 210,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tasksshow!.length,
                    itemBuilder: (context, index) {
                      final doucment = tasksshow[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Car1(tasksshow: doucment)));
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                                shadowColor: elecolor,
                                elevation: elevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    width: 311,

                                    // height: 200,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Card(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  width: 55,
                                                  height: 55,
                                                  child: Image.network(
                                                      tasksshow[index]
                                                          ['image'])),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  tasksshow[index]['name'],
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(tasksshow[index]['work'],
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Colors.red[300])),
                                              ],
                                            ),
                                            Container(
                                                width: 45,
                                                height: 45,
                                                decoration: BoxDecoration(
                                                    color: c1,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: Center(
                                                    child: Text(
                                                        "₹${tasksshow[index]['price']}",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)))),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 6, right: 3),
                                          child: Text(
                                              tasksshow[index]['description'],
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black)),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Car1(
                                                        tasksshow: doucment)));
                                          },
                                          child: Container(
                                              width: 200,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                  color: c1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: Center(
                                                  child: Text('Claim Now',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w500)))),
                                        ),
                                      ],
                                    )))),
                      );
                    }),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: dailyreward()),

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
                              Icon(
                                Icons.redeem,
                                color: Colors.lightGreen,
                                size: 40,
                              ),
                              Text('Watch Videos & Earn',
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
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //////pro version
              upgraded
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        elevation: elevation,
                        shadowColor: elecolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
                                    Icon(
                                      FontAwesomeIcons.explosion,
                                      color: Colors.lightGreen,
                                      size: 35,
                                    ),
                                    Text('Boost Your Earning 10x',
                                        style: TextStyle(
                                            fontSize: 14,
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
                                          AwesomeDialog(
                                            context: context,
                                            keyboardAware: true,
                                            dismissOnBackKeyPress: false,
                                            dialogType: DialogType.success,
                                            animType: AnimType.bottomSlide,
                                            btnCancelText: "Cancel",
                                            btnOkText: "Upgrade",
                                            body: Center(
                                                child: Text(
                                              'Current plan\n'
                                              '*5 watch ads per day\n'
                                              '*15 Spin per day\n'
                                              '*15 Scratch per day\n'
                                              '*Withdraw within 5 days\n'
                                              '*Super Spin locked\n\n'
                                              'Upgrade Pro at just ₹89\n'
                                              '✅ Instant withdraw Your money\n'
                                              '✅ 30 watch ads per day\n'
                                              '✅ Unlimted Spin \n'
                                              '✅ Unlimted Scratch \n'
                                              '✅ No Ads\n'
                                              '✅ Daily withdraw',
                                            )),
                                            btnCancelOnPress: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "You missed the big earning opportunity",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  backgroundColor: Colors.white,
                                                  textColor: Colors.black,
                                                  fontSize: 16.0);
                                            },
                                            btnOkOnPress: () {
                                              paymentkro();
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: c1,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                              child: Text('upgrade',
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
                    ),
              vip
                  ? Container()
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Card(
                        elevation: elevation,
                        shadowColor: elecolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 15),
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
                                    Icon(
                                      Icons.diamond,
                                      size: 40,
                                      color: Colors.red,
                                    ),
                                    Text('Become VIP Member',
                                        style: TextStyle(
                                            fontSize: 14,
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
                                          AwesomeDialog(
                                            context: context,
                                            keyboardAware: true,
                                            dismissOnBackKeyPress: false,
                                            dialogType: DialogType.success,
                                            animType: AnimType.bottomSlide,
                                            btnCancelText: "Cancel",
                                            btnOkText: "pay ₹129",
                                            body: Center(
                                                child: Column(
                                              children: [
                                                Text(
                                                  'Became VIP at just ₹129\n',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                    '✅ Instant withdraw Your money\n'
                                                    '✅ 50 watch ads per day\n'
                                                    '✅ Super Spin Unlocked\n'
                                                    '✅ Lucky Spin Unlocked\n'
                                                    '✅ 24/7 Costumer Support\n'
                                                    '✅ Unlimted Spin\n'
                                                    '✅ Unlimted Scratch\n'
                                                    '✅ Daily withdraw upto ₹1000',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600))
                                              ],
                                            )),
                                            btnCancelOnPress: () {
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "You missed the big earning opportunity",
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  backgroundColor: Colors.white,
                                                  textColor: Colors.black,
                                                  fontSize: 16.0);
                                            },
                                            btnOkOnPress: () {
                                              VipPaymentkro();
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4.5,
                                          height: 35,
                                          decoration: BoxDecoration(
                                              color: c1,
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                          child: Center(
                                              child: Text('VIP',
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
                    ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 12),
              //   child: Card(
              //     elevation: elevation,
              //     shadowColor: elecolor,
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12)),
              //     child: Container(
              //       padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
              //       width: MediaQuery.of(context).size.width,
              //       // height: 120,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.symmetric(
              //           horizontal: 5,
              //         ),
              //         child: Column(
              //           children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //               children: [
              //                 Icon(
              //                   Icons.monetization_on,
              //                   color: Colors.lightGreen,
              //                   size: 35,
              //                 ),
              //                 Text('Try Your Luck Spin       ',
              //                     style: TextStyle(
              //                         fontSize: 14,
              //                         fontWeight: FontWeight.w500)),
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 GestureDetector(
              //                   onTap: () async {
              //                     bool result =
              //                         await InternetConnectionChecker()
              //                             .hasConnection;
              //                     if (result == true) {
              //                       Navigator.push(
              //                           context,
              //                           MaterialPageRoute(
              //                               builder: ((context) =>
              //                                   luckySpinWheel())));
              //                     } else {
              //                       Fluttertoast.showToast(
              //                           msg: "No Iternet Connection",
              //                           toastLength: Toast.LENGTH_SHORT,
              //                           backgroundColor: c1,
              //                           textColor: c6,
              //                           fontSize: 16.0);
              //                     }
              //                   },
              //                   child: Container(
              //                       width:
              //                           MediaQuery.of(context).size.width / 4.5,
              //                       height: 35,
              //                       decoration: BoxDecoration(
              //                           color: c1,
              //                           borderRadius:
              //                               BorderRadius.circular(30)),
              //                       child: Center(
              //                           child: Text('Try',
              //                               style: TextStyle(
              //                                   fontSize: 15,
              //                                   fontWeight: FontWeight.w400,
              //                                   color: Colors.white)))),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(children: [
                    Row(
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
                                height: 250,
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
                                    Text('Super Spin',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500)),
                                    Container(
                                        width: 130,
                                        height: 130,
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
                            if (upgraded == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => luckySpinWheel()));
                            } else {
                              loadunityad();
                              if (ads?.get('loaded') == true) {
                                showunityad();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          luckySpinWheel())));
                            }
                          },
                          child: Card(
                            elevation: elevation,
                            shadowColor: elecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 250,
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
                                  Text('LuckySpin',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  // SizedBox(
                                  //   height: 17,
                                  // ),
                                  Container(
                                      width: 140,
                                      height: 140,
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
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 250,
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
                                      width: 140,
                                      height: 140,
                                      child: Image(
                                          image: AssetImage('images/spw.png'))),
                                  Text('Earn Upto ₹6000',
                                      style: TextStyle(
                                          color: c1,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (upgraded == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => scratch()));
                            } else {
                              loadunityad();
                              if (ads?.get('loaded') == true) {
                                showunityad();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => scratch()));
                            }
                          },
                          child: Card(
                            elevation: elevation,
                            shadowColor: elecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 250,
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
                                  Text('Sacratch',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  // SizedBox(height: 20),
                                  Container(
                                      width: 130,
                                      height: 130,
                                      child: Image(
                                          image:
                                              AssetImage('images/reward.png'))),
                                  Text('Earn Upto ₹5000',
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
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (upgraded == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizScreen()));
                            } else {
                              loadunityad();
                              if (ads?.get('loaded') == true) {
                                showunityad();
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuizScreen()));
                            }
                          },
                          child: Card(
                            elevation: elevation,
                            shadowColor: elecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 250,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Text('PlayQuiz',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  // SizedBox(
                                  //   height: 17,
                                  // ),
                                  Container(
                                      width: 90,
                                      height: 90,
                                      child: Image(
                                          image:
                                              AssetImage('images/quiz.png'))),
                                  // SizedBox(height: 40),
                                  Text('Earn Upto ₹3000',
                                      style: TextStyle(
                                          color: c1,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (vip == "false") {
                              Fluttertoast.showToast(
                                  msg: "Only For VIP Members",
                                  toastLength: Toast.LENGTH_SHORT,
                                  backgroundColor: Colors.white,
                                  textColor: Colors.black,
                                  fontSize: 16.0);
                            } else {
                              loadunityad();
                              if (ads?.get('loaded') == true) {
                                showunityad();
                              }
                            }

                            if (upgraded == true) {
                            } else {
                              loadunityad();
                              if (ads?.get('loaded') == true) {
                                showunityad();
                              }
                            }
                          },
                          child: Card(
                            elevation: elevation,
                            shadowColor: elecolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.2,
                              height: 250,
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
                                  Text('Watch Videos',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500)),
                                  // SizedBox(height: 20),
                                  Container(
                                      width: 130,
                                      height: 100,
                                      child: Image(
                                          image: AssetImage(
                                              'images/watchvideo.png'))),
                                  Text('Earn Upto ₹5000',
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
            ],
          ),
        ),
      ),
    );
  }
}
