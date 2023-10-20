import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:youget/main.dart';
import 'package:youget/utils.dart';
import 'package:youget/withdrawalhistory.dart';
import 'package:quantupi/quantupi.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youget/HomePage.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:url_launcher/url_launcher.dart';


import 'package:http/http.dart' as http;

import 'SuperSpin.dart';

import 'notification.dart';

Box? boo = Hive.box('boo');

class luckySpinWheel extends StatefulWidget {
  luckySpinWheel({Key? key}) : super(key: key);

  @override
  State<luckySpinWheel> createState() => _luckySpinWheelState();
}

Box? wallet = Hive.box('wallet');

class _luckySpinWheelState extends State<luckySpinWheel> {
  bool _upgraded = limits?.get('pro');
  @override
  initState() {
    if (superspin?.get('luckspinbalance') == 0) {
      showNotification('✅ Unlock Maga Spin Earn Daily ₹500',
          'Unlock Kro Maga Spin Ko Daily ₹500 Instant withdraw kro');
    }
    super.initState();
  }

  final selected = BehaviorSubject<int>();
  var appbarcolor = Color(0xFF7b2fa8);

  int rewards = 0;
  final player = AudioCache();
  List items = [100, 10, 50, 20, 60, 30, 90, 40];
  var allcoin = account!.get(0)['Ballance'];

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  Box? adsbox = Hive.box('adsbox');

  bool boool = boo?.get('bool');

  clickcheackspin() {
    int clicks = adsbox!.get(40)['clicks'];

    if (clicks == 1) {
      setState(() {
        superspin?.put('click', 1);
      });
    } else if (clicks == 2) {
      setState(() {
        superspin?.put('click', 3);
      });
    } else if (clicks == 3) {
      setState(() {
        superspin?.put('click', 5);
      });
    } else if (clicks == 4) {
      setState(() {
        superspin?.put('click', 4);
      });
    }
  }

  paymentkro() async {
    try {
      Quantupi zupi = Quantupi(
        receiverUpiId: 'nextonebox@sbi',
        receiverName: 'NextOneBox CEO',
        transactionRefId: '',
        transactionNote: 'OP',
        amount: 99,
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
            facebookAppEvents.logPurchase(amount: 11, currency: "INR");
            setState(() {
              superspin?.put('luckspinbalance', 100);
              adsbox?.put(40, {'clicks': 0});
              superspin?.put('click', 0);
              AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                headerAnimationLoop: false,
                dialogType: DialogType.success,
                showCloseIcon: true,
                title: 'Succes',
                desc: 'Congratulation you have sucessfully added ballance',
                btnOkOnPress: () {
                  debugPrint('OnClcik');
                },
                btnOkIcon: Icons.check_circle,
                onDismissCallback: (type) {},
              ).show();
            });
            http.Response response = await http.put(
                Uri.parse('https://realcash.nextonebox.com/luckySpin'),
                body: {
                  'email': account!.get(0)['email'].toString(),
                  'LuckySpin': 100.toString(),
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

  @override
  Widget build(BuildContext context) {
    var s2color = Color.fromARGB(255, 17, 150, 48);
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
              Text(
                '₹${superspin?.get('luckspinbalance')}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
                                color: s2color,
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "₹${items[0].toString()}",
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
                                color: Color.fromARGB(255, 60, 89, 217),
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "  ₹${items[1].toString()}",
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
                                color: s2color,
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "  ₹${items[2].toString()}",
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
                                color: Color.fromARGB(255, 60, 89, 217),
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "  ₹${items[3].toString()}",
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
                                color: s2color,
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "  ₹${items[4].toString()}",
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
                                color: Color.fromARGB(255, 60, 89, 217),
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "  ₹${items[5].toString()}",
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
                                color: s2color,
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "  ₹${items[6].toString()}",
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
                                color: Color.fromARGB(255, 60, 89, 217),
                                borderWidth: 2),
                            child: Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Row(
                                  children: [
                                    // Container(
                                    //   width: 30,
                                    //   height: 30,
                                    //   child: Image.asset('images/coin.png'),
                                    // ),
                                    SizedBox(width: 15),
                                    Text(
                                      "  ₹${items[7].toString()}",
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
                                                  var totalspin = superspin
                                                      ?.get('luckspinbalance');
                                                  setState(() {
                                                    int clicks = adsbox!
                                                        .get(40)['clicks'];
                                                    adsbox!.put(40,
                                                        {'clicks': clicks + 1});

                                                    superspin?.put(
                                                        'luckspinbalance',
                                                        totalspin - 10);
                                                  });
                                                  var me = totalspin - 10;

                                                  await http.put(
                                                      Uri.parse(
                                                          'https://realcash.nextonebox.com/luckySpin'),
                                                      body: {
                                                        'email': account!
                                                            .get(0)['email']
                                                            .toString(),
                                                        'LuckySpin':
                                                            me.toString(),
                                                      });

                                                  clickcheackspin();
                                                  Navigator.pop(context);

                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '100') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              1000.toString(),
                                                        });

                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            100);
                                                    setState(() {});
                                                  }

                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '10') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              100.toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            100);
                                                    setState(() {});
                                                  }

                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '0') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              1.toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            1);
                                                    setState(() {});
                                                  }
                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '20') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              100.toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            100);
                                                    setState(() {});
                                                  }
                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '60') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              600.toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            600);
                                                    setState(() {});
                                                  }
                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '30') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              300.toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            300);
                                                    setState(() {});
                                                  }
                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '90') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              900.toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            900);
                                                    setState(() {});
                                                  }
                                                  if (items[selected.value]
                                                          .toString() ==
                                                      '100') {
                                                    http.Response response =
                                                        await http.post(
                                                            Uri.parse(
                                                                'https://realcash.nextonebox.com/UpdateBallance'),
                                                            body: {
                                                          'email': account!
                                                              .get(0)['email']
                                                              .toString(),
                                                          'amount':
                                                              1000.toString(),
                                                        });
                                                    localballance!.put(
                                                        0,
                                                        localballance!.get(0) +
                                                            1000);
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
                      if (superspin?.get('luckspinbalance') > 9) {
                        player.play('win.mp3');
                        setState(() {
                          selected.add(Fortune.randomInt(
                              superspin?.get('click'),
                              superspin?.get('click')));
                        });
                      } else {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.leftSlide,
                          headerAnimationLoop: false,
                          transitionAnimationDuration: Duration(seconds: 0),
                          dialogType: DialogType.success,
                          showCloseIcon: true,
                          title: 'Get now 10 Maga Spin',
                          btnOkText: 'Add Now',
                          btnOkColor: c1,
                          desc:
                              'Add Ballance to spin ₹10 rupees = 1spin. Minimium You can add ₹99',
                          btnOkOnPress: () {
                            paymentkro();
                            facebookAppEvents.logAddToCart(
                              id: '$email',
                              type: 'Luc',
                              price: 11.0,
                              currency: 'INR',
                            );
                          },
                          btnOkIcon: Icons.check_circle,
                          onDismissCallback: (type) {},
                        ).show();
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
        ],
      ),
    );
  }
}
