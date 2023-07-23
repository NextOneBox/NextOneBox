import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:flutter/material.dart';

class SuperSpin extends StatefulWidget {
  const SuperSpin({Key? key}) : super(key: key);

  @override
  State<SuperSpin> createState() => _SuperSpinState();
}

class _SuperSpinState extends State<SuperSpin> {
  Ceckinternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showMessage(context, 'Please check your internet connection');
    }
  }

  void buySuperSpin(BuildContext context, String MYmessage) {
    QuickAlert.show(
      context: context,
      title: 'Unlock JackPot at just ₹139',
      type: QuickAlertType.confirm,
      text:
          'Earn Daily ₹500 by unlocking JackPot spin Dont miss the big earning opportunity. many users are already earning by unlocking JackPot',
      confirmBtnText: 'Add',
      onConfirmBtnTap: () {
        Navigator.of(
          context,
        ).pop('dialog');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Pay(
                    link: 'https://cosmofeed.com/vp/64a9543f61b8cb002a744103',
                    price: 139.0,
                  )),
        );
      },
      cancelBtnText: 'cancel',
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
    UnityAds.load(
      placementId: 'Rewarded_Android',
    );

    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) async {
        dynamic a = getammount * 10;
        http.Response resp = await http.post(
            Uri.parse('https://fogcash.nextonebox.com/UpdateBallance'),
            body: {
              'Email': email.toString(),
              'Ballance': a.toString(),
            });
        http.Response response = await http.put(
            Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
            body: {
              'Email': email.toString(),
              'JackPot': 'false',
            });
        if (response.reasonPhrase == 'OK') {
          SendAllData();
          Timer(const Duration(seconds: 3), () {
            setState(() {});
          });
        }
        localballance!.put(0, localballance!.get(0) + a);

        setState(() {
          showWining(context, '');
        });
      },
    );
  }

  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List items = [1000, 400, 50, 500, 100, 200];

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
            'JackPot',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
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
                            Icon(Icons.currency_rupee),
                            Text(
                              items[0].toString(),
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                              ),
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
                            Icon(Icons.currency_rupee),
                            Text(
                              items[1].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
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
                            Icon(Icons.currency_rupee),
                            Text(
                              items[2].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
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
                            Icon(Icons.currency_rupee),
                            Text(
                              items[3].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
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
                            Icon(Icons.currency_rupee),
                            Text(
                              items[4].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
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
                            Icon(Icons.currency_rupee),
                            Text(
                              items[5].toString(),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w900,
                              ),
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
                                      child: Text('You Win : ₹$rewards ',
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

                    if (user.get(0)['JackPot'] == 'true') {
                      playSound('win');
                      setState(() {
                        selected.add(Fortune.randomInt(0, items.length));
                      });
                    } else {
                      setState(() {});
                      buySuperSpin(context, '');
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
