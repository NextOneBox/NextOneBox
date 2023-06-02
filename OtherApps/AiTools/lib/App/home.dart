// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'package:MyChatAi/App/image.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:MyChatAi/OtherFiles/history.dart';
import 'package:MyChatAi/OtherFiles/widgets.dart';
import 'package:MyChatAi/App/chat.dart';
import 'package:MyChatAi/App/voic.dart';
import 'package:http/http.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../OtherFiles/openpay.dart';
import '../OtherFiles/premium.dart';
import '../OtherFiles/widgets.dart' as widgets;

RewardedAd? _rewardedAd;
int _numRewardedLoadAttempts = 0;

runadd() {
  dynamic lastclick = adsbox!.get(3)['lastclick'];
  DateTime presenttime = DateTime.now();
  Duration difference = presenttime.difference(lastclick);
  int clicks = adsbox!.get(4)['clicks'];
  int coin = coins!.get(1);

  RewardedAd.load(
      adUnitId: 'ca-app-pub-5816602993651380/6983137677',
      request: AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _rewardedAd = ad;
            _rewardedAd?.show(onUserEarnedReward: (ad, reward) async {
              adsbox!.put(4, {'clicks': clicks + 1});
              coins!.put(1, coin + 1);
              _rewardedAd?.fullScreenContentCallback =
                  FullScreenContentCallback(
                      onAdShowedFullScreenContent: (ad) {},
                      onAdFailedToShowFullScreenContent: (ad, err) {
                        ad.dispose();
                      },
                      onAdDismissedFullScreenContent: (ad) {
                        ad.dispose();
                      });
            });
          },
          onAdFailedToLoad: (LoadAdError error) {}));
}

