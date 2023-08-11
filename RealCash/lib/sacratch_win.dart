import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:test1/HomePage.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:http/http.dart' as http;
import 'Colors.dart';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:scratcher/widgets.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'SuperSpin.dart';
import 'Widget.dart';

Box? wallet = Hive.box('wallet');
Box? email = Hive.box('email');
var appbarcolor = c1;

class AdManager {
  static String get bannerAdPlacementId {
    return 'your_banner_ad_placement_id';
  }

  static String get interstitialVideoAdPlacementId {
    return 'intrestial_ad_';
  }
}

class scratch extends StatefulWidget {
  @override
  _scratchState createState() => _scratchState();
}

class _scratchState extends State<scratch> {
  // bool boool = boo?.get('bool');
  var allcoin = account!.get(0)['Ballance'];
  late ConfettiController _controller;
  var RandomNumber;
  var ra;
  final scratchkey = GlobalKey<ScratcherState>();

  @override
  void initState() {
    UnityAds.init(
      gameId: '5314179',
    );
    super.initState();
    UnityAds.load(
      placementId: 'scratch_rewarded_ad',
    );
    _controller = new ConfettiController(
      duration: new Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _bannerAd?.dispose();
  }

  uadload() {
    UnityAds.load(
      placementId: 'scratch_rewarded_ad',
    );
  }

  //show unity ad
  unityadshow() {
    UnityAds.showVideoAd(
      placementId: 'scratch_rewarded_ad',
      onSkipped: (placementId) => {},
    );
  }

  bool _upgraded = limits?.get('pro');

  ///clicks cheack
  clickscheack() {
    dynamic lastclick = adsbox!.get(3)['lastclick'];
    DateTime presenttime = DateTime.now();
    Duration difference = presenttime.difference(lastclick);
    int clicks = adsbox!.get(4)['clicks'];
    if (clicks == limits?.get('sac')) {
      Future.delayed(Duration(seconds: 3), () {
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
      });
      if (difference.inHours > 10) {
        uadload();
        _controller.play();
        setState(() {
          _enabled = true;
          showDialog(
              context: context,
              builder: (context) {
                return Container(
                  child: AlertDialog(
                    insetPadding: EdgeInsets.symmetric(
                      horizontal: 80,
                    ),
                    actions: [
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: Image(image: AssetImage('images/winner.png')),
                        ),
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('You Win',
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
                              child: Image.asset('images/coin.png'),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text('$RandomNumber',
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
                                bool result = await InternetConnectionChecker()
                                    .hasConnection;
                                if (result == true) {
                                  Navigator.pop(context);
                                  unityadshow();
                                  http.Response response = await http.post(
                                      Uri.parse(
                                          'https://realcash.nextonebox.com/UpdateBallance'),
                                      body: {
                                        'email':
                                            account!.get(0)['email'].toString(),
                                        'amount': RandomNumber.toString(),
                                      });
                                  scratchkey.currentState?.reset(
                                      duration: Duration(microseconds: 200));
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "No Iternet Connection",
                                      toastLength: Toast.LENGTH_SHORT,
                                      backgroundColor: c6,
                                      textColor: c3,
                                      fontSize: 16.0);
                                }
                              },
                              height: 45,
                              minWidth: 120,
                              color: c1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text('Get Coin',
                                  style: TextStyle(color: Colors.white)))),
                    ],
                  ),
                );
              });
        });
        adsbox!.put(4, {'clicks': 0});
        adsbox!.put(3, {'lastclick': DateTime.now()});
      } else {
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: c6,
              content: Text(
                'You have exceed your Scratch limits. Please try after :${10 - difference.inHours} Hours : ${60 - difference.inMinutes} Minutes.',
                style: textstyle,
              )));
        }
      }
    } else {
      uadload();
      _controller.play();
      setState(() {
        _enabled = true;
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                child: AlertDialog(
                  insetPadding: EdgeInsets.symmetric(
                    horizontal: 80,
                  ),
                  actions: [
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        child: Image(image: AssetImage('images/winner.png')),
                      ),
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('You Win',
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
                            child: Image.asset('images/coin.png'),
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text('$RandomNumber',
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
                              bool result = await InternetConnectionChecker()
                                  .hasConnection;
                              if (result == true) {
                                Navigator.pop(context);
                                unityadshow();
                                http.Response response = await http.post(
                                    Uri.parse(
                                        'https://realcash.nextonebox.com/UpdateBallance'),
                                    body: {
                                      'email':
                                          account!.get(0)['email'].toString(),
                                      'amount': RandomNumber.toString(),
                                    });
                                scratchkey.currentState?.reset(
                                    duration: Duration(microseconds: 200));
                              } else {
                                Fluttertoast.showToast(
                                    msg: "No Iternet Connection",
                                    toastLength: Toast.LENGTH_SHORT,
                                    backgroundColor: c6,
                                    textColor: c3,
                                    fontSize: 16.0);
                              }
                            },
                            height: 45,
                            minWidth: 120,
                            color: c1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text('Get Coin',
                                style: TextStyle(color: Colors.white)))),
                  ],
                ),
              );
            });
      });
      adsbox!.put(4, {'clicks': clicks + 1});
      adsbox!.put(3, {'lastclick': DateTime.now()});
    }
  }

  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    if (wallet?.get(0) == null) {
      allcoin = 0;
    } else {
      allcoin = account!.get(0)['Ballance'];
    }

    RandomNumber = (Random().nextInt(5) + 1);

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
              Center(
                child: Scratcher(
                  key: scratchkey,
                  enabled: _enabled,
                  brushSize: 40,
                  threshold: 80,
                  color: Colors.yellow,
                  image: Image.asset(
                    "images/reward.png",
                    fit: BoxFit.fill,
                  ),
                  onThreshold: () {
                    if (_upgraded == true) {
                      _controller.play();
                      setState(() {
                        _enabled = true;
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Container(
                                child: AlertDialog(
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
                                          Text('You Win',
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
                                            child:
                                                Image.asset('images/coin.png'),
                                          ),
                                          SizedBox(
                                            width: 7,
                                          ),
                                          Text('$RandomNumber',
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
                                                  scratchkey.currentState
                                                      ?.reset(
                                                          duration: Duration(
                                                              microseconds: 5));
                                                  Navigator.pop(context);

                                                  http.Response response =
                                                      await http.post(
                                                          Uri.parse(
                                                              'https://realcash.nextonebox.com/UpdateBallance'),
                                                          body: {
                                                        'email': account!
                                                            .get(0)['email']
                                                            .toString(),
                                                        'amount': RandomNumber
                                                            .toString(),
                                                      });
                                                } else {
                                                  Navigator.pop(context);
                                                  unityadshow();
                                                  http.Response response =
                                                      await http.post(
                                                          Uri.parse(
                                                              'https://realcash.nextonebox.com/UpdateBallance'),
                                                          body: {
                                                        'email': account!
                                                            .get(0)['email']
                                                            .toString(),
                                                        'amount': RandomNumber
                                                            .toString(),
                                                      });
                                                  scratchkey.currentState
                                                      ?.reset(
                                                          duration: Duration(
                                                              microseconds:
                                                                  200));
                                                }
                                              } else {
                                                Fluttertoast.showToast(
                                                    msg:
                                                        "No Iternet Connection",
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    backgroundColor: c6,
                                                    textColor: c3,
                                                    fontSize: 16.0);
                                              }
                                            },
                                            height: 45,
                                            minWidth: 120,
                                            color: c1,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Text('Get Coin',
                                                style: TextStyle(
                                                    color: Colors.white)))),
                                  ],
                                ),
                              );
                            });
                      });
                    } else {
                      clickscheack();
                    }
                  },
                  child: Container(
                    height: 300,
                    width: 300,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/winner.png",
                          fit: BoxFit.contain,
                          width: 150,
                          height: 150,
                        ),
                        Column(
                          children: [
                            ConfettiWidget(
                              blastDirectionality:
                                  BlastDirectionality.explosive,
                              confettiController: _controller,
                              particleDrag: 0.05,
                              emissionFrequency: 0.05,
                              numberOfParticles: 100,
                              gravity: 0.05,
                              shouldLoop: false,
                              colors: [
                                Colors.green,
                                Colors.red,
                                Colors.yellow,
                                Colors.blue,
                              ],
                            ),
                            Text(
                              "You won",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 25,
                                color: Colors.black,
                              ),
                            ),
                            //SizedBox(width: 7,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 30,
                                  height: 30,
                                  child: Image.asset('images/coin.png'),
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  "$RandomNumber",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
  
        ],
      ),
    );
  }
}
