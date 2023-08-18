import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:cash/welcome.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Colors.dart';

import 'TaskDetails.dart';
import 'Widget.dart';

class Taskoffers extends StatefulWidget {
  const Taskoffers({Key? key}) : super(key: key);

  @override
  State<Taskoffers> createState() => _TaskoffersState();
}

class _TaskoffersState extends State<Taskoffers> {
  unityloadad() async {
    UnityAds.load(
      placementId: 'intrestial_ad_',
    );

    UnityAds.showVideoAd(
      placementId: 'intrestial_ad_',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) async {},
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }

  Box? account = Hive.box('account');

  Box? socialmedia = Hive.box('socialmedia');
  bool isLoading = false;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;
  var tasksshow = tasks?.values.toList();

  @override
  initState() {
    getConnectivity();
    super.initState();
    UnityAds.init(
      gameId: '5366239',
    );
    UnityAds.load(
      placementId: 'intrestial_ad_',
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
          btnOkText: " Join now",
          //  title:               '✅ Make Daily ₹500 use lucky spin. Many users are daily Earning ₹500 using lucky spin , Do not miss the big earning opportunity',
          title: 'Join Telegram',
          desc:
              'Get Daily Update In our Telegram channel join our Telegram family',
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

            String youtube = 'https://t.me/realcashappch';
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
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
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
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  DateTime pre_backpress = DateTime.now();

  gettasks() async {
    http.Response taskget =
        await http.get(Uri.parse('https://realcash.nextonebox.com/ShowTasks'));
    if (taskget.reasonPhrase == 'OK') {
      await tasks!.clear();
      var da = jsonDecode(taskget.body);

      for (var a in da) {
        await tasks!.add(a);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    gettasks();
    return WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          Fluttertoast.showToast(
              msg: "Press Back button again to Exit",
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.purple,
              textColor: Colors.white,
              fontSize: 16.0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'Tasks',
            style: TextStyle(fontSize: 25, color: c6),
          )),
          backgroundColor: c1,
          elevation: 0,
        ),
        body: ListView.builder(
          itemCount: tasksshow!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                unityloadad();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            Car1(tasksshow: tasksshow![index])));
              },
              child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                      elevation: elevation,
                      shadowColor: elecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 15.0),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Card(
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          width: 60,
                                          height: 60,
                                          child: Image.network(
                                              tasksshow![index]['image'])),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          tasksshow![index]['name'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(tasksshow![index]['work'],
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.red[300])),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Column(
                                        children: <Widget>[
                                          Text('Earn upto',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                              width: 80,
                                              height: 25,
                                              decoration: BoxDecoration(
                                                  color: c1,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40)),
                                              child: Center(
                                                  child: Text(
                                                      "₹${tasksshow![index]['price']}",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w500)))),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(tasksshow![index]['description'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 300,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: c1,
                                      borderRadius: BorderRadius.circular(40)),
                                  child: Center(
                                      child: Text('Claim Now',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500)))),
                            ],
                          )))),
            );
          },
        ),
      ),
    );
  }
}
