import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:mugcash/ComonScreens/widgets.dart';
import 'package:quantupi/quantupi.dart';
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
  void buySuperSpin(BuildContext context, String MYmessage) {
    paymentkro() async {
      Quantupi zupi = Quantupi(
        receiverUpiId: 'nextonebox.95618657@sbi',
        receiverName: 'NextOneBox',
        transactionRefId: '',
        transactionNote: '${user.get(0)['Name']}',
        amount: 79,
      );
      final response = await zupi.startTransaction();
      List<String> keyValuePairs = response.split('&');
      for (String pair in keyValuePairs) {
        List<String> keyValuePair = pair.split('=');
        String key = keyValuePair[0];
        String value = keyValuePair[1];
        if (key == "Status") {
          if (value == 'SUCCESS') {
            http.Response response = await http.put(
                Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'),
                body: {
                  'Email': email.toString(),
                  'JackPot': 'true',
                });
            if (response.reasonPhrase == 'OK') {
              SendAllData();
            }
            setState(() {
              QuickAlert.show(
                context: context,
                title: 'SUCCES',
                type: QuickAlertType.success,
                text: 'Congratulation you are upgraded please restart the app',
              );
              SendAllData();

              payint();
            });
          } else {
            setState(() {
              QuickAlert.show(
                context: context,
                title: 'Failed',
                type: QuickAlertType.error,
                text: 'If you have paid please contact us',
              );
            });
          }
          break;
        }
      }
    }

    QuickAlert.show(
      context: context,
      title: 'Unlock Super Spin at just ₹79 for LifeTime!',
      type: QuickAlertType.confirm,
      text:
          '\n✅High Earning earn ₹4 - ₹20 per spin\n✅Earn Daily ₹300 by unlocking super spin.\n Dont miss the big earning opportunity.\n ✅50k+ users are already earning by unlocking Superspin',
      confirmBtnText: 'Unlock',
      onConfirmBtnTap: () {
        paymentkro();
        Navigator.of(
          context,
        ).pop('dialog');
      },
      cancelBtnText: 'cancel',
      onCancelBtnTap: () {
        Navigator.of(
          context,
        ).pop('dialog');

        showMessage.show(context, '😔You are losing something');
      },
      confirmBtnColor: Colors.green,
    );
  }

  payint() async {
    await http
        .post(Uri.parse('https://fogcash.nextonebox.com/ContactUs'), body: {
      'message': "$email",
    });
  }

  Ceckinternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showMessage.show(context, 'Please check your internet connection');
    }
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

  unityloadad(int getammount) async {
    int a = getammount;
    UnityAds.load(
      placementId: 'Rewarded_Android',
    );
    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) async {
        await http.put(
            Uri.parse('https://fogcash.nextonebox.com/UpdateBallance'),
            body: {
              'Email': email.toString(),
              'Ballance': a.toString(),
            });
        int clicks = adsbox!.get(17)['SuperSpinCount'];
        localballance!.put(0, localballance!.get(0) + a);
        adsbox!.put(17, {'SuperSpinCount': clicks - 1});
        adsbox!.put(18, {'SuperSpinLastClickOn': DateTime.now()});
        setState(() {
          showMessage.show(context,
              'Your reward added to wallet\n it take time to update balance');
        });
      },
    );
  }

  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List items = [200, 150, 100, 80, 70, 60, 50, 40];

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
            ' Super Spin',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
                            Text(
                              items[1].toString(),
                              style: const TextStyle(
                                fontSize: 30,
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
                            Text(
                              items[2].toString(),
                              style: const TextStyle(
                                fontSize: 30,
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
                            Text(
                              items[3].toString(),
                              style: const TextStyle(
                                fontSize: 30,
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
                            Text(
                              items[4].toString(),
                              style: const TextStyle(
                                fontSize: 30,
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
                            Text(
                              items[5].toString(),
                              style: const TextStyle(
                                fontSize: 30,
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
                            Text(
                              items[6].toString(),
                              style: const TextStyle(
                                fontSize: 30,
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
                            Container(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/coin.png'),
                            ),
                            Text(
                              items[7].toString(),
                              style: const TextStyle(
                                fontSize: 30,
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
                                      child: Text('You Win :🪙$rewards ',
                                          style: texSty),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Center(
                                        child: MaterialButton(
                                            onPressed: () {
                                              unityloadad(
                                                  items[selected.value]);
                                              setState(() {});
                                              Navigator.pop(context, true);
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
                    UnityAds.load(
                      placementId: 'Rewarded_Android',
                    );

                    if (user.get(0)['JackPot'] == 'true') {
                      int clicks = adsbox!.get(17)['SuperSpinCount'];
                      dynamic lastclick =
                          adsbox!.get(18)['SuperSpinLastClickOn'];
                      DateTime presenttime = DateTime.now();
                      Duration difference = presenttime.difference(lastclick);
                      if (clicks <= 0) {
                        if (difference.inHours > 24) {
                          playSound('win');
                          setState(() {
                            selected.add(Fortune.randomInt(4, items.length));
                          });
                          adsbox!.put(17, {'SuperSpinCount': 10});
                          adsbox!.put(
                              18, {'SuperSpinLastClickOn': DateTime.now()});
                        } else {
                          print(clicks);
                          showMessage.show(context,
                              '$clicks You have reach your daily limit\nYou get 10 Super spin per day \n next spin available after 24 hours');
                        }
                      } else {
                        playSound('win');
                        setState(() {
                          selected.add(Fortune.randomInt(4, items.length));
                        });
                      }
                    } else {
                      SendAllData();
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
