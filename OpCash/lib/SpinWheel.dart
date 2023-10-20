import 'dart:async';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youget/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youget/HomePage.dart';
import 'package:youget/luckyspin.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

import 'package:http/http.dart' as http;

Box? boo = Hive.box('boo');

class SpinWheel extends StatefulWidget {
  SpinWheel({Key? key}) : super(key: key);
  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

Box? wallet = Hive.box('wallet');

class _SpinWheelState extends State<SpinWheel> {
  bool _upgraded = limits?.get('pro');
  @override
  initState() {
    super.initState();
    UnityAds.init(
      gameId: '5314179',
    );
  }

  final selected = BehaviorSubject<int>();
  var appbarcolor = Color(0xFF7b2fa8);

  int rewards = 0;
  final player = AudioCache();
  List items = [25, 12, 18, 16, 20, 13, 17, 16];
  var allcoin = account!.get(0)['Ballance'];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  loadunityad() {
    UnityAds.load(
      placementId: 'spin_rewarded_ad',
    );
  }

  showunityad() {
    UnityAds.showVideoAd(
      placementId: 'spin_rewarded_ad',
      onSkipped: (placementId) => {},
    );
  }

  Box? adsbox = Hive.box('adsbox');

  ///clicks cheack
  clickcheackspin() {
    dynamic lastclick = adsbox!.get(2)['lastclick'];
    DateTime presenttime = DateTime.now();
    Duration difference = presenttime.difference(lastclick);
    int clicks = adsbox!.get(1)['clicks'];
    if (clicks == limits?.get('spin')) {
      Future.delayed(Duration(seconds: 2), () {
        AwesomeDialog(
          context: context,
          keyboardAware: true,
          dismissOnBackKeyPress: false,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          btnCancelText: "Cancel",
          btnOkText: "Use Now",
          btnOkColor: c1,
          //  title:               '✅ Make Daily ₹500 use Maga Spin. Many users are daily Earning ₹500 using Maga Spin , Do not miss the big earning opportunity',
          title: 'Earn Daily ₹500',
          desc:
              'Make Daily ₹500 use Maga Spin. Many users are daily Earning ₹500 using Maga Spin , Do not miss the big earning opportunity',

          // body: Center(
          //     child: Text(

          //   '✅ Make Daily ₹500 use Maga Spin. Many users are daily Earning ₹500 using Maga Spin , Do not miss the big earning opportunity',
          // )),
          btnCancelOnPress: () {
            Fluttertoast.showToast(
                msg: "You missed the big earning opportunity",
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.white,
                textColor: Colors.black,
                fontSize: 16.0);
          },
          btnOkOnPress: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => luckySpinWheel()));
          },
        ).show();
      }); //hghgfhh

