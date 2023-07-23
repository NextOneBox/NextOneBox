import 'dart:async';
import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter/material.dart';

class LuckeySpin extends StatefulWidget {
  const LuckeySpin({Key? key}) : super(key: key);

  @override
  State<LuckeySpin> createState() => _LuckeySpinState();
}

class _LuckeySpinState extends State<LuckeySpin> {
  Ceckinternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showMessage(context, 'Please check your internet connection');
    }
  }

  void luckey(BuildContext context, String MYmessage) {
    QuickAlert.show(
      context: context,
      title: '✅ Get now 10 Luckey Spin',
      type: QuickAlertType.confirm,
      text:
          '\n\nAdd Ballance to spin ₹10 rupees = 1 spin. Minimium You can add ₹100 ',
      confirmBtnText: 'Add',
      onConfirmBtnTap: () {
        Navigator.of(
          context,
        ).pop('dialog');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Pay(
                    link: 'https://cosmofeed.com/vp/64a954d26a2973002b11b180',
                    price: 99.0,
                  )),
        );
      },
      cancelBtnText: 'Cancel',
      onCancelBtnTap: () {
        Navigator.of(
          context,
        ).pop('dialog');

        showMessage(context, '😔You are missing big earning opportunity');
      },
      confirmBtnColor: Colors.green,
    );
  }

  @override
  void initState() {
    super.initState();

    UnityAds.init(
      gameId: '5278155',
    );
    Ceckinternet();
  }

  bool isLoaded = false;

  final int _numRewardedLoadAttempts = 0;

  unityloadad(int getammount) async {
    setState(() {});
   

    UnityAds.load(
      placementId: 'Rewarded_Android',
    );

    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) async {
        http.Response response = await http
        .put(Uri.parse('https://fogcash.nextonebox.com/UpdateLuckeySpin'), body: {
      'Email': email.toString(),
      'LuckeySpin': 1.toString(),
      'Ballance': getammount.toString(),
    });
    if (response.reasonPhrase == 'OK') {
      SendAllData();
      Timer(const Duration(seconds: 3), () {
        setState(() {});
      });
    }

        localballance!.put(0, localballance!.get(0) + getammount);

        setState(() {
          showWining(context, '');
        });
      },
    );
  }

  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List items = [1000, 200, 800, 500, 0, 100];
  // dynamic spincoin;
  var allcoin = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  final _player = AudioPlayer();
  playSound(soundname) {
    _player.play(AssetSource('Sounds/win.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: SecondaryColor,
          elevation: 0,
          title: const Text(
            'Luckey Spin JackPot',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              AbsorbPointer(
                absorbing: true,
                child: SizedBox(
                  height: 430,
                  child: FortuneWheel(
                    selected: selected.stream,
                    animateFirst: false,
                    items: [
                      FortuneItem(
                        style: const FortuneItemStyle(
                            color: Color.fromARGB(255, 128, 233, 132),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              items[0].toString(),
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Image.asset(
                              'assets/coin.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      FortuneItem(
                        style: const FortuneItemStyle(
                            color: Colors.black, borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              items[1].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Image.asset(
                              'assets/coin.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      FortuneItem(
                        style: const FortuneItemStyle(
                            color: Color.fromARGB(255, 22, 124, 213),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              items[2].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Image.asset(
                              'assets/coin.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      FortuneItem(
                        style: const FortuneItemStyle(
                            color: Color.fromARGB(255, 128, 233, 132),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              items[3].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Image.asset(
                              'assets/coin.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      FortuneItem(
                        style: const FortuneItemStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              items[4].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Image.asset(
                              'assets/coin.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      FortuneItem(
                        style: const FortuneItemStyle(
                            color: Color.fromARGB(255, 22, 124, 213),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              items[5].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Image.asset(
                              'assets/coin.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                    onAnimationEnd: () {
                      setState(() {
                        rewards = items[selected.value];
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Container(
                                child: AlertDialog(
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
                                      child: Image(
                                          image: AssetImage('assets/gi.png')),
                                    )),
                                    Center(
                                      child: Text('You Win : $rewards Coin',
                                          style: texSty),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                              unityloadad(
                                                  items[selected.value]);
                                            },
                                            height: 50,
                                            minWidth: 120,
                                            color: MainColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Text(
                                                'Watch Ad to CLAIM',
                                                style: TextStyle(
                                                    color: Colors.white)))),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              );
                            });
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                // padding: EdgeInsets.only(top: 3, left: 3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.yellow),
                      top: BorderSide(color: Colors.yellow),
                      left: BorderSide(color: Colors.yellow),
                      right: BorderSide(color: Colors.yellow),
                    )),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {});
                    UnityAds.load(
                      placementId: 'Rewarded_Android',
                    );

                    if (user.get(0)['LuckeySpin'] > 0) {
                      playSound('win');
                      setState(() {
                        selected.add(Fortune.randomInt(0, items.length));
                      });
                    } else {
                      setState(() {});
                      luckey(context, '');
                    }
                  },
                  color: MainColor,
                  elevation: 10,
                  height: 50,
                  minWidth: 120,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: const Text('Spin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      )),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
