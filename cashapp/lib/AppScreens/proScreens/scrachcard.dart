import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:scratcher/widgets.dart';

import '../../ComonScreens/widgets.dart';

class ScrachCard extends StatefulWidget {
  @override
  _ScrachCardState createState() => _ScrachCardState();
}

class _ScrachCardState extends State<ScrachCard> {
  unityloadad(int getammount) async {
    UnityAds.load(
      placementId: 'Rewarded_Android',
    );

    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) async {
        http.Response resp = await http.post(
            Uri.parse(
                'https://fogcash.nextonebox.com/UpdateBallance'),
            body: {
              'Email': email.toString(),
              'Ballance': getammount.toString(),
            });
        localballance!.put(0, localballance!.get(0) + getammount);
        adsbox!.put(15, {'ScrachCount': -1});
        adsbox!.put(16, {'ScrachLastClickOn': DateTime.now()});

        setState(() {
          showWining(context, '');
        });
      },
    );
  }

  late ConfettiController _controller;

  @override
  void initState() {
    super.initState();
    UnityAds.init(
      gameId: '5278155',
    );
    UnityAds.load(
      placementId: 'Rewarded_Android',
    );

    _controller = new ConfettiController(
      duration: new Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    var RandomNumber = (Random().nextInt(5) + 1);
    return Scaffold(
      body: Center(
        child: Scratcher(
          brushSize: 50,
          threshold: 75,
          color: Colors.red,
          image: Image.asset(
            "assets/images/outerimage.png",
            fit: BoxFit.fill,
          ),
          onChange: (value) => print("Scratch progress: $value%"),
          onThreshold: () {
            UnityAds.load(
              placementId: 'Rewarded_Android',
            );
            _controller.play();
            Timer(const Duration(seconds: 3), () {
              showDialog(
                  barrierColor: Colors.white,
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.white,
                      child: AlertDialog(
                        backgroundColor: Colors.white,
                        actions: [
                          const SizedBox(height: 10),
                          const Center(
                              child: Text('Congratulation..!',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w300,
                                      color: MainColor))),
                          const Center(
                              child: SizedBox(
                            width: 150,
                            height: 150,
                            child: Image(image: AssetImage('assets/gi.png')),
                          )),
                          Center(
                            child: Text('You Win : $RandomNumber 🪙',
                                style: texSty),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                              child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      
                                    });
                                    Navigator.pop(context, true);

                                    if (user.get(0)['Pro'] == 'true') {
                                      unityloadad(RandomNumber);
                                    } else {
                                      int clicks =
                                          adsbox!.get(15)['ScrachCount'];
                                      dynamic lastclick =
                                          adsbox!.get(16)['ScrachLastClickOn'];
                                      DateTime presenttime = DateTime.now();
                                      Duration difference =
                                          presenttime.difference(lastclick);

                                      if (clicks <= 0) {
                                        if (difference.inHours > 24) {
                                          unityloadad(RandomNumber);
                                          adsbox!.put(15, {'ScrachCount': 8});
                                          adsbox!.put(16, {
                                            'ScrachLastClickOn': DateTime.now()
                                          });
                                        } else {
                                          buyMessage(context, '');
                                        }
                                      } else {
                                        unityloadad(RandomNumber);
                                      }
                                    }
                                  },
                                  height: 50,
                                  minWidth: 120,
                                  color: MainColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text('Watch Ad to CLAIM',
                                      style: TextStyle(color: Colors.white)))),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  });
            });
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
                  "assets/images/newimage.png",
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
                Column(
                  children: [
                    ConfettiWidget(
                      blastDirectionality: BlastDirectionality.explosive,
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
                      ),
                    ),
                    Text(
                      "$RandomNumber Coins",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