      if (difference.inHours > 10) {
        loadunityad();
        player.play('win.mp3');
        setState(() {
          selected.add(Fortune.randomInt(0, items.length));
        });
        adsbox!.put(1, {'clicks': 0});
        adsbox!.put(2, {'lastclick': DateTime.now()});
      } else {
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: c6,
              content: Text(
                'You have exceed your Spin limits. Please try after :${10 - difference.inHours} Hours : ${60 - difference.inMinutes} Minutes',
                style: TextStyle(color: c3),
              )));
        }
      }
    } else {
      loadunityad();
      player.play('win.mp3');
      setState(() {
        selected.add(Fortune.randomInt(0, items.length));
      });
      adsbox!.put(1, {'clicks': clicks + 1});
      adsbox!.put(2, {'lastclick': DateTime.now()});
    }
  }

  bool boool = boo?.get('bool');
  @override
  Widget build(BuildContext context) {
    var s1color = Color.fromARGB(255, 56, 6, 220);
    var s2color = Colors.cyan;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(color: Colors.black),
        backgroundColor: white,
        elevation: 0,
      ),
      backgroundColor: white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  AbsorbPointer(
                    absorbing: true,
                    child: SizedBox(
                      height: 430,
                      child: FortuneWheel(
                        selected: selected.stream,
                        animateFirst: false,
                        items: [
                          FortuneItem(
                            style: FortuneItemStyle(
                                borderColor: Colors.white,
                                color: s1color,
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[0].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          FortuneItem(
                            style: FortuneItemStyle(
                                // textAlign: TextAlign.end,
                                borderColor: Colors.white,
                                color: Color.fromARGB(255, 15, 226, 205),
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[1].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          FortuneItem(
                            style: FortuneItemStyle(
                                // textAlign: TextAlign.end,
                                borderColor: Colors.white,
                                color: s1color,
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[2].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          FortuneItem(
                            style: FortuneItemStyle(
                                // textAlign: TextAlign.end,
                                borderColor: Colors.white,
                                color: Color.fromARGB(255, 15, 226, 205),
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[3].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          FortuneItem(
                            style: FortuneItemStyle(
                                // textAlign: TextAlign.end,
                                borderColor: Colors.white,
                                color: s1color,
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[4].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          FortuneItem(
                            style: FortuneItemStyle(
                                // textAlign: TextAlign.end,
                                borderColor: Colors.white,
                                color: Color.fromARGB(255, 15, 226, 205),
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[5].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          FortuneItem(
                            style: FortuneItemStyle(
                                // textAlign: TextAlign.end,
                                borderColor: Colors.white,
                                color: s1color,
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[6].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                          FortuneItem(
                            style: FortuneItemStyle(
                                // textAlign: TextAlign.end,
                                borderColor: Colors.white,
                                color: Color.fromARGB(255, 15, 226, 205),
                                borderWidth: 5),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset('images/coin.png'),
                                    ),
                                    SizedBox(width: 15),
                                    Text(
                                      "${items[7].toString()}",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.white),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                        onAnimationEnd: () {
                          setState(() {
                            rewards = items[selected.value];
                            showCupertinoDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    insetPadding: EdgeInsets.symmetric(
                                      horizontal: 80,
                                    ),
                                    actions: [
                                      Center(
                                        child: Container(
                                          width: 150,
                                          height: 150,
                                          child: Image(
                                              image: AssetImage(
                                                  'images/winner.png')),
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('You Won',
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              child: Image.asset(
                                                  'images/coin.png'),
                                            ),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(rewards.toString(),
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black)),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Center(
                                          child: MaterialButton(
                                              onPressed: () async {
                                                bool result =
                                                    await InternetConnectionChecker()
                                                        .hasConnection;
                                                if (result == true) {
                                                  if (_upgraded == true) {
                                                    Navigator.pop(context);
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount': items[
                                                                  selected
                                                                      .value]
                                                              .toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            items[selected
                                                                .value]);
                                                  } else {
                                                    showunityad();
                                                    Navigator.pop(context);
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount': items[
                                                                  selected
                                                                      .value]
                                                              .toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            items[selected
                                                                .value]);
                                                    setState(() {});
                                                  }
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "No Iternet Connection",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      backgroundColor:
                                                          Colors.white,
                                                      textColor: Colors.black,
                                                      fontSize: 16.0);
                                                }
                                              },
                                              height: 50,
                                              minWidth: 140,
                                              color: c1,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: Text('Get Coin',
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.white)))),
                                    ],
                                  );
                                });
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result == true) {
                      if (_upgraded == true) {
                        player.play('win.mp3');
                        setState(() {
                          selected.add(Fortune.randomInt(0, items.length));
                        });
                      } else {
                        clickcheackspin();
                      }
                    } else {
                      Fluttertoast.showToast(
                          msg: "No Iternet Connection",
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.purple,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  color: c1,
                  child: Text('Spin',
                      style: TextStyle(
                        color: c6,
                        fontSize: 20,
                      )),
                  elevation: 10,
                  height: 50,
                  minWidth: 170,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ],
          ),
          // boool
          //     ? Text('')
          //     : Container(
          //         width: MediaQuery.of(context).size.width,
          //         height: 60,
          //         color: Colors.grey,
          //         child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Image.network(
          //                   'https://play-lh.googleusercontent.com/i7fglhXKnqOhBsxvQRjHZfeEECXAKCP8eqMt6PMbITbjUtwUK4JpmWiIWs1R6hNf72yj=w240-h480-rw'),
          //               Text(
          //                 'Earn Daily ₹500 ',
          //                 style: TextStyle(color: Colors.white, fontSize: 20),
          //               ),
          //               GestureDetector(
          //                 onTap: () async {
          //                   setState(() {
          //                     boo?.put('bool', true);
          //                   });
          //                   String spinwinappurl =
          //                       'https://play.google.com/store/apps/details?id=com.app.earndailyspinwin';
          //                   if (await canLaunch(spinwinappurl)) {
          //                     await launch(spinwinappurl);
          //                   } else {
          //                     throw "Error occured trying to call that number.";
          //                   }
          //                 },
          //                 child: Container(
          //                     width: 100,
          //                     height: 60,
          //                     color: Color.fromARGB(255, 15, 226, 205),
          //                     child: Center(
          //                         child: Text('Install',
          //                             style: TextStyle(color: Colors.white)))),
          //               )
          //             ]))
        ],
      ),
    );
  }
}
