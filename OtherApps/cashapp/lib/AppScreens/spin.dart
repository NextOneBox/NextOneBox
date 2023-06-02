
import 'package:audioplayers/audioplayers.dart';
import 'package:cashapp/ComonScreens/widgets.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';




class SpinWheel extends StatefulWidget {
  SpinWheel({Key? key}) : super(key: key);

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
  playSound(soundname) async {
     await _player.play(UrlSource('assets/Sounds/${soundname}.mp3'));

  }

  @override
  void initState() {
    super.initState();

    UnityAds.init(
      gameId: '5278155',
    );
    UnityAds.load(
      placementId: 'Rewarded_Android',
      onComplete: (placementId) => print('Load Complete $placementId'),
      onFailed: (placementId, error, message) =>
          print('Load Failed $placementId: $error $message'),
    );
    Ceckinternet();
  
  }

 
  bool isLoaded = false;
  int _numRewardedLoadAttempts = 0;
 
  unityloadad(int getammount) async {
    UnityAds.load(
        placementId: 'Rewarded_Android',
        onFailed: (placementId, error, message) =>
            showMessage(context, 'Failed to load ad.'));

    int clicks = adsbox!.get(4)['clicks'];
    int Ballance = localballance!.get(0);
    int newBall = (Ballance + getammount);

    UnityAds.showVideoAd(
      placementId: 'Rewarded_Android',
      onStart: (placementId) => print('Video Ad $placementId started'),
      onClick: (placementId) => print('Video Ad $placementId click'),
      onSkipped: (placementId) => print('Video Ad $placementId skipped'),
      onComplete: (placementId) async {
        localballance!.put(0, newBall);
        http.Response resp = await http.post(
            Uri.parse(
                'https://www.nextonebox.com/earnmoney/NotGetUrls/UpdateBallanceNew'),
            body: {
              'email': email.toString(),
              'Ballance': getammount.toString(),
            });
        adsbox!.put(4, {'clicks': clicks + 1});
        adsbox!.put(3, {'lastclick': DateTime.now()});

        setState(() {
          showWining(context, '');
        });
      },
      onFailed: (placementId, error, message) =>
          print('Video Ad $placementId failed: $error $message'),
    );
  }

  final selected = BehaviorSubject<int>();

  int rewards = 0;

  List items = [3, 5, 6, 8, 7, 4];
  // dynamic spincoin;
  var allcoin = 0;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    if (0 == null) {
      allcoin = 0;
    } else {
      allcoin = 0;
    }
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: SecondaryColor,
          elevation: 0,
          title: Text(
            'Spin & Win',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          )),
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border(
                    bottom: BorderSide(color: MainColor),
                    top: BorderSide(color: MainColor),
                    left: BorderSide(color: MainColor),
                    right: BorderSide(color: MainColor),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Text('${localballance!.get(0)} Coins',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    )),
              ),
            ),
            SizedBox(
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
                      style: FortuneItemStyle(
                          color: Color.fromARGB(255, 128, 233, 132),
                          borderWidth: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[0].toString(),
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Image.asset(
                            'assets/coin.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    FortuneItem(
                      style:
                          FortuneItemStyle(color: Colors.black, borderWidth: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[1].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Image.asset(
                            'assets/coin.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    FortuneItem(
                      style: FortuneItemStyle(
                          color: Color.fromARGB(255, 101, 141, 175),
                          borderWidth: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[2].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Image.asset(
                            'assets/coin.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    FortuneItem(
                      style: FortuneItemStyle(
                          color: Color.fromARGB(255, 240, 80, 80),
                          borderWidth: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[3].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Image.asset(
                            'assets/coin.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    FortuneItem(
                      style: FortuneItemStyle(
                          color: Color.fromARGB(255, 78, 201, 181),
                          borderWidth: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[4].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Image.asset(
                            'assets/coin.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                    FortuneItem(
                      style: FortuneItemStyle(
                          color: Color.fromARGB(255, 216, 195, 56),
                          borderWidth: 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            items[5].toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Image.asset(
                            'assets/coin.png',
                            height: 50,
                          ),
                        ],
                      ),
                    ),
                  ],
                  onAnimationEnd: () {
                    setState(() {
                      rewards = items[selected.value];
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Container(
                              child: AlertDialog(
                                actions: [
                                  SizedBox(height: 10),
                                  Center(
                                      child: Text('Congratulation..!',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontWeight: FontWeight.w300,
                                              color: MainColor))),
                                  Center(
                                      child: Container(
                                    width: 150,
                                    height: 150,
                                    child: Image(
                                        image: AssetImage('assets/congr.webp')),
                                  )),
                                  Center(
                                    child: Text(
                                        'You Win : ' +
                                            rewards.toString() +
                                            ' Coin',
                                        style: texSty),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                      child: MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                            unityloadad(items[selected.value]);
                                          },
                                          height: 50,
                                          minWidth: 120,
                                          color: MainColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: Text('Watch Ad to CLAIM',
                                              style: TextStyle(
                                                  color: Colors.white)))),
                                  SizedBox(
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
            SizedBox(
              height: 70,
            ),
            
            Container(
              // padding: EdgeInsets.only(top: 3, left: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.yellow),
                    top: BorderSide(color: Colors.yellow),
                    left: BorderSide(color: Colors.yellow),
                    right: BorderSide(color: Colors.yellow),
                  )),
              child: MaterialButton(
                onPressed: () {
                  UnityAds.load(
                    placementId: 'Rewarded_Android',
                    onComplete: (placementId) =>
                        print('Load Complete $placementId'),
                    onFailed: (placementId, error, message) =>
                        print('Load Failed $placementId: $error $message'),
                  );
                  playSound('win');
                  dynamic lastclick = adsbox!.get(3)['lastclick'];
                  DateTime presenttime = DateTime.now();
                  Duration difference = presenttime.difference(lastclick);
                  int clicks = adsbox!.get(4)['clicks'];

                  if (EMPremium == 'true') {
                    setState(() {
                      selected.add(Fortune.randomInt(0, items.length));
                    });
                  } else {
                    if (clicks == 10) {
                      if (difference.inHours > 24) {
                        setState(() {
                          selected.add(Fortune.randomInt(0, items.length));
                        });
                        adsbox!.put(4, {'clicks': 0});
                        adsbox!.put(3, {'lastclick': DateTime.now()});
                      } else {
                        buyMessage(context, '');

                        {
                          showMessage(context,
                              'Next spin available at : ${23 - difference.inHours} Hours');
                        }
                      }
                    } else {
                      setState(() {
                        selected.add(Fortune.randomInt(0, items.length));
                      });
                    }
                  }
                },
                color: MainColor,
                child: Text('Spin',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                elevation: 10,
                height: 50,
                minWidth: 120,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ],
        ),
      ),
      // ),
    );
  }
}
