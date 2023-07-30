import 'dart:async';
import 'dart:ffi';

import 'package:audioplayers/audioplayers.dart';
import 'package:cashapp/ComonScreens/local_notification_service.dart';
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
      showMessage.show(context, 'Please check your internet connection');
    }
  }

  void luckey(BuildContext context, String MYmessage) {
    QuickAlert.show(
      context: context,
      title: '✅ Get now 10 lucky spin',
      type: QuickAlertType.confirm,
      text:
          'Add Ballance to spin ₹10 rupees = 1spin. Minimium You can add ₹99 ',
      confirmBtnText: 'Add Now',
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
                    type: 'Luckey Spin',
                  )),
        );
      },
      cancelBtnText: 'Cancel',
      onCancelBtnTap: () {
        Navigator.of(
          context,
        ).pop('dialog');

        showMessage.show(context, '😔You are missing big earning opportunity');
      },
      confirmBtnColor: Colors.green,
    );
  }

  @override
  void initState() {
    super.initState();
    if (user.get(0)['LuckeySpin'] >= 0) {
      AwesomeNotifications().createNotification(
          content: NotificationContent(
              id: 1,
              channelKey: 'key1',
              title: '✅ Unlock Lucky Spin Earn Daily ₹500',
              body:
                  'Unlock Kro Lucky spin Ko Daily ₹500 Instant withdraw kro'));
    }

    UnityAds.init(
      gameId: '5278155',
    );
    Ceckinternet();
  }

  bool isLoaded = false;

  unityloadad(int getammount) async {
    int a = getammount * 10;
    setState(() {});

    http.Response response = await http.put(
        Uri.parse('https://fogcash.nextonebox.com/UpdateLuckeySpin'),
        body: {
          'Email': email.toString(),
          'LuckeySpin': 1.toString(),
          'Ballance': a.toString(),
        });
    if (response.reasonPhrase == 'OK') {
      SendAllData();
      Timer(const Duration(seconds: 3), () {
        setState(() {});
      });
    }

    localballance!.put(0, localballance!.get(0) + a);

    setState(() {
      showMessage.show(
          context, 'You won your reward, it take time to update balance');
    });
  }

  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List items = [200, 60, 80, 50, 10, 20, 10, 30];
  List item = [200, 30, 60, 10, 80, 20, 50, 10];

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
            'Luckey Spin - ✅ Earn ₹750 daily \n Get Withdrawal in 1 minute',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
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
                  child: Text('₹ ${user.get(0)['LuckeySpin'] * 10}',
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      )),
                ),
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
                              items[7].toString(),
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
                            color: Colors.orangeAccent, borderWidth: 1),
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
                              items[6].toString(),
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
                            color: Colors.black, borderWidth: 1),
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
                      FortuneItem(
                        style: const FortuneItemStyle(
                            color: Colors.orangeAccent, borderWidth: 1),
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
                            color: Color.fromARGB(255, 22, 124, 213),
                            borderWidth: 1),
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
                    ],
                    onAnimationEnd: () {
                      setState(() {
                        rewards = item[selected.value];
                        unityloadad(item[selected.value]);
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
                                      child: Text('You Win : ₹$rewards Rupees',
                                          style: texSty),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: MaterialButton(
                                            onPressed: () {
                                              UnityAds.load(
                                                placementId: 'Rewarded_Android',
                                              );
                                              UnityAds.showVideoAd(
                                                placementId: 'Rewarded_Android',
                                              );
                                              Navigator.pop(context, true);
                                              setState(() {
                                                showMessage.show(context,
                                                    'Your reward added to wallet');
                                              });
                                            },
                                            height: 50,
                                            minWidth: 120,
                                            color: MainColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: const Text('Claim',
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

                    if (user.get(0)['LuckeySpin'] > 0) {
                      playSound('win');
                      setState(() {
                        selected.add(Fortune.randomInt(4, item.length));
                      });
                    } else {
                      SendAllData();
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