dynamic newb = [
  {
    "image":
        "https://firebasestorage.googleapis.com/v0/b/nextonebox-d7c0a.appspot.com/o/weew.png?alt=media&token=b450409c-9c44-45da-9abb-028b16fe916d",
    "url": "https://play.google.com/store/apps/details?id=com.nextonebox.games",
    "name": "ChatGptAi"
  },
  {
    "image":
        "https://firebasestorage.googleapis.com/v0/b/nextonebox-d7c0a.appspot.com/o/we.jpg?alt=media&token=61201def-0dc3-4562-a5d0-0c7b949b9992",
    "url":
        "https://play.google.com/store/apps/details?id=com.nextonebox.earnmoney",
    "name": "ChatGptAi"
  }
];

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  prevusad() {
    AwesomeDialog(
        context: context,
        animType: AnimType.scale,
        dialogType: DialogType.success,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Try MyChatAi best ai app\n Ai image , Voice assistant, Ai Chat \n A ChatGpt product.',
            ),
          ),
        ),
        keyboardAware: true,
        btnOkText: "Try now",
        padding: const EdgeInsets.all(5.0),
        btnCancelOnPress: () {},
        btnOkOnPress: () async {
          var url =
              'https://play.google.com/store/apps/details?id=com.nextonebox.mychatai';
          if (await canLaunch(url)) {
            await launch(url);
          }
        }).show();
  }

  widthraw() {
    AwesomeDialog(
            context: context,
            animType: AnimType.scale,
            dialogType: DialogType.success,
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'You need minimum 400 coins to withdraw \n 2 coin = 1 rupees',
                ),
              ),
            ),
            keyboardAware: true,
            padding: const EdgeInsets.all(5.0),
            btnCancelOnPress: () {},
            btnOkOnPress: () async {})
        .show();
  }

  //how to change widget after ever 10  seconds
  SpeechToText speechToText = SpeechToText();
  var isListening = false;
  String? get url => null;
  BannerAd? _ad;
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();

    BannerAd(
      adUnitId: 'ca-app-pub-5816602993651380/9025974949',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _ad = ad as BannerAd;
            isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  var iconclor = MainColor;
  var visi = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Card(
              color: BackColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                      var url = 'https://www.facebook.com/nextonebox';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.facebook,
                      size: 20,
                      color: PrColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var url = 'https://www.youtube.com/@nextonebox';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.youtube,
                      size: 20,
                      color: PrColor,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        var url = 'https://www.nextonebox.com/';
                        if (await canLaunch(url)) {
                          await launch(url);
                        }
                      },
                      icon: Image.asset(
                        'assets/next.png',
                        fit: BoxFit.fill,
                      )),
                  IconButton(
                    onPressed: () async {
                      var url = 'https://www.instagram.com/nextonebox/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                    icon: Icon(
                      FontAwesomeIcons.instagram,
                      size: 20,
                      color: PrColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.twitter,
                      size: 20,
                      color: PrColor,
                    ),
                    onPressed: () async {
                      var url = 'https://twitter.com/NextOneBox';
                      if (await canLaunch(url)) {
                        await launch(url);
                      }
                    },
                  ),
                ],
              ),
            ),
            isLoaded
                ? Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: AdWidget(ad: _ad!),
                  )
                : const SizedBox(),
            Center(
              child: Container(
                margin: EdgeInsets.all(6),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VoiceScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: MainColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/voice.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Card(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                width: 100,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: MainColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                    child: Text(
                                  ' Ai Voice ',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        prevusad();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: MainColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/aiimage.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Card(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                width: 100,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: MainColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                    child: Text(
                                  ' Ai Image ',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.all(6),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatPage()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: MainColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/chat.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Card(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                width: 100,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: MainColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                    child: Text(
                                  ' Ai Chat ',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => History()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: MainColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: AssetImage('assets/weq.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Card(
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 50),
                                width: 100,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: MainColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Center(
                                    child: Text(
                                  ' History ',
                                  style: TextStyle(color: Colors.white),
                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                prevusad();
              },
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  color: MainColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  image: DecorationImage(
                    image: AssetImage('assets/pro.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 100,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Center(
                                child: Text(
                              'Ad free',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                dynamic lastclick = adsbox!.get(3)['lastclick'];
                DateTime presenttime = DateTime.now();
                Duration difference = presenttime.difference(lastclick);
                int clicks = adsbox!.get(4)['clicks'];
                int coin = coins!.get(1);
                if (clicks == 15) {
                  if (difference.inMinutes > 5) {
                    runadd();
                    adsbox!.put(4, {'clicks': 0});
                    adsbox!.put(3, {'lastclick': DateTime.now()});
                  } else {
                    {
                      showMessage(context,
                          'Please Try after  ${5 - difference.inMinutes} Minutes');
                    }
                  }
                } else {
                  runadd();

                  setState(() {});
                }
              },
              child: Card(
                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              'Coins   ${coins!.get(1)}\n',
                              style: TextStyle(
                                  color: MainColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            Container(
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: Center(
                                  child: Text(
                                'Get coins ',
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            Text(
                              '\nWatch ads to get free coins',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                            Text(
                              ' \n Powered by ChatGPT',
                              style:
                                  TextStyle(color: Colors.amber, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.book,
                            color: Colors.amber,
                          ),
                          Text(
                            '    Get any answer from any \n    book, google, blog and\n    other source in seconds',
                            style: texSty,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.image,
                            color: Colors.amber,
                          ),
                          Text(
                            '   Generate imagination image to real \n   Create thumbnail, logo, icon, etc.',
                            style: texSty,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.pen,
                            color: Colors.amber,
                          ),
                          Text(
                            '  Ai write email / script / code / jokes \n / blog post / story etc.',
                            style: texSty,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.question_mark_rounded,
                            color: Colors.amber,
                          ),
                          Text(
                            '   Get personalized answers \n   Make your life easy with ai',
                            style: texSty,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      height: 1,
                      width: 300,
                      color: MainColor,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: Text('Ai tools'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 20,
                color: BackColor,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Earning App :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://play.google.com/store/apps/details?id=com.nextonebox.earnmoney';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/em.png')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Content Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.copy.ai/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/copyai.jpg')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'http://articoolo.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/articoolo.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://www.jasper.ai/?jredirect=true';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/jasper.png')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Image Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.midjourney.com';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/midjourney.jpeg')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://deepai.org/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/deepai.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://www.shutterstock.com/generate';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/shutter.png')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Video Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.steve.ai/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/steveai.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://lumen5.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/lumes.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://animoto.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/animoto.png')),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Audio Ai :  '),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url =
                                    'https://www.shutterstock.com/discover/ampermusic?ref=Welcome.AI';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/shutter.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://mubert.com/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/mubert.png')),
                          IconButton(
                              iconSize: 35,
                              onPressed: () async {
                                var url = 'https://www.aiva.ai/';
                                if (await canLaunch(url)) {
                                  await launch(url);
                                }
                              },
                              icon: Image.asset('assets/oiva.png')),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () => widthraw(),
              child: Container(
                width: 100,
                height: 25,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Center(
                    child: Text(
                  'Send coins ',
                  style: TextStyle(color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
