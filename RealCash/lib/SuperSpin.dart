import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';

import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quantupi/quantupi.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:test1/HomePage.dart';

import 'Colors.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';

import 'Widget.dart';
import 'edit_profile.dart';
import 'notification.dart';

Box? superspin = Hive.box('superspin');

class SuperSpin extends StatefulWidget {
  SuperSpin({Key? key}) : super(key: key);

  @override
  State<SuperSpin> createState() => _SuperSpinState();
}

Box? wallet = Hive.box('wallet');

class _SuperSpinState extends State<SuperSpin> {
  var blue = Colors.blue;
  final selected = BehaviorSubject<int>();
  int rewards = 0;
  final player = AudioCache();
  List items = [300, 400, 250, 500, 100, 600, 700, 230];
  var allcoin = account!.get(0)['Ballance'];

  @override
  void initState() {
    super.initState();
    if (superlocked == false) {
      showNotification('✅ Unlock Super Spin Earn Daily ₹500',
          'Unlock Kro super spin Ko Daily ₹500 Instant withdraw kro');
    }
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  Box? adsbox = Hive.box('adsbox');
  bool upgraded = limits?.get('pro');

  ///clicks cheack
  clickcheackspin() {
    dynamic lastclick = adsbox!.get(10)['lastclick'];
    DateTime presenttime = DateTime.now();
    Duration difference = presenttime.difference(lastclick);
    int clicks = adsbox!.get(9)['clicks'];
    if (clicks == 3) {
      if (difference.inHours > 10) {
        player.play('win.mp3');
        setState(() {
          selected.add(Fortune.randomInt(0, items.length));
        });
        adsbox!.put(9, {'clicks': 0});
        adsbox!.put(10, {'lastclick': DateTime.now()});
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
      player.play('win.mp3');
      setState(() {
        selected.add(Fortune.randomInt(0, items.length));
      });
      adsbox!.put(9, {'clicks': clicks + 1});
      adsbox!.put(10, {'lastclick': DateTime.now()});
    }
  }

  bool superlocked = superspin?.get('superunlocked');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: BackButton(color: Colors.black),
        backgroundColor: white,
        elevation: 0,
      ),
      backgroundColor: c6,
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
                                borderColor: Color.fromRGBO(255, 255, 255, 1),
                                color: blue,
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
                                    // SizedBox(width:15),
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
                                    // SizedBox(width:15),
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
                                color: blue,
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
                                    // SizedBox(width:15),
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
                                    // SizedBox(width:15),
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
                                color: blue,
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
                                    // SizedBox(width:15),
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
                                    // SizedBox(width:15),
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
                                color: blue,
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
                                    // SizedBox(width:15),
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
                                    // SizedBox(width:15),
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
                                                                selected.value]
                                                            .toString(),
                                                      });
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
                                                      fontSize: 18,
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
              superlocked
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                      
                          bool result =
                              await InternetConnectionChecker().hasConnection;
                          if (result == true) {
                            clickcheackspin();
                          } else {
                            Fluttertoast.showToast(
                                msg: "No Iternet Connection",
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                fontSize: 16.0);
                          }
                        },
                        color: c1,
                        child: Text('Spin',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                        elevation: 10,
                        height: 50,
                        minWidth: 170,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: MaterialButton(
                        onPressed: () async {
                          AwesomeDialog(
                            context: context,
                            keyboardAware: true,
                            dismissOnBackKeyPress: false,
                            dialogType: DialogType.success,
                            animType: AnimType.bottomSlide,
                            btnCancelText: "Cancel",
                            btnOkText: "Unlock",
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
                              paymentkro();
                            },
                          ).show();
                        },
                        color: c1,
                        child: Icon(Icons.lock, color: Colors.white),
                        elevation: 10,
                        height: 50,
                        minWidth: 170,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }

  paymentkro() async {
    Quantupi zupi = Quantupi(
      receiverUpiId: 'nextonebox.51084093@sbi',
      receiverName: 'NextOneBox CEO',
      transactionRefId: '',
      transactionNote: '${account!.get(0)['name']}',
      amount: 79,
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
            superspin?.put('superunlocked', true);

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

          http.Response response = await http.put(
              Uri.parse('https://realcash.nextonebox.com/superSpin'),
              body: {
                'email': account!.get(0)['email'].toString(),
                'SuperSpin': 'true',
              });

          await http.post(Uri.parse('https://fogcash.nextonebox.com/ContactUs'),
              body: {
                'message': "${account!.get(0)['email']}",
              });
        }
        break;
      }
    }
  }
}
