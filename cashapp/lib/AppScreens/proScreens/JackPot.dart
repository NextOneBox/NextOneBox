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
      showMessage.show(context, 'Please check your internet connection');
    }
  }

  void buySuperSpin(BuildContext context, String MYmessage) {
    QuickAlert.show(
      context: context,
      title: 'Unlock Super Spin at just ₹69',
      type: QuickAlertType.confirm,
      text:
          'Earn Daily ₹600 by unlocking super spin. Dont miss the big earning opportunity. many users are already earning by unlocking superspin',
      confirmBtnText: 'Unlock',
      onConfirmBtnTap: () {
        Navigator.of(
          context,
        ).pop('dialog');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Pay(
                    link: 'https://cosmofeed.com/vp/64a9543f61b8cb002a744103',
                    price: 69.0,
                    type: 'JackPot',
                  )),
        );
      },
      cancelBtnText: 'cancel',
      onCancelBtnTap: () {
        Navigator.of(
          context,
        ).pop('dialog');

        showMessage.show(context, '😔You are losing out ₹1000');
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

  unityloadad(int getammount) async {
    int a = getammount;
    await http
        .put(Uri.parse('https://fogcash.nextonebox.com/UpdateBallance'), body: {
      'Email': email.toString(),
      'Ballance': a.toString(),
    });

    http.Response response = await http
        .put(Uri.parse('https://fogcash.nextonebox.com/UpdateAccount'), body: {
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
      showMessage.show(context,
          'Your reward added to wallet\n it take time to update balance');
    });
  }

  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List items = [900, 800, 400, 150, 100, 200, 300, 100];
  List item = [900, 100, 800, 300, 400, 200, 150, 100];
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
            ' Super Spin -- ✅ Earn ₹500 daily \n Get Withdrawal in 1 minute',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
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
                              items[7].toString(),
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
                              items[6].toString(),
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
                                      child: Text('You Win :🪙$rewards ',
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
                                              setState(() {
                                                showMessage.show(context,
                                                    'Your reward added to wallet');
                                              });
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
                      playSound('win');
                      setState(() {
                        selected.add(Fortune.randomInt(4, items.length));
                      });
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
