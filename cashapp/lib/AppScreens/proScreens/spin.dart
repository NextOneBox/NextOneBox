import 'package:audioplayers/audioplayers.dart';
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class SpinWheel extends StatefulWidget {
  const SpinWheel({Key? key}) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  Ceckinternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showMessage(context, 'Please check your internet connection');
    }
  }

  final _player = AudioPlayer();
  playSound(soundname) {
    _player.play(AssetSource('Sounds/win.mp3'));
  }

  @override
  void initState() {
    super.initState();

    UnityAds.init(
      gameId: '5278155',
    );
    UnityAds.load(
      placementId: 'Rewarded_Android',
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
        http.Response resp = await http.put(
            Uri.parse('https://fogcash.nextonebox.com/UpdateBallance'),
            body: {
              'Email': email.toString(),
              'Ballance': getammount.toString(),
            });
        print(resp.body);
        localballance!.put(0, localballance!.get(0) + getammount);
        adsbox!.put(13, {'SpinCount': -1});
        adsbox!.put(14, {'SpinLastClickOn': DateTime.now()});

        setState(() {
          showWining(context, '');
        });
      },
    );
  }

  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List items = [4, 7, 9, 6, 5, 8];
  // dynamic spincoin;
  var allcoin = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
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
            'Spin & Win',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: const Border(
                      bottom: BorderSide(color: MainColor),
                      top: BorderSide(color: MainColor),
                      left: BorderSide(color: MainColor),
                      right: BorderSide(color: MainColor),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Text('${localballance!.get(0)} 🪙',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      )),
                ),
              ),
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
                            color: Color.fromARGB(255, 51, 14, 217),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "🪙${items[0].toString()}",
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
                            color: Color.fromARGB(255, 143, 10, 180),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "🪙${items[1].toString()}",
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
                            color: Color.fromARGB(255, 101, 141, 175),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "🪙${items[2].toString()}",
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
                            color: Color.fromARGB(255, 73, 212, 8),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '🪙${items[3].toString()}',
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
                            color: Color.fromARGB(255, 243, 43, 8),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '🪙${items[4].toString()}',
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
                            color: Color.fromARGB(255, 179, 148, 10),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '🪙${items[5].toString()}',
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
                            color: Color.fromARGB(255, 39, 39, 39),
                            borderWidth: 1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '🪙${items[5].toString()}',
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
                                      child: Image(
                                          image: AssetImage('assets/gi.png')),
                                    )),
                                    Center(
                                      child: Text('You Win : $rewards 🪙',
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
                height: 70,
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

                    if (user.get(0)['Pro'] == 'true') {
                         playSound('win');
                      setState(() {
                        selected.add(Fortune.randomInt(0, items.length));
                      });
                    } else {
                      int clicks = adsbox!.get(13)['SpinCount'];
                      dynamic lastclick = adsbox!.get(14)['SpinLastClickOn'];
                      DateTime presenttime = DateTime.now();
                      Duration difference = presenttime.difference(lastclick);

                      if (clicks <= 0) {
                        if (difference.inHours > 24) {
                          playSound('win');
                          setState(() {
                            selected.add(Fortune.randomInt(0, items.length));
                          });
                          adsbox!.put(13, {'SpinCount': 8});
                          adsbox!.put(14, {'SpinLastClickOn': DateTime.now()});
                        } else {
                          buyMessage(context, '');
                        }
                      } else {
                        playSound('win');
                        setState(() {
                          selected.add(Fortune.randomInt(0, items.length));
                        });
                      }
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
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
